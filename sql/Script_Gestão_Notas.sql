create database gestao_financeira_mkt;

use gestao_financeira_mkt;

CREATE TABLE dFornecedor (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Codigo_Fornecedor VARCHAR(255) NULL,
    Nome_Fantasia VARCHAR(255) NULL,
	Razao_Social VARCHAR(255) NULL,
    Area VARCHAR(255) NULL,
    Categoria VARCHAR(255) NULL,
    Subcategoria VARCHAR(255) NULL,
	CNPJ_CPF VARCHAR(255) NULL,
    Identificacao VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL INFILE 'C:/bd_MySQL/dFornecedor.csv'
INTO TABLE dFornecedor
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@ID_temp, @Codigo_Fornecedor_tmp, @Nome_Fantasia_tmp, @Razao_Social_tmp, @Area_tmp, @Categoria_temp, @Subcategoria_temp, @CNPJ_CPF_tmp, @Identificacao_tmp)
SET 
	ID = @ID_temp,
	Codigo_Fornecedor = @Codigo_Fornecedor_tmp,
    Nome_Fantasia = @Nome_Fantasia_tmp,
    Razao_Social = @Razao_Social_tmp,
    Area = @Area_tmp,
    Categoria = @Categoria_temp,
    SubCategoria = @Subcategoria_temp,
    CNPJ_CPF = @CNPJ_CPF_tmp,
    Identificacao = @Identificacao_tmp;
    
    TRUNCATE TABLE dFornecedor;
    

CREATE TABLE dLaboratorio (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Estabelecimento VARCHAR(155) NULL,
    CNPJ VARCHAR(155),
    Municipio VARCHAR(155) NULL,
    UF VARCHAR(10) NULL,
    Regional VARCHAR(255) NULL,
    Razao_Social VARCHAR(255) NULL,
    Nome_Fantasia VARCHAR(255) NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL INFILE 'C:/bd_MySQL/dLaboratorio.csv'
INTO TABLE dLaboratorio
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ID, Estabelecimento, CNPJ, Municipio, UF, Regional, Razao_Social, Nome_Fantasia);


CREATE TABLE dContrato (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Est VARCHAR(10) NULL,
    Nro_Contrato BIGINT NULL,
    Descricao TEXT NULL,
    Codigo BIGINT NULL,
    Nome_Fantasia VARCHAR(100) NULL,
    CNPJ CHAR(18) NULL,
    Dt_Contrato DATE NULL,
    Dt_Termino DATE NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL INFILE 'C:/bd_MySQL/dContrato.csv'
INTO TABLE dContrato
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ID, Est, Nro_Contrato, Descricao, Codigo, Nome_Fantasia, CNPJ, @Dt_Contrato_temp, @Dt_Termino_temp)
SET Dt_Contrato = STR_TO_DATE(@Dt_Contrato_temp, '%d/%m/%Y'),
Dt_Termino = str_to_date(@Dt_Termino_temp, '%d/%m/%Y');


CREATE TABLE fNotas (
	ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    Tipo VARCHAR(50),
    CNPJ_Sabin_temp VARCHAR(50) NULL,
    Nro_Datasul_temp VARCHAR(255) NULL,
    Setor_Responsavel VARCHAR(255) NULL,
    Nro_Danfe VARCHAR(255) NULL,
    ID_dLaboratorio INT NULL,
    Cod_Estab_temp VARCHAR(255) NULL,
    Dt_Emissao DATE NULL,
    Dt_Vencimento DATE NULL,
    Competencia_Nota VARCHAR(50),
    Valor DECIMAL (18,2) NULL,
	Total_Parcelas INT NULL,
    ID_dFornecedor INT NULL,
    Fornecedor_Cod_temp VARCHAR(50) NULL,
    Fornecedor_CNPJ_temp VARCHAR(50) NULL,
    Fornecedor_RazaoSocial_temp VARCHAR(255) NULL,
    Fornecedor_NomeFantasia_temp VARCHAR(255) NULL,
    Status_Nota VARCHAR(255),
    Aprovado_Sistema VARCHAR(50),
	Forma_Pagamento VARCHAR(255) NULL,
    Area_temp VARCHAR(255) NULL,
    Categoria VARCHAR(255) NULL,
    SubCategoria VARCHAR(255) NULL,
    Local_Pagamento VARCHAR(255) NULL,
    Local_Recebimento VARCHAR(255) NULL,
    Responsavel VARCHAR(50) NULL,
    Observacao TEXT NULL,
    Protocolo DATE NULL,
    
    fk_Fornecedor_ID INT NULL,
    fk_Laboratorio_ID INT NULL,
    fk_Contrato_ID INT NULL,
    
    CONSTRAINT FK_Notas_Fornecedor FOREIGN KEY (fk_Fornecedor_ID) REFERENCES dFornecedor(ID),
	CONSTRAINT FK_Notas_Laboratorio FOREIGN KEY (fk_Laboratorio_ID) REFERENCES dLaboratorio(ID),
	CONSTRAINT FK_Notas_Contrato FOREIGN KEY (fk_Contrato_ID) REFERENCES dContrato(ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE INDEX idx_Fornecedor ON fNotas (fk_Fornecedor_ID);
CREATE INDEX idx_Laboratorio ON fNotas (fk_Laboratorio_ID);
CREATE INDEX idx_Contrato ON fNotas (fk_Contrato_ID);
CREATE INDEX idx_Dt_Emissao ON fNotas (Dt_Emissao);
CREATE INDEX idx_Dt_Vencimento ON fNotas (Dt_Vencimento);

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/bd_MySQL/fNotas.csv'
INTO TABLE fnotas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(@Coluna16339, @Mes, @REFERENCIA, @ID_dContrato_temp, Tipo, CNPJ_Sabin_temp, @PI_OC, Nro_Datasul_temp, Setor_Responsavel, Nro_Danfe, Cod_Estab_temp, @Dt_Emissao_temp, @Dt_Vencimento_temp, 
Competencia_Nota, @Valor_temp, @Total_Parcelas_temp, Fornecedor_Cod_temp, Fornecedor_CNPJ_temp, Fornecedor_RazaoSocial_temp, Fornecedor_NomeFantasia_temp, Status_Nota, 
Aprovado_Sistema, Forma_Pagamento, @Centro_de_Custo, @Conta_Contabil, Area_temp, Categoria, SubCategoria, Local_Pagamento, Local_Recebimento, Responsavel, Observacao, @Protocolo_temp, 
@Descricao_Datasul, @Data_Inicio, @Data_Fim, @Dias, @Contagem_Regr, @Range, @VALIDACAO, @GrafCast, @Material, @Qty, @BANCO, @AGENCIA, @CONTA_CORRENTE, @OPERACAO,
@CONTAS_A_PAGAR, @indexador, @Sede_Reg)
SET Valor = REPLACE(REPLACE(REPLACE(NULLIF(@Valor_temp, ''), 'R$ ', ''), '.', ''), ',', '.'),
Total_Parcelas = NULLIF(@Total_Parcelas_temp, ''),
Dt_Emissao = IF(@Dt_Emissao_temp = '', NULL, STR_TO_DATE(@Dt_Emissao_temp, '%d/%m/%Y')),
Dt_Vencimento = IF(@Dt_Vencimento_temp = '', NULL, STR_TO_DATE(@Dt_Vencimento_temp, '%d/%m/%Y')),
Protocolo = IF(@Protocolo_temp = '', NULL, STR_TO_DATE(@Protocolo_temp, '%d/%m/%Y'));


    