--BD_FUNDACION

----------------------------------------------------------------


USE [BD_FUNDACION]
GO

/****** Object:  Table [dbo].[Customer]    Script Date: 25/08/2023 16:18:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Name] [varchar](100) NOT NULL,
	[Customer_LastName] [varchar](100) NULL,
	[Customer_document] [varchar](50) NOT NULL,
	[Customer_doctype] [int] NULL,
	[Customer_Email] [varchar](150) NULL,
	[Customer_phone] [varchar](30) NULL,
	[Customer_movil] [varchar](30) NULL,
	[Customer_city] [varchar](100) NULL,
	[Customer_address] [varchar](500) NULL,
	[Registration] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_Registration]  DEFAULT (getdate()) FOR [Registration]
GO

ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_DocType] FOREIGN KEY([Customer_doctype])
REFERENCES [dbo].[DocType] ([ID])
GO

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_DocType]
GO





-----------------------------------------------------
USE [BD_FUNDACION]
GO

/****** Object:  Table [dbo].[DocType]    Script Date: 25/08/2023 16:23:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DocType](
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


-------------------------------------------------------------------------

USE [BD_FUNDACION]
GO

/****** Object:  Table [dbo].[Transaction]    Script Date: 25/08/2023 16:23:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Transaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id] [int] NOT NULL,
	[Ref_payco] [varchar](250) NOT NULL,
	[Description_Transaction] [varchar](250) NOT NULL,
	[Amount] [numeric](11, 2) NOT NULL,
	[Currency_code] [varchar](250) NOT NULL,
	[Transaction_id] [int] NOT NULL,
	[Transaction_date] [datetime] NOT NULL,
	[Cod_transaction_state] [int] NOT NULL,
	[Transaction_state] [varchar](250) NOT NULL,
	[Customer_ip] [varchar](250) NOT NULL,
	[Extra1] [varchar](100) NULL,
	[Extra2] [varchar](100) NULL,
	[Extra3] [varchar](100) NULL,
	[Registration] [datetime] NOT NULL,
	[Processed] [bit] NOT NULL,
	[DateProcessed] [datetime] NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_Registration]  DEFAULT (getdate()) FOR [Registration]
GO

ALTER TABLE [dbo].[Transaction] ADD  CONSTRAINT [DF_Transaction_Processed]  DEFAULT ((0)) FOR [Processed]
GO

ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD  CONSTRAINT [FK_Transaction_Customer] FOREIGN KEY([Customer_id])
REFERENCES [dbo].[Customer] ([ID])
GO

ALTER TABLE [dbo].[Transaction] CHECK CONSTRAINT [FK_Transaction_Customer]
GO


---------------------------------------------------------------------------------------



ALTER TABLE dbo.Customer ADD CONSTRAINT [FK_Customer_DocType] FOREIGN KEY(Customer_doctype) REFERENCES [dbo].[DocType] ([ID])

ALTER TABLE dbo.Transaccion ADD CONSTRAINT [FK_Transaccion_Customer] FOREIGN KEY(Customer_id) REFERENCES [dbo].[Customer] ([ID])



-----------------------------


--permisos 


USE [master]
GO
CREATE LOGIN [usr_fundacion] WITH PASSWORD=N'56rb%q5@XsL@9jds%ZDD', 
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
GRANT INSERT,UPDATE,SELECT ON Transaction TO usr_fundacion
GRANT INSERT,UPDATE,SELECT ON Customer TO usr_fundacion
GRANT SELECT ON DocType TO usr_fundacion

USE [BD_FUNDACION]
GO
GRANT INSERT,UPDATE,SELECT ON Customer TO usr_fundacion

---script general
