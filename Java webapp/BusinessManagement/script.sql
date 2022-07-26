USE [AssignmentPRJ]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](150) NOT NULL,
	[bid] [nchar](10) NOT NULL,
	[displayname] [nvarchar](100) NULL,
 CONSTRAINT [PK__Account__F3DBC573CB4763B5] PRIMARY KEY CLUSTERED 
(
	[bid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Account_Staff]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account_Staff](
	[userStaff] [nvarchar](50) NOT NULL,
	[passStaff] [nvarchar](100) NOT NULL,
	[bid] [nchar](10) NOT NULL,
	[displayname] [nvarchar](100) NULL,
 CONSTRAINT [PK_Account_Staff] PRIMARY KEY CLUSTERED 
(
	[userStaff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[billcode] [nchar](15) NOT NULL,
	[bid] [nchar](10) NULL,
	[name] [nvarchar](100) NULL,
	[phone] [nchar](20) NULL,
	[address] [nvarchar](200) NULL,
	[payment] [int] NULL,
	[paytype] [nvarchar](100) NULL,
	[debt] [int] NULL,
	[total] [int] NULL,
	[time] [datetime2](0) NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDebt]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDebt](
	[idbill] [int] NOT NULL,
	[status] [bit] NULL,
	[time] [datetime2](7) NULL,
 CONSTRAINT [PK_BillDebt] PRIMARY KEY CLUSTERED 
(
	[idbill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetail](
	[bid] [nchar](10) NULL,
	[billcode] [nchar](15) NULL,
	[product] [nvarchar](150) NULL,
	[quantity] [int] NULL,
	[unitprice] [int] NULL,
	[price] [int] NULL,
	[describe] [nvarchar](200) NULL,
	[num] [int] IDENTITY(1,1) NOT NULL,
	[idbill] [int] NULL,
 CONSTRAINT [PK_BillDetail] PRIMARY KEY CLUSTERED 
(
	[num] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Import]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import](
	[iid] [int] NOT NULL,
	[bid] [nchar](10) NULL,
	[iname] [nvarchar](100) NULL,
	[iphone] [nvarchar](50) NULL,
	[iaddress] [nvarchar](200) NULL,
	[iconfirm] [nvarchar](100) NULL,
	[itotal] [int] NULL,
	[idebt] [int] NULL,
	[payment] [int] NULL,
	[time] [datetime2](0) NULL,
 CONSTRAINT [PK_Import] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportDebt]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportDebt](
	[iid] [int] NOT NULL,
	[status] [bit] NULL,
	[time] [datetime2](7) NULL,
 CONSTRAINT [PK_ImportDebt] PRIMARY KEY CLUSTERED 
(
	[iid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ImportDetail]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImportDetail](
	[iid] [int] NOT NULL,
	[product] [nvarchar](100) NULL,
	[quantity] [int] NULL,
	[unitprice] [int] NULL,
	[price] [int] NULL,
	[describe] [nvarchar](150) NULL,
	[num] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouse]    Script Date: 13/06/2022 9:27:43 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouse](
	[bid] [nchar](10) NULL,
	[product] [nvarchar](100) NULL,
	[time] [datetime2](7) NULL,
	[quantity] [int] NULL,
	[num] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'thanhtk', N'thanhtk', N'cKiYWsY   ', N'Thanh')
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'mra', N'mra', N'dhfH02n   ', N'Phan Quân2')
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'mrd', N'mrd', N'ejf93fP   ', N'Tùng')
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'mrb', N'mrb', N'kzFyPJU   ', N'Tiến')
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'lamtk', N'lamtk', N'Sb8B4HB   ', N'Lâm')
INSERT [dbo].[Account] ([username], [password], [bid], [displayname]) VALUES (N'longdk', N'longdk', N'UhdHzHf   ', N'Long Đế')
GO
INSERT [dbo].[Account_Staff] ([userStaff], [passStaff], [bid], [displayname]) VALUES (N'staff1', N'staff1', N'dhfH02n   ', N'Thảo')
INSERT [dbo].[Account_Staff] ([userStaff], [passStaff], [bid], [displayname]) VALUES (N'staff2', N'staff2', N'dhfH02n   ', N'Thanh')
INSERT [dbo].[Account_Staff] ([userStaff], [passStaff], [bid], [displayname]) VALUES (N'thanhtk', N'thanhtk', N'Sb8B4HB   ', N'Thành')
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000001  ', N'dhfH02n   ', N'Thanh Phong', N'046464949494        ', N'BN, Pm', 20000, N'ATM', 340000, 360000, CAST(N'2022-03-19T20:41:24.0000000' AS DateTime2), 1)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000002  ', N'dhfH02n   ', N'Thanh', N'0546546151          ', N'TS', 20000, N'đưa tiền', 0, 20000, CAST(N'2022-03-14T23:18:53.0000000' AS DateTime2), 2)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000003  ', N'dhfH02n   ', N'Phan Quan', N'0646484849          ', N'696 pM', 60000, N'CK', 5000, 65000, CAST(N'2022-03-14T23:18:53.0000000' AS DateTime2), 3)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000005  ', N'dhfH02n   ', N'Tung', N'0564654884          ', N'HD', 50000, N'ATM', 10000, 60000, CAST(N'2022-02-18T10:06:25.0000000' AS DateTime2), 5)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000006  ', N'dhfH02n   ', N'Lan Anh', N'0655465465          ', N'Hai Bà Trưng, Hà Nội', 50000, N'ATM', 30000, 80000, CAST(N'2022-03-19T20:47:09.0000000' AS DateTime2), 6)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000007  ', N'dhfH02n   ', N'Tiến', N'0546156464848       ', N'Lạng Sơn', 250000, N'CK', 137000, 387000, CAST(N'2022-03-19T22:20:53.0000000' AS DateTime2), 7)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000008  ', N'dhfH02n   ', N'Tiến', N'0546156464848       ', N'Lạng Sơn', 387000, N'CK', 0, 387000, CAST(N'2022-03-19T22:23:37.0000000' AS DateTime2), 8)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000009  ', N'dhfH02n   ', N'Thành 2', N'06546468494         ', N'BN', 630000, N'ATM', 0, 630000, CAST(N'2022-03-19T22:28:01.0000000' AS DateTime2), 9)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000010  ', N'dhfH02n   ', N'Nguyen Quan', N'(+84) 963946861     ', N'Bac Ninh, VietNam', 300000, N'ATM', 0, 300000, CAST(N'2022-03-19T22:30:11.0000000' AS DateTime2), 10)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000011  ', N'dhfH02n   ', N'Nguyen Quan', N'(+84) 963946861     ', N'Bac Ninh, VietNam', 300000, N'ATM', 0, 300000, CAST(N'2021-03-19T22:31:23.0000000' AS DateTime2), 11)
INSERT [dbo].[Bill] ([billcode], [bid], [name], [phone], [address], [payment], [paytype], [debt], [total], [time], [id]) VALUES (N'2022-00000001  ', N'Sb8B4HB   ', N'Nguyen Quan', N'056464561561        ', N'Bac Ninh, VietNam', 740000, N'ATM', 0, 740000, CAST(N'2022-03-26T17:35:11.0000000' AS DateTime2), 12)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (1, 1, CAST(N'2022-03-19T21:20:32.8533333' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (2, 0, CAST(N'2022-03-14T23:18:53.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (3, 1, CAST(N'2022-03-14T23:18:53.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (5, 1, CAST(N'2022-02-18T10:06:25.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (6, 1, CAST(N'2022-03-19T20:47:09.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (7, 1, CAST(N'2022-03-19T22:20:53.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (8, 0, CAST(N'2022-03-19T22:23:37.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (9, 0, CAST(N'2022-03-26T17:51:21.1066667' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (10, 0, CAST(N'2022-03-19T22:30:11.0000000' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (11, 0, CAST(N'2022-03-19T23:06:23.0366667' AS DateTime2))
INSERT [dbo].[BillDebt] ([idbill], [status], [time]) VALUES (12, 0, CAST(N'2022-03-26T17:52:55.8466667' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[BillDetail] ON 

INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000001  ', N'bó hoa vàng 50 bông', 4, 90000, 360000, N'0', 1, 1)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000003  ', N'bó hoa vàng 50 bông', 4, 150000, 600000, N'0', 2, 3)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000003  ', N'hoa hướng dương', 4, 65500, 262000, N'0', 3, 3)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000006  ', N'1 thung hoa do', 4, 20000, 80000, N'0', 5, 6)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000008  ', N'thùng hoa giấy', 3, 110000, 330000, N'0', 6, 8)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000008  ', N'đèn ngủ', 1, 57000, 57000, N'0', 7, 8)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000009  ', N'bó hoa vàng 50 bông', 2, 90000, 180000, N'0', 8, 9)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000009  ', N'hoa to', 3, 150000, 450000, N'0', 9, 9)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000010  ', N'thùng hoa giấy', 2, 150000, 300000, N'0', 10, 10)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'dhfH02n   ', N'2022-00000011  ', N'thùng hoa giấy', 2, 150000, 300000, N'0', 11, 11)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'Sb8B4HB   ', N'2022-00000001  ', N'bó hoa vàng 50 thùng', 2, 150000, 300000, N'0', 12, 1)
INSERT [dbo].[BillDetail] ([bid], [billcode], [product], [quantity], [unitprice], [price], [describe], [num], [idbill]) VALUES (N'Sb8B4HB   ', N'2022-00000001  ', N'bó hoa đỏ 50 bông', 4, 110000, 440000, N'0', 13, 1)
SET IDENTITY_INSERT [dbo].[BillDetail] OFF
GO
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (1, N'dhfH02n   ', N'mrD', N'094344545', N'BN', N'Thanh', 13000, 3000, 10000, CAST(N'2022-03-14T23:18:53.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (3, N'kzFyPJU   ', N'Tăng Thanh Phúc', N'09424494646', N'696Phố Mới, Đồng Nguyên, Từ Sơn, Bắc Ninh', N'Tiến', 15400, 0, 15400, CAST(N'2022-03-15T09:42:24.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (4, N'kzFyPJU   ', N'Tăng Thanh Phúc', N'09424494646', N'696Phố Mới, Đồng Nguyên, Từ Sơn, Bắc Ninh', N'Tiến', 15400, 0, 15400, CAST(N'2022-02-15T09:43:59.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (6, N'dhfH02n   ', N'Nguyễn Phan Quân', N'094464676', N'Bắc Ninh', N'Tùng', 14000, 4000, 10000, CAST(N'2022-03-15T10:23:12.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (7, N'dhfH02n   ', N'Nguyễn Thanh Tùng', N'04646846844', N'phố mới', N'Quân', 15000, 5000, 10000, CAST(N'2022-02-15T10:56:39.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (8, N'dhfH02n   ', N'Nguyễn Phan Quân', N'0963946861', N'Bắc Ninh', N'Thanh', 33050, 0, 33050, CAST(N'2022-03-15T22:38:08.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (9, N'dhfH02n   ', N'Nguyễn Phan Quân', N'0963946861', N'Bắc Ninh', N'Tiến', 41050, 24350, 16700, CAST(N'2022-03-15T22:39:36.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (10, N'dhfH02n   ', N'Nguyễn Phan Quân', N'0963946861', N'Bắc Ninh', N'Tiến', 26000, 0, 26000, CAST(N'2022-03-15T22:40:58.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (13, N'dhfH02n   ', N'Quân', N'', N'', N'Tùng', 15600, 0, 15600, CAST(N'2022-03-17T22:19:10.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (14, N'dhfH02n   ', N'Phan Quân', N'0811646411', N'Bắc Ninh,vn', N'Tien', 2220000, 220000, 2000000, CAST(N'2022-03-21T13:35:53.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (15, N'dhfH02n   ', N'Trần Thanh tùng', N'01546946646', N'HD', N'Quân', 870000, 0, 870000, CAST(N'2022-03-26T17:07:46.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (16, N'Sb8B4HB   ', N'Trần Thanh tùng', N'0963946861', N'Bắc Ninh', N'Quân', 780000, 0, 780000, CAST(N'2022-03-26T17:24:35.0000000' AS DateTime2))
INSERT [dbo].[Import] ([iid], [bid], [iname], [iphone], [iaddress], [iconfirm], [itotal], [idebt], [payment], [time]) VALUES (17, N'Sb8B4HB   ', N'Trần Thanh tùng', N'0963946861', N'HD', N'Tiến', 9000, 0, 9000, CAST(N'2022-03-26T17:36:42.0000000' AS DateTime2))
GO
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (3, 0, CAST(N'2022-03-26T17:07:45.6266667' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (4, 0, CAST(N'2022-03-26T17:07:45.6266667' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (6, 1, CAST(N'2022-03-15T10:23:12.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (7, 1, CAST(N'2022-02-15T10:56:39.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (8, 0, CAST(N'2022-03-15T22:38:08.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (9, 1, CAST(N'2022-03-15T22:39:36.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (10, 0, CAST(N'2022-03-15T22:40:58.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (13, 0, CAST(N'2022-03-26T17:22:50.1166667' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (14, 1, CAST(N'2022-03-21T13:35:53.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (15, 1, CAST(N'2022-03-21T13:35:53.0000000' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (16, 0, CAST(N'2022-03-26T17:35:35.0166667' AS DateTime2))
INSERT [dbo].[ImportDebt] ([iid], [status], [time]) VALUES (17, 0, CAST(N'2022-03-26T17:36:41.7200000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[ImportDetail] ON 

INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (1, N'dưa hấu', 4, 10000, 40000, N'về ăn', 1)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (1, N'dưa vàng', 4, 10000, 40000, N'về ăn', 2)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (7, N'dưa hấu', 5, 5000, 25000, N'an nhà', 3)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (15, N'10 thùng hoa vàng', 4, 150000, 600000, N'0', 30)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (15, N'vèn trắng', 3, 90000, 270000, N'0', 31)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (8, N'dưa hấu', 5, 4610, 23050, N'thỏ', 13)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (8, N'hoa', 2, 5000, 10000, N'ta', 14)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (9, N'dưa hấu', 4, 4500, 18000, N'thỏ', 15)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (9, N'cà rốt', 5, 4610, 23050, N'thỏ', 16)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (10, N'dưa hấu', 4, 4500, 18000, N'quân ăn', 17)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (10, N'cà rốt', 4, 2000, 8000, N'thỏ', 18)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (16, N'bó hoa vàng 50 bông', 4, 150000, 600000, N'0', 32)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (16, N'vèn trắng', 2, 90000, 180000, N'0', 33)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (13, N'dưa hấu', 3, 5200, 15600, N'rư', 23)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'nơ cuộn đỏ', 3, 30000, 90000, N'0', 24)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'30 bông hoa đỏ', 30, 10000, 300000, N'đỏ đậm', 25)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'ven trắng', 10, 100000, 1000000, N'0', 26)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'hộp hoa vàng', 5, 79000, 395000, N'0', 27)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'ven đen', 5, 60000, 300000, N'0', 28)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (14, N'hoa hướng dương', 3, 45000, 135000, N'0', 29)
INSERT [dbo].[ImportDetail] ([iid], [product], [quantity], [unitprice], [price], [describe], [num]) VALUES (17, N'vèn trắng', 2, 4500, 9000, N'0', 34)
SET IDENTITY_INSERT [dbo].[ImportDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Warehouse] ON 

INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'dưa hấu', CAST(N'2022-03-17T22:19:10.1466667' AS DateTime2), 19, 1)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'dưa vàng', CAST(N'2022-03-17T16:11:38.6933333' AS DateTime2), 6, 3)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'hoa', CAST(N'2022-05-17T14:18:59.0433333' AS DateTime2), 4, 5)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'10 thùng hoa vàng', CAST(N'2022-03-26T17:07:45.5800000' AS DateTime2), 14, 6)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'2 thùng hoa sáp', CAST(N'2022-03-21T13:35:52.6733333' AS DateTime2), 2, 7)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'giấy đen bó hoa', CAST(N'2022-03-21T13:35:52.6900000' AS DateTime2), 3, 8)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'vèn trắng', CAST(N'2022-03-26T17:07:45.6100000' AS DateTime2), 8, 9)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'nơ cuộn đỏ', CAST(N'2022-03-21T13:35:52.7233333' AS DateTime2), 3, 10)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'dhfH02n   ', N'thùng hoa giấy', CAST(N'2022-03-21T13:35:52.7400000' AS DateTime2), 1, 11)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'Sb8B4HB   ', N'bó hoa vàng 50 bông', CAST(N'2022-03-26T17:24:35.0766667' AS DateTime2), 4, 12)
INSERT [dbo].[Warehouse] ([bid], [product], [time], [quantity], [num]) VALUES (N'Sb8B4HB   ', N'vèn trắng', CAST(N'2022-03-26T17:37:25.8266667' AS DateTime2), 4, 13)
SET IDENTITY_INSERT [dbo].[Warehouse] OFF
GO
ALTER TABLE [dbo].[Account_Staff]  WITH CHECK ADD  CONSTRAINT [FK_Account_Staff_Account] FOREIGN KEY([bid])
REFERENCES [dbo].[Account] ([bid])
GO
ALTER TABLE [dbo].[Account_Staff] CHECK CONSTRAINT [FK_Account_Staff_Account]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Account] FOREIGN KEY([bid])
REFERENCES [dbo].[Account] ([bid])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Account]
GO
ALTER TABLE [dbo].[BillDebt]  WITH CHECK ADD  CONSTRAINT [FK_BillDebt_Bill] FOREIGN KEY([idbill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillDebt] CHECK CONSTRAINT [FK_BillDebt_Bill]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Bill] FOREIGN KEY([idbill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Bill]
GO
ALTER TABLE [dbo].[Import]  WITH CHECK ADD  CONSTRAINT [FK_Import_Account1] FOREIGN KEY([bid])
REFERENCES [dbo].[Account] ([bid])
GO
ALTER TABLE [dbo].[Import] CHECK CONSTRAINT [FK_Import_Account1]
GO
ALTER TABLE [dbo].[ImportDebt]  WITH CHECK ADD  CONSTRAINT [FK_ImportDebt_Import] FOREIGN KEY([iid])
REFERENCES [dbo].[Import] ([iid])
GO
ALTER TABLE [dbo].[ImportDebt] CHECK CONSTRAINT [FK_ImportDebt_Import]
GO
ALTER TABLE [dbo].[ImportDetail]  WITH CHECK ADD  CONSTRAINT [FK_ImportDetail_Import] FOREIGN KEY([iid])
REFERENCES [dbo].[Import] ([iid])
GO
ALTER TABLE [dbo].[ImportDetail] CHECK CONSTRAINT [FK_ImportDetail_Import]
GO
ALTER TABLE [dbo].[Warehouse]  WITH CHECK ADD  CONSTRAINT [FK_Warehouse_Account] FOREIGN KEY([bid])
REFERENCES [dbo].[Account] ([bid])
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Account]
GO
