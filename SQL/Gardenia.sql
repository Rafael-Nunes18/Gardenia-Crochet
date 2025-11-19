

CREATE DATABASE GardeniaCrochet;
USE GardeniaCrochet;


CREATE TABLE Endereco(
ID_Endereco INT PRIMARY KEY IDENTITY,
Rua VARCHAR(86) NOT NULL,
Numero INT NOT NULL,
Complemento VARCHAR(20) NULL,
Bairro VARCHAR(45) NOT NULL,
CEP VARCHAR(9) NOT NULL,
Municipio VARCHAR(45) NOT NULL,
Estado CHAR(2) NOT NULL,
CONSTRAINT UQ_Endereco UNIQUE (Rua, Numero, Complemento, Bairro, CEP, Municipio, Estado)
);




CREATE TABLE Cliente(
ID_Cliente INT PRIMARY KEY IDENTITY,
NomeCompleto VARCHAR(85) NOT NULL,
Email VARCHAR(200) UNIQUE NOT NULL,
SenhaHash VARBINARY(32) NOT NULL,
Telefone VARCHAR(14) NOT NULL,
CPF VARCHAR(14) UNIQUE NOT NULL,
ID_Endereco INT CONSTRAINT F_K_Endereco FOREIGN KEY(ID_Endereco) REFERENCES Endereco(ID_Endereco)
);


CREATE TABLE CategoriaProduto(
ID_CategoriaProduto INT PRIMARY KEY IDENTITY,
NomeCategoria VARCHAR(56) NOT NULL
);


CREATE TABLE Produto(
ID_Produto INT PRIMARY KEY IDENTITY,
Nome VARCHAR(78) NOT NULL,
Preco DECIMAL(10,2)  NOT NULL,
ID_CategoriaProduto INT CONSTRAINT F_K_CategoriaProduto FOREIGN KEY(ID_CategoriaProduto) REFERENCES CategoriaProduto(ID_CategoriaProduto)
);




CREATE TABLE Pedido(
ID_Pedido INT PRIMARY KEY IDENTITY,
DataHoraPedido DATETIME NOT NULL DEFAULT GETDATE(),
StatusPedido VARCHAR(25) NOT NULL CHECK (StatusPedido IN('Aguardando Pagamento','Concluido','Em Transporte','Enviado','Cancelado')),
ID_Cliente INT CONSTRAINT F_K_Cliente FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente)
);


CREATE TABLE Pagamento(
ID_Pagamento INT PRIMARY KEY IDENTITY,
StatusPagamento VARCHAR(35) CHECK (StatusPagamento IN ('Pendente', 'Aprovado', 'Recusado','Estornado')),
FormaPagamento VARCHAR(25),
ValorGasto DECIMAL(10,2),
DataHora DATETIME DEFAULT GETDATE(),
ID_Pedido INT CONSTRAINT F_K_Pedido FOREIGN KEY(ID_Pedido) REFERENCES Pedido(ID_Pedido)
);




CREATE TABLE ItensCarrinho (
ID_ItemCarrinho INT IDENTITY PRIMARY KEY,
ID_Cliente INT NOT NULL,
ID_Produto INT NOT NULL,
Quantidade INT NOT NULL DEFAULT 1 CHECK (Quantidade > 0),
PrecoUnitario DECIMAL(10,2) NOT NULL CHECK (PrecoUnitario >= 0),
CONSTRAINT FK_ItensCarrinho_Cliente FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
CONSTRAINT FK_ItensCarrinho_Produto FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);



CREATE TABLE ItensPedidos (
ID_ItensPedidos INT PRIMARY KEY IDENTITY,
ID_Pedido INT NOT NULL,
ID_Produto INT NOT NULL,
Quantidade INT NOT NULL DEFAULT 1,
PrecoUnitario DECIMAL(10,2) NOT NULL,
StatusProduto VARCHAR(25) NOT NULL CHECK (StatusProduto IN('Pedido Confirmado','Em Transporte','Entregue','Cancelado','Devolvido')),
CONSTRAINT F_K_ItensPedidos_Pedido FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
CONSTRAINT F_K_ItensPedidos_Produtos FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);



CREATE TABLE Auditoria_ItensPedidos(
ID_LogCliente INT PRIMARY KEY IDENTITY,
UsuarioResponsavel VARCHAR(45),
DataHora DATETIME,
TipoEvento VARCHAR(20) CHECK(TipoEvento IN('Insert','Update','Delete')),
ID_ItensPedidos INT,
ID_Pedido INT,
ID_Produto INT,
StatusProduto VARCHAR(25) NOT NULL CHECK (StatusProduto IN('Pedido Confirmado','Em Transporte','Entregue','Cancelado','Devolvido'))
);





CREATE TRIGGER trg_ItensPedidos_Insert
ON ItensPedidos
AFTER INSERT
AS
BEGIN

    INSERT INTO Auditoria_ItensPedidos(UsuarioResponsavel,DataHora,TipoEvento, ID_ItensPedidos, ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(),GETDATE(),'Insert', ID_ItensPedidos , ID_Pedido, ID_Produto, StatusProduto
    FROM INSERTED 
END;










CREATE TRIGGER trg_ItensPedidos_Update
ON ItensPedidos
AFTER UPDATE
AS
BEGIN

    INSERT INTO Auditoria_ItensPedidos(UsuarioResponsavel,DataHora,TipoEvento, ID_ItensPedidos, ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(),GETDATE(),'Update', ID_ItensPedidos ,ID_Pedido, ID_Produto, StatusProduto
    FROM INSERTED 
END;











CREATE TRIGGER trg_ItensPedidos_Delete
ON ItensPedidos
AFTER DELETE
AS
BEGIN

    INSERT INTO Auditoria_ItensPedidos(UsuarioResponsavel,DataHora,TipoEvento, ID_ItensPedidos,  ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(), GETDATE(),'Delete', ID_ItensPedidos, ID_Pedido, ID_Produto, StatusProduto
    FROM DELETED
END;













CREATE PROCEDURE CadastrarEndereco
    @Rua VARCHAR(86),
    @Numero INT,
    @Complemento VARCHAR(20),
    @Bairro Varchar(45),
    @CEP VARCHAR(9),
    @Municipio VARCHAR(45),
    @Estado CHAR(2)
AS 
BEGIN
  IF EXISTS(SELECT 1 FROM Endereco WHERE CEP = @CEP AND Rua = @Rua AND Numero = @Numero AND Bairro = @Bairro)
    BEGIN
        RAISERROR('Endereço já cadastrado.', 16, 1);
        RETURN 1;
    END

    INSERT INTO Endereco (Rua, Numero, Complemento, Bairro, CEP, Municipio, Estado)
    VALUES (@Rua, @Numero, @Complemento, @Bairro, @CEP, @Municipio, @Estado);
    RETURN 0;
END;










CREATE PROCEDURE CadastrarCliente

@NomeCompleto VARCHAR(85),
@Email VARCHAR(200),
@HashSenha VARCHAR(500),
@AlgoSenha VARCHAR(50),
@Telefone VARCHAR(14),
@CPF VARCHAR(14),
@ID_Endereco INT

AS 
BEGIN

IF EXISTS(SELECT 1 FROM Cliente WHERE CPF = @CPF)
    BEGIN
    RAISERROR('Cliente já cadastrado com este CPF.', 16, 1);
    RETURN 1;
  END

INSERT INTO Cliente(NomeCompleto, Email, HashSenha, AlgoSenha, Telefone, CPF, ID_Endereco)
VALUES(@NomeCompleto, @Email, @HashSenha, @AlgoSenha, @Telefone, @CPF, @ID_Endereco);
RETURN 0;
END;











CREATE PROCEDURE CadastrarPedido
@StatusPedido VARCHAR(25),
@ID_Cliente INT

AS
BEGIN
IF NOT EXISTS(SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
BEGIN
RAISERROR('Não é possivel encontrar o cliente', 16,1)
RETURN 1;
END


INSERT INTO Pedido(StatusPedido, ID_Cliente) VALUES
(@StatusPedido, @ID_Cliente);
RETURN 0;
END;
