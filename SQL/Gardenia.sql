
CREATE DATABASE GardeniaCrochet;
USE GardeniaCrochet;


CREATE TABLE Endereco(
ID_Endereco INT PRIMARY KEY IDENTITY,
CEP VARCHAR(9) NOT NULL,
Rua VARCHAR(86) NOT NULL,
Complemento VARCHAR(10) NULL,
Municipio VARCHAR(45) NOT NULL,
Estado VARCHAR(5) NOT NULL
);



CREATE TABLE Cliente(
ID_Cliente INT PRIMARY KEY IDENTITY,
Nome VARCHAR(75) NOT NULL,
Telefone VARCHAR(15) NOT NULL,
Email VARCHAR(86) UNIQUE NOT NULL,
CPF VARCHAR(14) UNIQUE NOT NULL,
ID_Endereco INT CONSTRAINT F_K_Endereco FOREIGN KEY(ID_Endereco) REFERENCES Endereco(ID_Endereco)
);



CREATE TABLE Pedido(
ID_Pedido INT PRIMARY KEY IDENTITY,
DataPedido DATE NOT NULL,
StatusPagamento VARCHAR(25) NOT NULL CHECK (StatusPagamento IN('Pagamento Aprovado','Pagamento Não Aprovado','Pagamento Pendente')),
ID_Cliente INT CONSTRAINT F_K_Cliente FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE
);


CREATE TABLE Produto(
ID_Produto INT PRIMARY KEY IDENTITY,
Nome VARCHAR(78) NOT NULL,
Preco DECIMAL(10,2)  NOT NULL,
CategoriaProduto VARCHAR(75) NOT NULL CHECK(CategoriaProduto IN('Bolsas e mochilas','Acessorios de moda','Roupas em Croche'))
);


CREATE TABLE ProdutoPedido (
  ID_ProdutoPedido INT PRIMARY KEY IDENTITY,
  ID_Pedido INT NULL,
  ID_Produto INT NOT NULL,
  Quantidade INT NOT NULL DEFAULT 1,
  ValorTotal DECIMAL(10,2) NOT NULL,
  StatusProduto VARCHAR(25) NOT NULL CHECK (StatusProduto IN('No carrinho','Pedido feito','A Caminho','Entregue')),
  CONSTRAINT F_K_Pedido FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido) ON DELETE CASCADE,
  CONSTRAINT F_K_Produto FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);








CREATE TABLE Auditoria_ProdutoPedido(
ID_LogCliente INT PRIMARY KEY IDENTITY,
UsuarioResponsavel VARCHAR(45),
DataHora DATETIME,
TipoEvento VARCHAR(20) CHECK(TipoEvento IN('Insert','Update','Delete')),
ID_ProdutoPedido INT,
ID_Pedido INT,
ID_Produto INT,
StatusProduto VARCHAR(25) NOT NULL CHECK (StatusProduto IN('No Carrinho','Pedido feito','A Caminho','Entregue'))
);







CREATE TRIGGER trg_ProdutoPedido_Insert
ON ProdutoPedido
AFTER INSERT
AS
BEGIN

    INSERT INTO Auditoria_ProdutoPedido(UsuarioResponsavel,DataHora,TipoEvento, ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(),GETDATE(),'Insert', ID_Pedido, ID_Produto, StatusProduto
    FROM INSERTED 
END;










CREATE TRIGGER trg_ProdutoPedido_Update
ON ProdutoPedido
AFTER UPDATE
AS
BEGIN

    INSERT INTO Auditoria_ProdutoPedido(UsuarioResponsavel,DataHora,TipoEvento, ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(),GETDATE(),'Update', ID_Pedido, ID_Produto, StatusProduto
    FROM INSERTED 
END;











CREATE TRIGGER trg_ProdutoPedido_Delete
ON ProdutoPedido
AFTER DELETE
AS
BEGIN

    INSERT INTO Auditoria_ProdutoPedido(UsuarioResponsavel,DataHora,TipoEvento, ID_Pedido, ID_Produto, StatusProduto)
    SELECT SUSER_NAME(), GETDATE(),'Delete', ID_Pedido, ID_Produto, StatusProduto
    FROM DELETED
END;















CREATE PROCEDURE CadastrarEndereco
    @CEP VARCHAR(9),
    @Rua VARCHAR(86),
    @Complemento VARCHAR(10),
    @Municipio VARCHAR(45),
    @Estado VARCHAR(5)
AS 
BEGIN
  IF EXISTS(SELECT 1 FROM Endereco WHERE CEP = @CEP AND Rua = @Rua)
    BEGIN
        RAISERROR('Endereço já cadastrado.', 16, 1);
        RETURN;
    END

    INSERT INTO Endereco (CEP, Rua, Complemento,Municipio,Estado)
    VALUES (@CEP, @Rua, @Complemento,@Municipio, @Estado);
END;










CREATE PROCEDURE CadastrarCliente

@Nome VARCHAR(75),
@Telefone VARCHAR(15),
@Email VARCHAR(86),
@CPF VARCHAR(14),
@ID_Endereco INT

AS 
BEGIN

IF EXISTS(SELECT 1 FROM Cliente WHERE CPF = @CPF)
    BEGIN
    RAISERROR('Cliente já cadastrado com este CPF.', 16, 1);
    RETURN;
  END

INSERT INTO Cliente(Nome, Telefone, Email, CPF, ID_Endereco)
VALUES(@Nome, @Telefone, @Email, @CPF, @ID_Endereco)
END;












CREATE PROCEDURE CadastrarPedido
@Data_Pedido DATE,
@ID_Cliente INT,
@StatusPagamento VARCHAR(25)

AS
BEGIN
IF NOT EXISTS(SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
BEGIN
RAISERROR('Não é possivel encontrar o cliente', 16,1)
RETURN;
END

IF @StatusPagamento NOT IN ('Pagamento Aprovado','Pagamento Não Aprovado','Pagamento Pendente')
    BEGIN
        RAISERROR('Status de pagamento inválido', 16, 1);
        RETURN;
    END

INSERT INTO Pedido(Data_Pedido,ID_Cliente,StatusPagamento) VALUES
(@Data_Pedido,@ID_Cliente,@StatusPagamento)
END;

