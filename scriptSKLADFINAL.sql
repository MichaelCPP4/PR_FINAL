USE [master]
GO
/****** Object:  Database [Sklad]    Script Date: 14.05.2023 14:29:28 ******/
CREATE DATABASE [Sklad]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sklad', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Sklad.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sklad_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Sklad_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Sklad] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sklad].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sklad] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sklad] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sklad] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sklad] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sklad] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sklad] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sklad] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sklad] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sklad] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sklad] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sklad] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sklad] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sklad] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sklad] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sklad] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sklad] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sklad] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sklad] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sklad] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sklad] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sklad] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sklad] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sklad] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Sklad] SET  MULTI_USER 
GO
ALTER DATABASE [Sklad] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sklad] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sklad] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sklad] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Sklad] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Sklad] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Sklad] SET QUERY_STORE = OFF
GO
USE [Sklad]
GO
/****** Object:  Table [dbo].[AvailabilityProduct]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailabilityProduct](
	[IDWarehouse] [int] NOT NULL,
	[IDProduct] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_AvailabilityProduct] PRIMARY KEY CLUSTERED 
(
	[IDWarehouse] ASC,
	[IDProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[ID] [int] NOT NULL,
	[Address] [nvarchar](30) NOT NULL,
	[Number] [nvarchar](11) NOT NULL,
	[SurnameManager] [nvarchar](15) NULL,
 CONSTRAINT [PK_Warehouses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ID] [int] NOT NULL,
	[NameImage] [nvarchar](20) NOT NULL,
	[SelfI] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID] [int] NOT NULL,
	[Title] [nvarchar](30) NOT NULL,
	[ProductGroup] [nvarchar](15) NULL,
	[Manufacturer] [nvarchar](30) NULL,
	[Image] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TableView]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TableView]
AS
SELECT        TOP (100) PERCENT dbo.Products.ID, dbo.Products.Title, dbo.Products.ProductGroup, dbo.Products.Manufacturer, dbo.Image.SelfI, dbo.Warehouses.Address, dbo.AvailabilityProduct.Quantity
FROM            dbo.AvailabilityProduct INNER JOIN
                         dbo.Products ON dbo.AvailabilityProduct.IDProduct = dbo.Products.ID INNER JOIN
                         dbo.Image ON dbo.Products.Image = dbo.Image.ID INNER JOIN
                         dbo.Warehouses ON dbo.AvailabilityProduct.IDWarehouse = dbo.Warehouses.ID
ORDER BY dbo.Products.ID
GO
/****** Object:  Table [dbo].[Role]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Role_1] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 14.05.2023 14:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserFullName] [nvarchar](100) NOT NULL,
	[UserLogin] [nvarchar](20) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[UserRole] [int] NOT NULL,
 CONSTRAINT [PK_User_1] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (1, 3, 5000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (1, 10, 400)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (2, 4, 8000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (2, 7, 1000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (3, 3, 500)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (3, 8, 9000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (4, 1, 2500)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (4, 8, 10000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (5, 2, 1000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (6, 3, 2000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (6, 5, 800)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (6, 9, 4500)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (7, 2, 9000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (7, 7, 700)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (8, 1, 3000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (9, 5, 1000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (9, 8, 5000)
INSERT [dbo].[AvailabilityProduct] ([IDWarehouse], [IDProduct], [Quantity]) VALUES (9, 10, 500)
GO
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (1, N'Колбаса', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\1.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (2, N'Сыр', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\2.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (3, N'Хлеб', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\3.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (4, N'Телевизор', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\4.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (5, N'Стол', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\5.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (6, N'Автокресло', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\6.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (7, N'Лопата', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\7.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (8, N'Мочалка', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\8.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (9, N'Мыло', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\9.jpg')
INSERT [dbo].[Image] ([ID], [NameImage], [SelfI]) VALUES (10, N'Кастрюля', N'D:\Michael\Desktop\HorizontalList-master3\HorizontalList\bin\Debug\Assets\10.jpg')
GO
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (1, N'Колбаса', N'Продукты', N'Скопинский', 1)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (2, N'Сыр', N'Продукты', N'Молкомбинат', 2)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (3, N'Хлеб', N'Продукты', N'Хлебзавод 1', 3)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (4, N'Телевизор', N'Техника', N'Sony', 4)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (5, N'Стол', N'Мебель', N'IKEA', 5)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (6, N'Автокресло', NULL, NULL, 6)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (7, N'Лопата', N'Хозтовары', N'Мехзавод', 7)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (8, N'Мочалка', N'Хозтовары', N'Авангард', 8)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (9, N'Мыло', N'Хозтовары', N'Свобода', 9)
INSERT [dbo].[Products] ([ID], [Title], [ProductGroup], [Manufacturer], [Image]) VALUES (10, N'Кастрюля', N'Хозтовары', N'Технопласт', 10)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (1, N'Клиент')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (2, N'Менеджер')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (3, N'Администратор')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (1, N'Жмышенко Валерий Альбертович', N'user', N'1234567890', 1)
INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (2, N'Петрова Светлана Александровна', N'manager', N'0987654321', 2)
INSERT [dbo].[User] ([UserID], [UserFullName], [UserLogin], [UserPassword], [UserRole]) VALUES (3, N'Мичурин Сергей Сергеев', N'admin', N'1', 3)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (1, N'Первомайская, 1', N'111111', N'Иванов')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (2, N'Московское, 7', N'222222', N'Сидоров')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (3, N'Касимовское, 3', N'111222', N'Петров')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (4, N'Куйбышевское, 27', N'334455', N'Ковалев')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (5, N'Шабулина, 12', N'121212', N'Маматов')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (6, N'Яблочкова, 11', N'345678', N'Маматов')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (7, N'Циолковского, 17', N'778877', N'Сазонов')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (8, N'Павлова, 28', N'321321', NULL)
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (9, N'Новосёлов, 60', N'223344', N'Лоськов')
INSERT [dbo].[Warehouses] ([ID], [Address], [Number], [SurnameManager]) VALUES (10, N'Забайкальская, 14', N'445544', N'Родин')
GO
ALTER TABLE [dbo].[AvailabilityProduct]  WITH CHECK ADD  CONSTRAINT [FK_AvailabilityProduct_Products1] FOREIGN KEY([IDProduct])
REFERENCES [dbo].[Products] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AvailabilityProduct] CHECK CONSTRAINT [FK_AvailabilityProduct_Products1]
GO
ALTER TABLE [dbo].[AvailabilityProduct]  WITH CHECK ADD  CONSTRAINT [FK_AvailabilityProduct_Warehouses1] FOREIGN KEY([IDWarehouse])
REFERENCES [dbo].[Warehouses] ([ID])
GO
ALTER TABLE [dbo].[AvailabilityProduct] CHECK CONSTRAINT [FK_AvailabilityProduct_Warehouses1]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Image] FOREIGN KEY([Image])
REFERENCES [dbo].[Image] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Image]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([UserID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[30] 2[16] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AvailabilityProduct"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 133
               Left = 239
               Bottom = 263
               Right = 413
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Image"
            Begin Extent = 
               Top = 145
               Left = 445
               Bottom = 258
               Right = 619
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Warehouses"
            Begin Extent = 
               Top = 0
               Left = 456
               Bottom = 130
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1425
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 2160
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 135' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TableView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TableView'
GO
USE [master]
GO
ALTER DATABASE [Sklad] SET  READ_WRITE 
GO
