USE [GFlowers]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 16/08/2023 10:20:54 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[accountID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](250) NOT NULL,
	[address] [nvarchar](1000) NULL,
	[phone] [varchar](20) NULL,
	[email] [varchar](250) NULL,
	[role] [int] NOT NULL,
	[firstName] [nvarchar](500) NOT NULL,
	[lastName] [nvarchar](700) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[accountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 16/08/2023 10:20:54 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cartID] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[totalPrice] [money] NOT NULL,
	[status] [int] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[cartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 16/08/2023 10:20:54 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NULL,
	[orderDate] [datetime] NULL,
	[shippedDate] [datetime] NULL,
	[orderStatus] [int] NOT NULL,
	[shippingInfo] [nvarchar](1000) NULL,
	[totalPrice] [money] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 16/08/2023 10:20:54 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 16/08/2023 10:20:54 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productID] [int] IDENTITY(1,1) NOT NULL,
	[productName] [nvarchar](500) NOT NULL,
	[productDescription] [nvarchar](2000) NULL,
	[productPrice] [money] NOT NULL,
	[productImage] [varchar](1000) NULL,
	[status] [int] NOT NULL,
	[discount] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (1, N'quannp', N'12345', N'bac ninh', N'0123456789', N'hihi@gmail.com', 1, N'Quan', N'Nguyen')
INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (2, N'longtk', N'112233', NULL, NULL, NULL, 2, N'Long', N'Tran')
INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (3, N'vunm', N'12345', NULL, NULL, NULL, 2, N'Vu', N'Nguyen')
INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (4, N'thinhlm', N'12345', NULL, NULL, NULL, 2, N'Thinh', N'Luong')
INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (5, N'minhnn', N'123456', NULL, NULL, NULL, 2, N'Nguyen', N'Minh')
INSERT [dbo].[Account] ([accountID], [username], [password], [address], [phone], [email], [role], [firstName], [lastName]) VALUES (6, N'lamnt', N'12331', NULL, NULL, NULL, 2, N'Nguyen', N'Lam')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([cartID], [accountID], [productID], [quantity], [totalPrice], [status]) VALUES (11, 1, 4, 1, 51.2000, 1)
INSERT [dbo].[Cart] ([cartID], [accountID], [productID], [quantity], [totalPrice], [status]) VALUES (12, 1, 5, 1, 64.5000, 1)
INSERT [dbo].[Cart] ([cartID], [accountID], [productID], [quantity], [totalPrice], [status]) VALUES (13, 2, 3, 1, 37.5000, 1)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (2, NULL, CAST(N'2022-03-19T20:41:24.000' AS DateTime), NULL, 1, N'he', NULL)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (3, NULL, CAST(N'2023-03-25T09:44:42.703' AS DateTime), NULL, 2, N'Long Tran - 124561356 - Bac Ninh- NguyenQuan', 88.7000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (4, 1, CAST(N'2023-03-25T10:08:05.677' AS DateTime), NULL, 1, N'Long Tran - 124561356 - Bac Ninh- NguyenQuan', 140.5000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (5, 1, CAST(N'2023-03-25T10:14:52.163' AS DateTime), NULL, 2, N'Long Tran - 124561356 - Bac Ninh- NguyenQuan', 37.5000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (6, 1, CAST(N'2023-03-25T11:34:13.533' AS DateTime), NULL, 4, N'Long Tran - 124561356 - Bac Ninh- NguyenQuan', 284.0000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (7, 1, CAST(N'2023-03-28T15:23:10.053' AS DateTime), NULL, 3, N'Long Tran - 124561356 - Bac Ninh- NguyenQuan', 88.7000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (18, 1, CAST(N'2023-07-09T23:55:56.597' AS DateTime), NULL, 1, N'Dinh Manh Hieu - 0547841569 - Ha Long - NguyenQuan', 96.7000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (20, 1, CAST(N'2023-07-10T00:24:40.787' AS DateTime), NULL, 0, N'Dinh Manh Hieu - 0547841569 - Ha Long - Lam', 116.0000)
INSERT [dbo].[Order] ([orderID], [accountID], [orderDate], [shippedDate], [orderStatus], [shippingInfo], [totalPrice]) VALUES (22, 1, CAST(N'2023-07-10T18:06:08.780' AS DateTime), CAST(N'2023-07-24T14:17:35.513' AS DateTime), 3, N'Dinh Manh Hieu - 0547841569 - Ha Long - NguyenQuan', 37.5000)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (1, 3, 3, 1, 37.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (2, 3, 4, 1, 51.2000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (3, 4, 3, 1, 37.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (4, 4, 7, 2, 103.0000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (5, 5, 3, 1, 37.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (6, 6, 3, 3, 112.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (7, 6, 5, 2, 129.0000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (8, 6, 9, 1, 42.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (9, 7, 4, 1, 51.2000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (10, 7, 3, 1, 37.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (13, 7, 2, 2, 90.4000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (14, 7, 7, 1, 51.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (21, 18, 2, 1, 45.2000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (22, 18, 7, 1, 51.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (23, 20, 5, 1, 64.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (24, 20, 7, 1, 51.5000)
INSERT [dbo].[OrderDetail] ([ID], [orderID], [productID], [Quantity], [Price]) VALUES (27, 22, 3, 1, 37.5000)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (2, N'Summer Of Soul', N'hello ne', 23.0000, N'bou1.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (3, N'Spirit Up', NULL, 37.5000, N'bou2.jpeg', 0, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (4, N'Stand By You', NULL, 51.2000, N'bou3.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (5, N'Blooms Of Magnificence', NULL, 64.5000, N'bou4.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (6, N'Affluent Season', NULL, 60.5000, N'bou5.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (7, N'Time To Love', NULL, 51.5000, N'bou7.jpg', 0, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (8, N'A Chant Of Mystics', NULL, 56.5000, N'bou7.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (9, N'Dream Variations', NULL, 42.5000, N'bou8.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (10, N'Mon Bel Amour', NULL, 32.5000, N'bou9.jpeg', 1, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (16, N'Real love 2024', NULL, 21.0000, N'5a14db82-6dfa-4472-a0d3-4f0e83b8f3e0_bou5.jpeg', 3, 0)
INSERT [dbo].[Product] ([productID], [productName], [productDescription], [productPrice], [productImage], [status], [discount]) VALUES (17, N'Real love 2024', NULL, 42.5000, N'bou17.jpeg', 1, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Account1] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([accountID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Account1]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Account] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([accountID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Account]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([orderID])
REFERENCES [dbo].[Order] ([orderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([productID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
