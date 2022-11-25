USE `sgos`;

-- Cidades
insert into cidade (nome, uf) values ('Belo Horizonte','MG');
insert into cidade (nome, uf) values ('Lagoa Santa','MG');
insert into cidade (nome, uf) values ('Betim','MG');
insert into cidade (nome, uf) values ('Brasília','DF');
insert into cidade (nome, uf) values ('São Paulo','SP');
insert into cidade (nome, uf) values ('Rio de Janeiro','RJ');
insert into cidade (nome, uf) values ('Itajaí','SC');

-- Fabricante
insert into fabricante (nome) values ('Volkswagem');
insert into fabricante (nome) values ('Fiat');
insert into fabricante (nome) values ('Ford');
insert into fabricante (nome) values ('Chevrolet');

-- Especialidade
insert into especialidade (descricao) values ('ar-condicionado');
insert into especialidade (descricao) values ('amortecedor');
insert into especialidade (descricao) values ('mecânica');
insert into especialidade (descricao) values ('retífica');
insert into especialidade (descricao) values ('elétrica');

-- equipe
insert into equipe (nome) values ('Avante');
insert into equipe (nome) values ('Alea jacta est');
insert into equipe (nome) values ('Conserto');
insert into equipe (nome) values ('Revisão');

-- Veiculo
insert into veiculo (placa, idfabricante, modelo, ano_fabricacao, ano_modelo) values ('XZ00001',1, 'Fusca', 2000, 2001);
insert into veiculo (placa, idfabricante, modelo, ano_fabricacao, ano_modelo) values ('XTO0106', 2, 'Uno', 1995, 1995);
insert into veiculo (placa, idfabricante, modelo, ano_fabricacao, ano_modelo) values ('GMP0101',3, 'Ranger', 2015, 2016);
insert into veiculo (placa, idfabricante, modelo, ano_fabricacao, ano_modelo) values ('GMP0606', 4, 'Opala', 1985, 1986);
insert into veiculo (placa, idfabricante, modelo, ano_fabricacao, ano_modelo) values ('GXX0102', 4, 'Caravan', 1980, 1980);
 
-- Cliente
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('Maria João','Física','100.614.650-46','Rua das Amoras, 45/102',1,'30.865-500');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('João Maria','Física','962.841.430-52','Rua das Aboboras, 69',2,'30.860-500');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('ACME','Jurídica','08.218.457/0001-89','Rua dos Abacaxis, 1/80',3,'30.869-500');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('Wanner Bros','Jurídica','84.769.802/0001-50','Rua das Beterrabas, 180',4,'30.869-500');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('Dante Alighieri ','Física','158.489.540-38','Círculo 7',5,'66.600-000');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('João Silva','Física','140.345.690-93','Rua das Amoras, 42',1,'30.865-500');
insert into cliente (nome, tipo_identificacao, identificacao, endereco, idcidade, cep)
 values ('João Souza','Física','560.718.780-20','Rua dos Aflitos, 40',1,'30.865-600');
 
insert into veiculo_cliente(idcliente, idveiculo) values (1,1);
insert into veiculo_cliente(idcliente, idveiculo) values (2,2);
insert into veiculo_cliente(idcliente, idveiculo) values (3,3);
insert into veiculo_cliente(idcliente, idveiculo) values (4,4);
insert into veiculo_cliente(idcliente, idveiculo) values (6,5);

-- mecanico
insert into mecanico (nome, endereco, cep, idcidade, idespecialidade, idequipe)
 values ('Eufrasino','Rua das Margaridas, 55','30.865-500',1,1,1);
insert into mecanico (nome, endereco, cep, idcidade, idespecialidade, idequipe)
 values ('Pernalonga','Rua dos Cravos, 11','30.500-865',1,2,1);
insert into mecanico (nome, endereco, cep, idcidade, idespecialidade, idequipe)
 values ('Frajola','Rua das Rosas, 22','30.665-900',2,3,2);

-- peca
insert into peca (nome, valor_unitario) values ('Rebimboca',2.34);
insert into peca (nome, valor_unitario) values ('Parafuseta',205);
insert into peca (nome, valor_unitario) values ('Mangueira',5.50);
insert into peca (nome, valor_unitario) values ('Ventoinha',12.34);
insert into peca (nome, valor_unitario) values ('Braçadeira',10);
insert into peca (nome, valor_unitario) values ('Parafuso 1/2',0.84);
insert into peca (nome, valor_unitario) values ('Parafuso 1/8',0.84);
insert into peca (nome, valor_unitario) values ('Parafuso 1/10',0.84);

-- servico
insert into servico (descricao, valor_unitario, idespecialidade) values ('Troca filtro ar-condicionado',10, 1);
insert into servico (descricao, valor_unitario, idespecialidade) values ('Troca ar-condicionado',100, 1);
insert into servico (descricao, valor_unitario, idespecialidade) values ('Troca amortecedor',80, 2);
insert into servico (descricao, valor_unitario, idespecialidade) values ('Troca correia',80, 3);
insert into servico (descricao, valor_unitario, idespecialidade) values ('Troca parafuso',50, 4);
insert into servico (descricao, valor_unitario, idespecialidade) values ('Revisão parte-elétrica',150, 5);

-- O.S.
insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente)
values ( 1, '2022-11-30', null, 'Pendente','Conserto',1,1,'Não liga mais quando compro sorvete de baunilha');

insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente)
values ( 1, '2022-12-10', null, 'Pendente','Revisão',2,2,'Ar quente esfria, ar gelado esquenta');

insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente, observacoes_equipe)
values ( 2, '2022-11-10', '2022-11-11', 'Aprovado','Conserto',3,3,'Motor rateando','Serviço realizado');

insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente)
values ( 2, '2022-11-09', '2022-11-10', 'Cancelado','Conserto',4,4,'Motor afogando');

insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente,
 acrescimo)
values ( 3, '2022-11-08', '2022-11-10', 'Pendente','Revisão', 4, 4,'Motor morreu', 1.50);

insert into ordem_servico (idequipe, data_previsao_conclusao, data_conclusao, status_os, tipo_os, idcliente, idveiculo, descricao_cliente,
 desconto)
values ( 4, '2022-12-01', '2022-12-10', 'Pendente','Revisão', 3, 3,'Motor morreu de vez', 0.25);

-- 
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (1, 1, 10, 1);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (1, 2, 90, 1);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (2, 2, 100, 1);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (3, 4, 80, 2);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (4, 5, 10, 5);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (5, 1, 10, 5);
insert into servico_ordem_servico (idordem_servico, idservico, valor_unitario_venda, quantidade) values (6, 2, 90, 1);
--
insert into peca_ordem_servico (idordem_servico, idpeca, valor_unitario_venda, quantidade, data_substituicao)
values (1, 1, 2.34, 3, '2022-11-24');

insert into peca_ordem_servico (idordem_servico, idpeca, valor_unitario_venda, quantidade, data_substituicao)
values (2, 2, 234, 1, '2022-11-20');

insert into peca_ordem_servico (idordem_servico, idpeca, valor_unitario_venda, quantidade, data_substituicao)
values (3, 3, 9, 1, null);

insert into peca_ordem_servico (idordem_servico, idpeca, valor_unitario_venda, quantidade, data_substituicao)
values (4, 5, 9.5, 2, null);
