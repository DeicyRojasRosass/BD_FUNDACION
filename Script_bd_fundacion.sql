--BD_FUNDACION



USE BD_FUNDACION
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Transaccion(
	ID INT IDENTITY(1,1) NOT NULL,
	Customer_id INT NOT NULL,
	Ref_payco VARCHAR(250) NOT NULL,
	Description_Transaction VARCHAR(250) NOT NULL,
	Amount [numeric](11, 2) NOT NULL,
	Currency_code  VARCHAR(250) NOT NULL,
	Transaction_id INT NOT NULL,
	Transaccion_date DATETIME NOT NULL,
	Cod_transaction_state INT NOT NULL,
	Transaction_state VARCHAR(250) NOT NULL,
	Customer_ip VARCHAR(250) NOT NULL,
	Extra1 INT,
	Extra2 INT,
	Extra3 INT,
	Registration DATETIME NOT NULL,
	Processed BIT NOT NULL,
	DateProcessed DATETIME NULL,
 CONSTRAINT [PK_Transaccion] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Transaccion] ADD  CONSTRAINT [DF_Transaccion_Registration]  DEFAULT (getdate()) FOR [Registration]
GO

ALTER TABLE [dbo].[Transaccion] ADD  CONSTRAINT [DF_Transaccion_Processed]  DEFAULT ((0)) FOR [Processed]
GO


----------------------------------------------------------------


USE [BD_FUNDACION]
GO

/****** Object:  Table [dbo].[Contacto]    Script Date: 15/08/2023 11:29:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.Customer(
	ID INT IDENTITY(1,1) NOT NULL,
	Customer_Name VARCHAR(100) NOT NULL,
	Customer_LastName VARCHAR(100) NULL,
	Customer_document VARCHAR(50) NOT NULL,
	Customer_doctype INT NULL,
	Customer_Email VARCHAR(150) NULL,
	Customer_phone VARCHAR(30) NULL,
	Customer_movil VARCHAR(30) NULL,
	Customer_city VARCHAR(100) NULL,
	Customer_address VARCHAR(500) NULL,
	Registration DATETIME NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_Registration]  DEFAULT (getdate()) FOR [Registration]
GO



-----------------------------------------------------

USE [BD_FUNDACION]
GO

/****** Object:  Table [dbo].[TipoIdentificacion]    Script Date: 15/08/2023 11:55:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE dbo.DocType(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type_document] [varchar](50) NOT NULL,
	[alias] [varchar](5) NULL,
	[Active] [bit] NOT NULL,
	[Registration] [datetime] NOT NULL,
 CONSTRAINT [PK_DocType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DocType] ADD  CONSTRAINT [DF_DocType_Active]  DEFAULT ((1)) FOR [Active]
GO


ALTER TABLE [dbo].[DocType] ADD  CONSTRAINT [DF_DocType_Registration]  DEFAULT (getdate()) FOR [Registration]
GO




ALTER TABLE dbo.Customer ADD CONSTRAINT [FK_Customer_DocType] FOREIGN KEY(Customer_doctype) REFERENCES [dbo].[DocType] ([ID])

ALTER TABLE dbo.Transaccion ADD CONSTRAINT [FK_Transaccion_Customer] FOREIGN KEY(Customer_id) REFERENCES [dbo].[Customer] ([ID])



-----------------------------


--permisos 

USE [master]
GO
CREATE LOGIN [usr_fundacion] WITH PASSWORD=N'56rb$q5@XsL@9jds$ZDD', 
DEFAULT_DATABASE=[BD_FUNDACION], DEFAULT_LANGUAGE=[Español], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO

USE [BD_FUNDACION]
CREATE USER [usr_fundacion] FOR LOGIN [usr_fundacion]
GO
USE [BD_FUNDACION]
GO
ALTER USER [usr_fundacion] WITH DEFAULT_SCHEMA=[dbo]
GO

USE [BD_FUNDACION]
GO
GRANT INSERT,UPDATE,SELECT ON Transaccion TO usr_fundacion
GRANT INSERT,UPDATE,SELECT ON Customer TO usr_fundacion
GRANT SELECT ON DocType TO usr_fundacion

USE [BD_FUNDACION]
GO
GRANT INSERT,UPDATE,SELECT ON Customer TO usr_fundacion

---script general