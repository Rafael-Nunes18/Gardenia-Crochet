

CREATE DATABASE GardeniaCrochet;
USE GardeniaCrochet;



CREATE TABLE Cliente(
ID_Cliente INT PRIMARY KEY IDENTITY,
NomeCompleto VARCHAR(85) NOT NULL,
Email VARCHAR(200) UNIQUE NOT NULL,
Senha VARBINARY(320) NOT NULL,
Telefone VARCHAR(14) NULL
);


CREATE TABLE CategoriaProduto(
ID_CategoriaProduto INT PRIMARY KEY IDENTITY,
NomeCategoria VARCHAR(56) NOT NULL
);


CREATE TABLE Produto(
ID_Produto INT PRIMARY KEY IDENTITY,
Nome VARCHAR(78) NOT NULL,
Preco DECIMAL(10,2)  NOT NULL,
Estoque INT NOT NULL,
ID_CategoriaProduto INT CONSTRAINT F_K_CategoriaProduto FOREIGN KEY(ID_CategoriaProduto) REFERENCES CategoriaProduto(ID_CategoriaProduto)
);


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



CREATE TABLE Pedido(
ID_Pedido INT PRIMARY KEY IDENTITY,
DataHoraPedido DATETIME NOT NULL DEFAULT GETDATE(),
StatusPedido VARCHAR(25) NOT NULL CHECK (StatusPedido IN('Pedido Confirmado','Em Transporte','Entregue','Cancelado','Devolvido')),
ID_Cliente INT CONSTRAINT F_K_Cliente FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID_Cliente),
ID_Endereco INT CONSTRAINT F_K_Endereco FOREIGN KEY(ID_Endereco) REFERENCES Endereco(ID_Endereco)
);



CREATE TABLE Pagamento(
ID_Pagamento INT PRIMARY KEY IDENTITY,
CPF VARCHAR(14) NOT NULL,
FormaPagamento VARCHAR(25) NOT NULL,
ValorGasto DECIMAL(10,2) NOT NULL,
DataHora DATETIME DEFAULT GETDATE(),
ID_Pedido INT CONSTRAINT F_K_Pedido FOREIGN KEY(ID_Pedido) REFERENCES Pedido(ID_Pedido)
);




CREATE TABLE ItensPedidos (
ID_ItensPedidos INT PRIMARY KEY IDENTITY,
ID_Pedido INT NOT NULL,
ID_Produto INT NOT NULL,
Quantidade INT NOT NULL DEFAULT 1,
PrecoUnitario DECIMAL(10,2) NOT NULL,
CONSTRAINT F_K_ItensPedidos_Pedido FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
CONSTRAINT F_K_ItensPedidos_Produtos FOREIGN KEY (ID_Produto) REFERENCES Produto(ID_Produto)
);




