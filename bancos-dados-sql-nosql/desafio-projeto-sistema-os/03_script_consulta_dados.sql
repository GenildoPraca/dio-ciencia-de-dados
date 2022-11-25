-- Recuperações simples com SELECT Statement;
select * from cliente;

-- Filtros com WHERE Statement;
select * from cliente where tipo_identificacao = 'Física';
select * from cliente where tipo_identificacao = 'Jurídica';

-- Crie expressões para gerar atributos derivados;
-- valor total da O.S. bruto e líquido a partir dos itens
 select
 a.idordem_servico,
 sum(ifnull(b.valor_unitario_venda * b.quantidade,0) + ifnull(c.valor_unitario_venda * c.quantidade, 0)) vlr_bruto,
 a.acrescimo, a.desconto,
 sum(ifnull(b.valor_unitario_venda * b.quantidade,0) + ifnull(c.valor_unitario_venda * c.quantidade, 0) + a.acrescimo - a.desconto) vlr_liquido
  from ordem_servico a
  left join peca_ordem_servico b
	on a.idordem_servico = b.idordem_servico
  left join servico_ordem_servico c
    on a.idordem_servico = c.idordem_servico
 where a.status_os <> 'Cancelado'
 group by a.idordem_servico, a.acrescimo, a.desconto;
 
-- Defina ordenações dos dados com ORDER BY;
select b.nome Fabricante, a.modelo, a.placa
  from veiculo a
 inner join fabricante b
    on a.idfabricante = b.idfabricante
 order by 1;
 
-- Condições de filtros aos grupos – HAVING Statement;
select count(1), b.Nome
  from cliente a
 inner join cidade b
    on a.idCidade = b.idCidade
 group by b.Nome
 having count(1) > 1;
 
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
select a.nome, b.data_cadastro, c.placa, d.nome fabricante, c.modelo, e.status_os, ifnull(e.idordem_servico,'SEM O.S') 'O.S.'
  from cliente a
 inner join veiculo_cliente b
    on a.idcliente = b.idcliente
 inner join veiculo c
    on b.idveiculo = c.idveiculo
 inner join fabricante d
    on c.idfabricante = d.idfabricante
  left join ordem_servico e
    on b.idcliente = e.idcliente
   and b.idveiculo = e.idveiculo;
    
-- clientes que possuem O.S. pendentes
select count(1)
  from cliente a
 inner join ordem_servico b
    on a.idCliente = b.idCliente
 where b.Status_OS = 'Pendente';
 
-- clientes, veiculos x O.S. canceladas
select b.nome, c.placa, a.idordem_servico 
  from ordem_servico a
 inner join cliente b
   on a.idcliente = b.idcliente
 inner join veiculo c
    on a.idveiculo = c.idveiculo
 where a.status_os = 'Cancelado';
 
-- Testando trigger criada para impedir inclusão indevida - DEVE ocorrer erro
insert into veiculo_cliente(idcliente, idveiculo) values (5,5);