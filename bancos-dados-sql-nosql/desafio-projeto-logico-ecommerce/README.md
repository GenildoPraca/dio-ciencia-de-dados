# Refinamento de um sistema e-commerce
### Desafio: Construindo seu Primeiro Projeto Lógico de Banco de Dados
#### Observações gerais
A partir do modelo original proposto durante o curso foi desenvolvido o modelo atual.

* Projeto desenvolvido no SGBD MySQL;
* Justificativa para algumas alterações:
    > Não foi utilizado o idioma Inglês na definição das tabelas e atributos como na demonstração porque já havia construído o projeto lógico utilizando o idioma Português;

    > Não foi criado o atributo "PaymentCash" na tabela Pedido, pois o mesmo pode ser identificado em "Pagamento_Pedido.Forma_de_Pagamento": Dinheiro;
    
    > Foi incluído um relacionamento entre as tabelas estoque_produto e produto_pedido para permitir a utilização de **triggers** para controlar a quantidade reservada de cada produto ao incluir/remover um produto no pedido;
    
    > Entidades que podem armazenar tanto dados de pessoas jurídicas (CNPJ) quanto de pessoas físicas (CPF) possuem dois campos: **tipo_pessoa** (Física/Jurídica) e **Identificação** que conterá o CPF ou CNPJ de acordo com o tipo escolhido. Esse desenho permite a criação de um índice único pelo campo identificação;
    
    > Os campos de CPF e CNPJ possuem um tamanho maior que o sugerido para permitir o armazenamento com a máscara correspondente.

#### Compõem esse projeto
* **e_commerce_refinado.png** - imagem do modelo lógico proposto;
* **01_script_criacao_base_dados.txt** - arquivo de script com os comandos sql necessários para a criação do banco de dados no SGBD MySQL;
* **02_script_popula_base_dados.txt** - arquivo de script para popular as tabelas com um pequeno volume de dados para testes de conceito;
* **03_script_consulta_dados.txt** - arquivo de script contendo consultas SQL solicitadas no desafio entre outras que julguei pertinentes;
* **e_commerce_refinado.mwb** - arquivo MySQL Workbench
