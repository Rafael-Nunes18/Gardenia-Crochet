CREATE DATABASE GardeniaCrochet;
USE GardeniaCrochet;


CREATE TABLE Endereço(
ID_Endereço INT NOT NULL PRIMARY KEY IDENTITY,
CEP VARCHAR(9) NOT NULL,
Rua NVARCHAR(86) NOT NULL,
Complemento NVARCHAR(10) ,
Estado NVARCHAR(5) NOT NULL
);


CREATE TABLE Cliente(
ID_Cliente INT PRIMARY KEY NOT NULL IDENTITY,
Nome VARCHAR(75) NOT NULL,
Telefone VARCHAR(15) NOT NULL,
Email NVARCHAR(86) UNIQUE NOT NULL,
CPF NVARCHAR(14) UNIQUE NOT NULL,
ID_Endereço INT,FOREIGN KEY(ID_Endereço) REFERENCES Endereço(ID_Endereço)
);


CREATE TABLE StatusPedido(
ID_Status INT PRIMARY KEY IDENTITY NOT NULL,
Status_Entrega NVARCHAR(35) NOT NULL
);



CREATE TABLE Categoria(
ID_Categoria INT PRIMARY KEY NOT NULL IDENTITY,
Nome VARCHAR(75) NOT NULL
);

CREATE TABLE Produto(
ID_Produto INT PRIMARY KEY IDENTITY NOT NULL,
Nome VARCHAR(78) NOT NULL,
Preço DECIMAL NOT NULL,
Estoque INT NOT NULL,
ID_Categoria INT FOREIGN KEY(ID_Categoria) REFERENCES Categoria(ID_Categoria)
);



CREATE TABLE Pedido(
ID_Pedido INT PRIMARY KEY IDENTITY NOT NULL,
Data_Pedido DATE NOT NULL,
ID_Cliente INT, FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
ID_Status INT,FOREIGN KEY(ID_Status) REFERENCES StatusPedido(ID_Status)
);

CREATE TABLE ProdutoPedido (
ID_Pedido INT NOT NULL,
ID_Produto INT NOT NULL,
Quantidade INT NOT NULL DEFAULT 1,
Preço_Unitario DECIMAL NOT NULL,
PRIMARY KEY (ID_Pedido, ID_Produto),
FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);


INSERT INTO Endereço(CEP,Rua,Complemento,Estado) VALUES
('05734-020', 'Rua das Camélias, 145', NULL, 'SP'),
('30180-002', 'Rua Santa Rita Durão, 320', 'Apto 302', 'MG'),
('22775-015', 'Rua Professor Hermes Lima, 55', 'Apto 102', 'RJ'),
('81530-000', 'Rua dos Pioneiros, 678', NULL, 'PR'),
('70658-150', 'Quadra CRS 506 Bloco B, 110', 'Apto 203', 'DF'),
('60192-250', 'Rua Desembargador Leite Albuquerque, 200', NULL, 'CE'),
('40295-260', 'Rua Silveira Martins, 90', 'Apto 101', 'BA'),
('69050-070', 'Rua Rio Javari, 47', NULL, 'AM'),
('88060-350', 'Rua das Gaivotas, 1120', 'Apto 401', 'SC'),
('66083-320', 'Rua dos Mundurucus, 890', NULL, 'PA');


INSERT INTO Cliente(Nome,Telefone,Email,CPF,ID_Endereço) VALUES
('Ana Paula da Silva','(11) 97645-3821', 'ana.silva@gmail.com',    '111.444.777-35', 1),
('Carlos Eduardo Ramos','(21) 98812-3476', 'carlos.ramos@yahoo.com', '527.316.498-28', 2),
('Juliana Rocha Lima','(31) 99421-6503', 'juliana.lima@outlook.com','839.205.671-02', 3),
('Marcos Vinícius Ferreira','(41) 99987-1102', 'marcos.ferreira@gmail.com','640.193.582-06', 4),
('Fernanda Oliveira Souza','(51) 98123-4470', 'fernanda.souza@hotmail.com','982.470.315-23', 5),
('Roberto Almeida Costa','(61) 98765-4320', 'roberto.costa@uol.com.br','314.579.086-20', 6),
('Tatiane Borges Santos','(71) 99833-2211', 'tatiane.santos@gmail.com', '756.028.439-65', 7),
('Felipe Andrade Melo','(81) 99123-0098', 'felipe.melo@bol.com.br',   '490.632.157-70', 8),
('Luciana Martins Dias','(91) 99234-5567', 'luciana.dias@gmail.com',   '203.847.569-56', 9),
('Renato Barbosa Pires','(31) 99540-2786', 'renato.pires@terra.com.br','678.451.320-71',10);


INSERT INTO StatusPedido(Status_Entrega) VALUES
('Pedido Recebido'),
('Separação de Itens'),
('Em Processamento'),
('Em Transporte'),
('Saiu para Entrega'),
('Entregue'),
('Aguardando Pagamento'),
('Pagamento Confirmado'),
('Cancelado'),
('Devolução Solicitada');



INSERT INTO Categoria(Nome) VALUES
('Amigurumis'),
('Roupas em Crochê'),
('Acessórios de Moda'),
('Decoração em Crochê'),
('Sousplats e Jogos Americanos'),
('Toalhas e Panos de Mesa'),
('Tapetes e Passadeiras'),
('Bolsas e Mochilas'),
('Infantil e Bebê'),
('Tapecarias e Fio conduzido'),
('Itens Personalizados');


INSERT INTO Produto(Nome,Preço,Estoque,ID_Categoria) VALUES
('Amigurumi Urso de Dormir', 55.90, 8, 1),
('Top Cropped de Crochê Boho', 75.00, 5, 2),
('Brinco de Crochê Floral', 12.50, 15, 3),
('Capa de Almofada em Crochê 40x40', 45.00, 12, 4),
('Jogo de Sousplats - 4 peças', 58.90, 6, 5),
('Trilho de Mesa Florido 1,5m', 79.90, 4, 6),
('Tapete Oval 1,20m x 0,60m', 69.90, 7, 7),
('Bolsa em Crochê com Alça de Madeira', 69.00, 3, 8),
('Sapatinho de Bebê com Laço', 19.90, 10, 9),
('Cesto Personalizado com Nome', 65.00, 2, 10),
('Tapecaria 15cm x 15cm', 40.30, 6, 10);



INSERT INTO Pedido(Data_Pedido,ID_Cliente,ID_Status) VALUES
('2025-09-01',1, 1),
('2025-09-03',2, 2),
('2025-09-05', 3, 4),
('2025-09-08', 4, 3),
('2025-09-10',5, 5),
('2025-09-12',6, 2),
('2025-09-15',7, 1),
('2025-09-18',8, 3),
('2025-09-20',9, 4),
('2025-09-22',10, 2);


INSERT INTO ProdutoPedido (ID_Pedido, ID_Produto, Quantidade, Preço_Unitario)
VALUES
(1, 1, 2, 55.90),
(1, 3, 1, 12.50),
(2, 2, 1, 75.00),
(2, 5, 2, 58.90),
(3, 4, 1, 45.00),
(3, 7, 3, 69.90),
(4, 8, 1, 69.00),
(4, 10, 2, 65.00),
(5, 9, 4, 19.90),
(5, 6, 1, 79.90);


CREATE TABLE Log_Cliente(
ID_LogCliente INT PRIMARY KEY IDENTITY,
ID_Cliente INT, CONSTRAINT f_k_Idcliente FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
DataInsercao DATE
);

CREATE TRIGGER trg_Cliente1
ON Cliente
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Log_Cliente (ID_Cliente, DataInsercao)
    SELECT ID_Cliente, DATEADD(HOUR, -3, SYSUTCDATETIME())
    FROM inserted;
END;

INSERT INTO Cliente(Nome,Telefone,Email,CPF,ID_Endereço) VALUES
('Rafael Toledo Nunes','(11) 98541-1716', 'rafael.nunes@gmail.com.br','472.581.246-61',10);

SELECT * FROM Log_Cliente;




CREATE PROCEDURE CadastrarEndereco_Cliente
    @CEP VARCHAR(9),
    @Rua NVARCHAR(86),
    @Complemento NVARCHAR(10),
    @Estado NVARCHAR(5)
AS 
BEGIN
    INSERT INTO Endereço (CEP, Rua, Complemento, Estado)
    VALUES (@CEP, @Rua, @Complemento, @Estado);
END;


EXEC CadastrarEndereco_Cliente 
'01311-200', 'Avenida Paulista', 'Apto 42B', 'SP';
    SELECT * FROM Endereço



CREATE PROCEDURE CadastrarCliente1

@Nome VARCHAR(75),
@Telefone VARCHAR(15),
@Email NVARCHAR(86),
@CPF NVARCHAR(14),
@ID_Endereço INT

AS 
BEGIN

INSERT INTO Cliente(Nome, Telefone, Email, CPF, ID_Endereço)
VALUES(@Nome, @Telefone, @Email, @CPF, @ID_Endereço)

END


EXEC CadastrarCliente1 'Kaique Bezerra', '(21) 99999-8787', 'kaique.b@gmail.com', '234.543.661-36', 11

SELECT * FROM Cliente;


CREATE PROCEDURE CadastrarPedido
@Data_Pedido DATE,
@ID_Cliente INT,
@ID_Status INT 
AS
BEGIN
IF NOT EXISTS(SELECT 1 FROM Cliente WHERE ID_Cliente = @ID_Cliente)
BEGIN
RAISERROR('Nao e possivel encontrar o cliente', 16,1)
RETURN;
END

IF @ID_Status NOT IN(1,2,3,4,5,6,7,8,9,10)
BEGIN
RAISERROR('nao foi possivel saber o status', 16, 1)
RETURN;
END 

INSERT INTO Pedido(Data_Pedido,ID_Cliente,ID_Status) VALUES
(@Data_Pedido, @ID_Cliente, @ID_Status)
END;

EXEC CadastrarPedido '2025-10-17', 4, 11
SELECT * FROM Pedido;

CREATE TABLE Carrinho(
ID_Carrinho INT PRIMARY KEY IDENTITY NOT NULL,
ID_Pedido INT CONSTRAINT f_k_pedido FOREIGN KEY(ID_Pedido) REFERENCES Pedido(ID_Pedido)

)
