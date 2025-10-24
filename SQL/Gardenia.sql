CREATE DATABASE GardeniaCrochet;
USE GardeniaCrochet;


CREATE TABLE Endereco(
ID_Endereco INT NOT NULL PRIMARY KEY IDENTITY,
CEP VARCHAR(9) NOT NULL,
Rua VARCHAR(86) NOT NULL,
Complemento VARCHAR(10),
Municipio VARCHAR(45) NOT NULL,
Estado VARCHAR(5) NOT NULL
);


CREATE TABLE Cliente(
ID_Cliente INT PRIMARY KEY NOT NULL IDENTITY,
Nome VARCHAR(75) NOT NULL,
Telefone VARCHAR(15) NOT NULL,
Email VARCHAR(86) UNIQUE NOT NULL,
CPF VARCHAR(14) UNIQUE NOT NULL,
ID_Endereco INT CONSTRAINT F_K_Endereco FOREIGN KEY(ID_Endereco) REFERENCES Endereco(ID_Endereco)
);



CREATE TABLE Pedido(
ID_Pedido INT PRIMARY KEY IDENTITY NOT NULL,
Data_Pedido DATE NOT NULL,
Valor_Total DECIMAL(10,2) NOT NULL,
ID_Cliente INT CONSTRAINT F_K_Cliente FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente)
);


CREATE TABLE Produto(
ID_Produto INT PRIMARY KEY IDENTITY NOT NULL,
Nome VARCHAR(78) NOT NULL,
Preco DECIMAL(10,2)  NOT NULL,
Categoria_Produto VARCHAR(75) NOT NULL CHECK(Categoria_Produto IN('Bolsas e mochilas','Acessorios de moda','Roupas em Croche'))
);


CREATE TABLE ProdutoPedido (
ID_Pedido INT NOT NULL,
ID_Produto INT NOT NULL,
Quantidade INT NOT NULL DEFAULT 1,
Status_Produto VARCHAR(25) NOT NULL CHECK (Status_Produto IN('Pedido feito','Pedido Não feito','Produto a caminho','Produto Entregue')),
PRIMARY KEY (ID_Pedido, ID_Produto),
CONSTRAINT F_K_Pedido FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
CONSTRAINT F_K_Produto FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);



/***********************TESTES************************************/
INSERT INTO Endereco(CEP,Rua,Complemento,Municipio,Estado) VALUES
('05734-020', 'Rua das Camélias, 145', NULL, 'São Paulo', 'SP'),
('30180-002', 'Rua Santa Rita Durão, 320', 'Apto 302', 'Belo Horizonte', 'MG'),
('22775-015', 'Rua Professor Hermes Lima, 55', 'Apto 102', 'Rio de Janeiro', 'RJ'),
('81530-000', 'Rua dos Pioneiros, 678', NULL, 'Curitiba', 'PR');


INSERT INTO Cliente(Nome,Telefone,Email,CPF,ID_Endereco) VALUES
('Ana Paula da Silva','(11) 97645-3821', 'ana.silva@gmail.com',    '111.444.777-35', 1),
('Carlos Eduardo Ramos','(21) 98812-3476', 'carlos.ramos@yahoo.com', '527.316.498-28', 2),
('Juliana Rocha Lima','(31) 99421-6503', 'juliana.lima@outlook.com','839.205.671-02', 3),
('Marcos Vinícius Ferreira','(41) 99987-1102', 'marcos.ferreira@gmail.com','640.193.582-06', 4);


INSERT INTO Produto(Nome,Preco,Categoria_Produto) VALUES
('Amigurumi Urso de Dormir', 55.90,'Roupas em Croche'),
('Top Cropped de Crochê Boho', 75.00,'Bolsas e mochilas'),
('Brinco de Crochê Floral', 12.50,'Acessorios de moda'),
('Capa de Almofada em Crochê 40x40', 45.00,'Bolsas e mochilas');


INSERT INTO Pedido(Data_Pedido, Valor_Total, ID_Cliente) VALUES
('2025-09-27', 233.44, 1),
('2025-09-29', 344.54, 2),
('2025-10-03', 278.90, 3),
('2025-10-09' , 265.87, 4);


INSERT INTO ProdutoPedido (ID_Pedido, ID_Produto, Quantidade, Status_Produto) VALUES
(1,1,1,'Pedido feito'),
(2,2,2,'Pedido Não feito'),
(3,3,3,'Produto a caminho'),
(4,4,4,'Produto Entregue');


/*****************TRRIGGERS**********************************************************/
CREATE TABLE Log_ProdutoPedido(
ID_LogCliente INT PRIMARY KEY IDENTITY,
DataHora DATETIME,
TipoEvento VARCHAR(20) CHECK(TipoEvento IN('Insert','Update','Delete')),
ID_Pedido INT,
ID_Produto INT,
Status_Produto VARCHAR(25) NOT NULL CHECK (Status_Produto IN('Pedido feito','Pedido Não feito','Produto a caminho','Produto Entregue'))
);


/*********TRIGGER 1***************/
CREATE TRIGGER trg_ProdutoPedido_Insert
ON ProdutoPedido
AFTER INSERT
AS
BEGIN

    INSERT INTO Log_ProdutoPedido(DataHora,TipoEvento, ID_Pedido, ID_Produto, Status_Produto)
    SELECT GETDATE(),'Insert', ID_Pedido, ID_Produto, Status_Produto
    FROM INSERTED 
END;





/*********TRIGGER 2*************/
CREATE TRIGGER trg_ProdutoPedido_Update
ON ProdutoPedido
AFTER UPDATE
AS
BEGIN

    INSERT INTO Log_ProdutoPedido(DataHora,TipoEvento, ID_Pedido, ID_Produto, Status_Produto)
    SELECT GETDATE(),'Update', ID_Pedido, ID_Produto, Status_Produto
    FROM INSERTED 
END;






/**************TRIGGER3**************/
CREATE TRIGGER trg_ProdutoPedido_Delete
ON ProdutoPedido
AFTER DELETE
AS
BEGIN

    INSERT INTO Log_ProdutoPedido(DataHora,TipoEvento, ID_Pedido, ID_Produto, Status_Produto)
    SELECT GETDATE(),'Delete', ID_Pedido, ID_Produto, Status_Produto
    FROM DELETED
END;



/****TESTES*********/
UPDATE ProdutoPedido SET Status_Produto = 'Pedido feito' WHERE ID_Pedido = 2 AND ID_Produto = 2;
DELETE ProdutoPedido WHERE ID_Pedido = 2 AND ID_Produto = 2;
SELECT * FROM ProdutoPedido;
SELECT * FROM Log_ProdutoPedido;









/***********************PROCEDURES***************************************/



/**********PROCEDURE1************/
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

EXEC CadastrarEndereco
'01311-200', 'Avenida Paulista', 'Apto 42B','São Paulo', 'SP';
    SELECT * FROM Endereco;









/**********PROCEDURE2**********/
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

EXEC CadastrarCliente 'Kaique Bezerra', '(21) 99999-8787', 'kaique.b@gmail.com', '234.543.661-36', 4
SELECT * FROM Cliente;











/************PROCEDURE3****************/
CREATE PROCEDURE CadastrarPedido
@Data_Pedido DATE,
@Valor_Total DECIMAL(10,2),
@ID_Cliente INT
AS
BEGIN
IF NOT EXISTS(SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
BEGIN
RAISERROR('Não é possivel encontrar o cliente', 16,1)
RETURN;
END


INSERT INTO Pedido(Data_Pedido,Valor_Total,ID_Cliente) VALUES
(@Data_Pedido,@Valor_Total, @ID_Cliente)
END;

EXEC CadastrarPedido '2025-10-17', 244.56, 4
SELECT * FROM Pedido;

