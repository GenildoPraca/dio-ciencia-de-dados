-- -----------------------------------------------------
-- Schema sgos
--
-- Sistema de gerenciamento de Ordens de Serviço (O.S.)
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sgos` DEFAULT CHARACTER SET utf8mb4 ;
USE `sgos` ;

-- -----------------------------------------------------
-- Table `sgos`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Cidade` (
  `idCidade` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(100) NOT NULL,
  `UF` ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') NOT NULL,
  PRIMARY KEY (`idCidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `tipo_identificacao` ENUM('Física', 'Jurídica') NOT NULL,
  `Identificacao` VARCHAR(20) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `idCidade` INT NOT NULL,
  `CEP` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Cidade_idx` (`idCidade` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Cidade`
    FOREIGN KEY (`idCidade`)
    REFERENCES `sgos`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Fabricante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Fabricante` (
  `idFabricante` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFabricante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `Placa` VARCHAR(45) NOT NULL,
  `idFabricante` INT NOT NULL,
  `Modelo` VARCHAR(45) NULL,
  `Ano_fabricacao` INT NULL,
  `Ano_modelo` INT NULL,
  PRIMARY KEY (`idVeiculo`),
  INDEX `fk_Veiculo_Fabricante_idx` (`idFabricante` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Fabricante`
    FOREIGN KEY (`idFabricante`)
    REFERENCES `sgos`.`Fabricante` (`idFabricante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Especialidade` (
  `idEspecialidade` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEspecialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Mecanico` (
  `idMecanico` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(10) NOT NULL,
  `idCidade` INT NOT NULL,
  `idEspecialidade` INT NOT NULL,
  `idEquipe` INT NOT NULL,
  PRIMARY KEY (`idMecanico`),
  INDEX `fk_Mecanicos_Especialidade_idx` (`idEspecialidade` ASC) VISIBLE,
  INDEX `fk_Mecanico_Equipe_idx` (`idEquipe` ASC) VISIBLE,
  INDEX `fk_Mecanico_Cidade_idx` (`idCidade` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanicos_Especialidade`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `sgos`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecanico_Equipe`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `sgos`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecanico_Cidade`
    FOREIGN KEY (`idCidade`)
    REFERENCES `sgos`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Veiculo_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Veiculo_Cliente` (
  `idCliente` INT NOT NULL,
  `idVeiculo` INT NOT NULL,
  `Data_cadastro` DATETIME NOT NULL default current_timestamp,
  `Data_fim` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`, `idVeiculo`),
  INDEX `fk_Veiculo_Cliente_Veiculo_idx` (`idVeiculo` ASC) INVISIBLE,
  INDEX `fk_Veiculo_Cliente_Cliente_idx` (`idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `sgos`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_Cliente_Veiculo`
    FOREIGN KEY (`idVeiculo`)
    REFERENCES `sgos`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Trigger para impedir dois clientes simultâneos para o mesmo veículo
-- -----------------------------------------------------
DELIMITER $
CREATE TRIGGER tbi_veiculo_cliente BEFORE INSERT
ON veiculo_cliente
FOR EACH ROW
BEGIN
    DECLARE v_count integer;
    SET @v_count := 
      (select count(1)
         from veiculo_cliente
		where idveiculo = NEW.idveiculo
          and data_fim is null);
    if @v_count > 0 then
        signal sqlstate '45000' set message_text = 'MyTriggerError: O veiculo possui outro proprietario ativo';
    end if;
END$
DELIMITER ;
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `sgos`.`Ordem_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Ordem_Servico` (
  `idOrdem_Servico` INT NOT NULL AUTO_INCREMENT,
  `idEquipe` INT NOT NULL,
  `Data_emissao` DATETIME NOT NULL DEFAULT current_timestamp,
  `Data_Previsao_conclusao` DATETIME NULL,
  `Data_conclusao` DATETIME NULL,
  `Acrescimo` FLOAT NOT NULL DEFAULT 0,
  `Desconto` FLOAT NOT NULL DEFAULT 0,
  `Status_OS` ENUM('Aprovado', 'Pendente', 'Cancelado') NOT NULL default 'Pendente',
  `Tipo_OS` ENUM('Conserto', 'Revisão') NOT NULL,
  `idCliente` INT NOT NULL,
  `idVeiculo` INT NOT NULL,
  `Descricao_cliente` VARCHAR(500) NULL,
  `Observacoes_equipe` VARCHAR(500) NULL,
  PRIMARY KEY (`idOrdem_Servico`),
  INDEX `fk_Ordem_Servico_Equipe_idx` (`idEquipe` ASC) VISIBLE,
  INDEX `fk_Ordem_Servico_Veiculo_Cliente_idx` (`idCliente` ASC, `idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Servico_Equipe`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `sgos`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_Servico_Veiculo_Cliente`
    FOREIGN KEY (`idCliente` , `idVeiculo`)
    REFERENCES `sgos`.`Veiculo_Cliente` (`idCliente` , `idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Peca` (
  `idPeca` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NULL,
  `Valor_unitario` FLOAT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Peca_Ordem_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Peca_Ordem_Servico` (
  `idPeca` INT NOT NULL,
  `idOrdem_Servico` INT NOT NULL,
  `Quantidade` INT NOT NULL DEFAULT 1,
  `Valor_unitario_venda` FLOAT NOT NULL DEFAULT 0,
  `Data_substituicao` DATETIME NULL,
  PRIMARY KEY (`idPeca`, `idOrdem_Servico`),
  INDEX `fk_Peca_Ordem_Servico_Ordem_Servico_idx` (`idOrdem_Servico` ASC) VISIBLE,
  INDEX `fk_Peca_Ordem_Servico_Peca_idx` (`idPeca` ASC) VISIBLE,
  CONSTRAINT `fk_Peca_Ordem_Servico_Peca`
    FOREIGN KEY (`idPeca`)
    REFERENCES `sgos`.`Peca` (`idPeca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peca_Ordem_Servico_Ordem_Servico`
    FOREIGN KEY (`idOrdem_Servico`)
    REFERENCES `sgos`.`Ordem_Servico` (`idOrdem_Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NOT NULL,
  `Valor_unitario` FLOAT NOT NULL DEFAULT 0,
  `idEspecialidade` INT NOT NULL,
  PRIMARY KEY (`idServico`),
  INDEX `fk_Servico_Especialidade_idx` (`idEspecialidade` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Especialidade`
    FOREIGN KEY (`idEspecialidade`)
    REFERENCES `sgos`.`Especialidade` (`idEspecialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgos`.`Servico_Ordem_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sgos`.`Servico_Ordem_Servico` (
  `idOrdem_Servico` INT NOT NULL,
  `idServico` INT NOT NULL,
  `Valor_unitario_venda` VARCHAR(45) NOT NULL DEFAULT 0,
  `Quantidade` INT NULL DEFAULT 1,
  PRIMARY KEY (`idOrdem_Servico`, `idServico`),
  INDEX `fk_Servico_Ordem_Servico_Servico_idx` (`idServico` ASC) VISIBLE,
  INDEX `fk_Servico_Ordem_Servico_Ordem_Servico_idx` (`idOrdem_Servico` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_Servico_has_Servico_Ordem_Servico1`
    FOREIGN KEY (`idOrdem_Servico`)
    REFERENCES `sgos`.`Ordem_Servico` (`idOrdem_Servico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_Ordem_Servico_Ordem_Servico`
    FOREIGN KEY (`idServico`)
    REFERENCES `sgos`.`Servico` (`idServico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;