USE [Nhom5-QuanLyRapChieuPhim]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](200) NULL,
	[Password] [nvarchar](200) NULL,
	[Fullname] [nvarchar](200) NULL,
	[Gender] [bit] NULL,
	[DateOfBirth] [date] NULL,
	[Address] [nvarchar](200) NULL,
	[Phone] [nchar](10) NULL,
	[Image] [nvarchar](1000) NULL,
	[Role] [nvarchar](200) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[AccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Banner]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banner](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[img] [text] NULL,
	[title] [nvarchar](200) NULL,
	[description] [nvarchar](max) NULL,
	[start] [date] NULL,
	[finish] [date] NULL,
 CONSTRAINT [PK_Banner] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[AccountId] [int] NULL,
	[OrderDate] [date] NULL,
	[TotalPrice] [float] NULL,
	[Status] [bit] NULL,
	[QRcode] [varchar](300) NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DateRoom]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DateRoom](
	[DateRoomID] [int] IDENTITY(1,1) NOT NULL,
	[DateRoom] [date] NULL,
 CONSTRAINT [PK_DateRoom] PRIMARY KEY CLUSTERED 
(
	[DateRoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FastFood]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FastFood](
	[FastFoodId] [int] IDENTITY(1,1) NOT NULL,
	[Category] [nvarchar](200) NULL,
	[FastFoodName] [nvarchar](200) NULL,
	[Price] [float] NULL,
	[Image] [nvarchar](1000) NULL,
 CONSTRAINT [PK_FastFood] PRIMARY KEY CLUSTERED 
(
	[FastFoodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FastFoodCart]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FastFoodCart](
	[FastFoodCartId] [int] IDENTITY(1,1) NOT NULL,
	[FastFoodId] [int] NULL,
	[Quantity] [int] NULL,
	[CartId] [int] NULL,
 CONSTRAINT [PK_FastFoodCart] PRIMARY KEY CLUSTERED 
(
	[FastFoodCartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [nvarchar](200) NULL,
	[Category] [nvarchar](200) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[Duration] [int] NULL,
	[Language] [nvarchar](200) NULL,
	[Rated] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
	[Img] [text] NULL,
 CONSTRAINT [PK_Movie] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieTime]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieTime](
	[MovieTimeId] [int] IDENTITY(1,1) NOT NULL,
	[Slot] [int] NULL,
	[Start] [time](7) NULL,
	[Finish] [time](7) NULL,
	[DateRoomID] [int] NULL,
 CONSTRAINT [PK_MovieTime] PRIMARY KEY CLUSTERED 
(
	[MovieTimeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[RoomName] [nvarchar](200) NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[SeatId] [int] IDENTITY(1,1) NOT NULL,
	[SeatNumber] [int] NULL,
	[SeatPrice] [float] NULL,
	[SeatRow] [nvarchar](50) NULL,
 CONSTRAINT [PK_Seat] PRIMARY KEY CLUSTERED 
(
	[SeatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeatRoom]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatRoom](
	[SeatRoomId] [int] IDENTITY(1,1) NOT NULL,
	[SeatId] [int] NULL,
	[TimeRoomId] [int] NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_SeatRoom] PRIMARY KEY CLUSTERED 
(
	[SeatRoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeatRoomCart]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeatRoomCart](
	[SeatRoomCartId] [int] IDENTITY(1,1) NOT NULL,
	[SeatRoomId] [int] NULL,
	[CartId] [int] NULL,
 CONSTRAINT [PK_SeatRoomCart] PRIMARY KEY CLUSTERED 
(
	[SeatRoomCartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeRoom]    Script Date: 08/08/2022 11:47:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeRoom](
	[TimeRoomId] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[MovieId] [int] NULL,
	[MovieTimeId] [int] NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_TimeRoom] PRIMARY KEY CLUSTERED 
(
	[TimeRoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountId], [Email], [Password], [Fullname], [Gender], [DateOfBirth], [Address], [Phone], [Image], [Role], [Status]) VALUES (1, N'nguyenvanngoc11082000@gmail.com', N'123', N'Ngoc', 1, CAST(N'2000-08-11' AS Date), N'Thành phố Hồ Chí Minh', N'0987665444', N'image/avatar/FB_IMG_1608343271101.jpg', N'2', 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [Fullname], [Gender], [DateOfBirth], [Address], [Phone], [Image], [Role], [Status]) VALUES (2, N'quannphe151439@fpt.edu.vn', N'123456', N'Phan Quân', 0, CAST(N'2001-05-24' AS Date), N'Bac Ninh, VietNam, Bac Ninhd', N'0246464468', N'image/avatar/3.jpg', N'1', 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [Fullname], [Gender], [DateOfBirth], [Address], [Phone], [Image], [Role], [Status]) VALUES (3, N'bansiki114@gmail.com', N'123123', N'Quân Nguyễn', 0, CAST(N'2002-06-18' AS Date), N'Hai Bà Trưng, Hà Nội', N'0125468741', N'image/avatar/277588673_501982554757712_8325899542520646739_n.jpg', N'3', 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [Fullname], [Gender], [DateOfBirth], [Address], [Phone], [Image], [Role], [Status]) VALUES (7, N'nilongball11@gmail.com', N'123123', N'Nguyen Quan', 0, CAST(N'2002-06-06' AS Date), N'Bac Ninh, VietNam', N'0811646411', N'', N'3', 1)
INSERT [dbo].[Account] ([AccountId], [Email], [Password], [Fullname], [Gender], [DateOfBirth], [Address], [Phone], [Image], [Role], [Status]) VALUES (8, N'huyhoang11@gmail.com', N'121212', N'Huy Hoàng', 0, CAST(N'2001-03-11' AS Date), N'Hai Bà Trưng, Hà Nội', N'0154263548', N'', N'3', 1)
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Banner] ON 

INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (1, N'image/banner/banner1.png', N'Em và trịnh ads', N'Cuộc gặp gỡ định mệnh giữa Trịnh Công Sơn và nữ sinh viên Nhật Bản Michiko tại Paris năm 1990 đã mở ra một mối duyên kỳ ngộ. Từ đây bắt đầu hành trình ngược dòng thời gian, khám phá tuổi thanh xuân và tình yêu của người nhạc sĩ tài hoa với các nàng thơ Thanh Thuý, Bích Diễm, Dao Ánh, Khánh Ly, và những tình khúc mà họ lưu lại trong trái tim ông. Bộ phim lãng mạn, mở ra thế giới nhạc Trịnh quyến rũ với những mảnh ghép tình yêu đa sắc, lung linh tuyệt đẹp.  Hãy ra rạp và thưởng thức bộ phim Việt đang cháy vé hiện nay', CAST(N'2022-06-22' AS Date), CAST(N'2022-07-08' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (2, N'image/banner/banner2.png', N'LightYear', N'Phim mới ra', CAST(N'2022-06-22' AS Date), CAST(N'2022-07-24' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (3, N'image/banner/banner3.png', N'ShopeePay', N'Khách hàng mua vé xem phim online tại website/ứng dụng CGV Cinemas và thanh toán bằng ví ShopeePay sẽ nhận ngay một trong hai ưu đãi sau :

- Đối với Khách hàng chưa từng nạp game Garena bằng ví ShopeePay tại napthe.vn: nhận 1 Voucher ShopeePay giảm ngay 50.000đ cho đơn hàng 100.000đ.

- Đối với Khách hàng đã từng nạp game Garena bằng ví ShopeePay tại napthe.vn: nhận 1 Voucher ShopeePay giảm 10% cho đơn hàng từ 200.000đ, giảm tối đa 100.000đ.', CAST(N'2022-06-22' AS Date), CAST(N'2022-07-28' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (4, N'image/banner/banner4.png', N'Doreamon', N'Phim mới chiếu', CAST(N'2022-06-22' AS Date), CAST(N'2022-06-30' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (5, N'image/banner/banner5.png', N'Doctor stange', N'Phim cháy véddd', CAST(N'2022-06-22' AS Date), CAST(N'2022-06-29' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (6, N'image/banner/banner6.jpg', N'Thor : Tình yêu và sấm sét', N'Vốn từng là một chiến binh hùng mạnh của Asgard, trải qua vô số trận chiến lớn nhỏ nhưng sau sự kiện trong Avengers: Endgame (2019) cùng vô số mất mát, Thần Sấm không còn muốn theo đuổi con đường siêu anh hùng. Từ đây, anh lên đường tìm ra ý nghĩa của cuộc sống và nhìn nhận lại bản thân mình. Hãy đến BoomCinema và thưởng thức bộ phim với suất chiếu sớm ngày 7/7/2022', CAST(N'2022-06-23' AS Date), CAST(N'2022-07-30' AS Date))
INSERT [dbo].[Banner] ([id], [img], [title], [description], [start], [finish]) VALUES (7, N'image/banner/banner7.png', N'Culture day', N'Hãy đến ngay rạp BoomCinema vào ngày thứ 2 hàng tuần với đồng giá vé chỉ 45k, đến BoomCinema gần nhất và trải nghiệm ngay', CAST(N'2022-07-22' AS Date), CAST(N'2022-08-30' AS Date))
SET IDENTITY_INSERT [dbo].[Banner] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (1, 2, CAST(N'2022-07-01' AS Date), 125.5, 0, N'image/QRcode/1.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (2, 2, CAST(N'2022-06-28' AS Date), 112.5, 1, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (3, 2, CAST(N'2022-06-21' AS Date), 75.5, 0, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (4, 1, CAST(N'2022-06-28' AS Date), 85.5, 1, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (5, 1, CAST(N'2022-06-25' AS Date), 125, 1, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (6, 3, CAST(N'2022-06-28' AS Date), 130, 1, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (7, 2, CAST(N'2022-06-28' AS Date), 130, 1, NULL)
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (9, 2, CAST(N'2022-07-21' AS Date), 232, 0, N'image/QRcode/9.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (10, 2, CAST(N'2022-07-24' AS Date), 213, 1, N'image/QRcode/10.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (12, 8, CAST(N'2022-07-25' AS Date), 232, 1, N'image/QRcode/12.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (16, 2, CAST(N'2022-07-25' AS Date), 148, 1, N'image/QRcode/16.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (17, 8, CAST(N'2022-07-25' AS Date), 167, 1, N'image/QRcode/17.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (18, 8, CAST(N'2022-07-25' AS Date), 167, 1, N'image/QRcode/18.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (19, 8, CAST(N'2022-07-25' AS Date), 167, 1, N'image/QRcode/19.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (20, 8, CAST(N'2022-07-25' AS Date), 148, 0, N'image/QRcode/20.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (21, 8, CAST(N'2022-07-25' AS Date), 259, 1, N'image/QRcode/21.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (22, 1, CAST(N'2022-07-27' AS Date), 213, 0, N'image/QRcode/22.png')
INSERT [dbo].[Cart] ([CartId], [AccountId], [OrderDate], [TotalPrice], [Status], [QRcode]) VALUES (23, 3, CAST(N'2022-07-27' AS Date), 429, 1, N'image/QRcode/23.png')
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[DateRoom] ON 

INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (1, CAST(N'2022-07-27' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (2, CAST(N'2022-07-28' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (4, CAST(N'2022-07-29' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (5, CAST(N'2022-07-30' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (6, CAST(N'2022-07-31' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (7, CAST(N'2022-08-06' AS Date))
INSERT [dbo].[DateRoom] ([DateRoomID], [DateRoom]) VALUES (8, CAST(N'2022-08-07' AS Date))
SET IDENTITY_INSERT [dbo].[DateRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[FastFood] ON 

INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (8, N'Bỏng ngô Bonus', N'Bỏng ngô caramel', 40, N'image/FoodAndDrink/bongngocaramel.png')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (9, N'Bỏng ngô Bonus', N'Bỏng ngô vị phô mai', 43, N'image/FoodAndDrink/bongngophomai.png')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (10, N'Bỏng ngô Bonus', N'Bỏng ngô vị chocolate', 46, N'image/FoodAndDrink/bongngocaramel.png')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (12, N'MY COMBO', N'1 bắp lớn + 1 nước siêu lớn. Nhận trong ngày xem phim*
* Miễn phí đổi vị bắp Caramel *
**Đổi vị phô mai phụ thu thêm tiền**', 83, N'image/FoodAndDrink/1bap1nuoc.jpg')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (13, N'BOOMCINEMA COMBO', N'CGV COMBO1 Bắp Lớn + 2 Nước Siêu Lớn. Nhận trong ngày xem phim.
* Miễn phí đổi vị bắp Caramel *
**Đổi vị phô mai phụ thu thêm tiền**', 102, N'image/FoodAndDrink/1bong2nuoc.jpg')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (14, N'THOR 3D HAMMER COM', N'1 ly Mighty 3D Hammer + 1 nước siêu lớn + 1 bắp ngọt lớn
* Miễn phí đổi vị bắp Phô mai, Caramel *
**Nhận trong ngày xem phim**', 299, N'image/FoodAndDrink/combothor.png')
INSERT [dbo].[FastFood] ([FastFoodId], [Category], [FastFoodName], [Price], [Image]) VALUES (25, N'MY SNACK COMBO', N'CGV SNACK COMBO1 Bắp Lớn + 2 Nước Siêu Lớn + 1 Snack. Nhận trong ngày xem phim.
* Miễn phí đổi vị bắp Caramel *
**Đổi vị phô mai phụ thu thêm tiền**', 113, N'image/FoodAndDrink/combo1.png')
SET IDENTITY_INSERT [dbo].[FastFood] OFF
GO
SET IDENTITY_INSERT [dbo].[FastFoodCart] ON 

INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (1, 12, 1, 1)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (2, 8, 2, 1)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (3, 12, 1, 2)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (4, 9, 2, 2)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (5, 14, 1, 3)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (6, 10, 1, 3)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (7, 12, 1, 7)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (8, 14, 3, 7)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (11, 13, 1, 9)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (12, 12, 1, 10)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (13, 13, 1, 12)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (14, 12, 1, 16)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (15, 13, 1, 17)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (16, 13, 1, 18)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (17, 13, 1, 19)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (18, 12, 1, 20)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (19, 10, 1, 21)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (20, 12, 1, 21)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (21, 12, 1, 22)
INSERT [dbo].[FastFoodCart] ([FastFoodCartId], [FastFoodId], [Quantity], [CartId]) VALUES (22, 14, 1, 23)
SET IDENTITY_INSERT [dbo].[FastFoodCart] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (1, N'PHÙ THỦY TỐI THƯỢNG TRONG ĐA VŨ TRỤ HỖN LOẠN', N'Hành Động, Phiêu Lưu, Thần thoại', CAST(N'2022-05-04' AS Date), CAST(N'2022-06-15' AS Date), 126, N'Tiếng Anh - Phụ đề Tiếng Việt', N'C13 - PHIM CẤM KHÁN GIẢ DƯỚI 13 TUỔI', N'Sự kiện xảy sau phần phim Người Nhện: Không còn nhà (2021) và mùa đầu tiên của Loki (2021), Bác sĩ Stephen Strange đã sử dụng một phét thuật bị cấm và mở ra cánh cổng dẫn tới đa vũ trụ, vô tình dẫn đưa một biến thể hắc ám của Stephen Strange khác đến vũ trụ mình - mối đe dọa lớn mà Dr. Strange có thể phải đối đầu hoặc hợp sức chống lại một cái ác khác, đồng hành cùng Strange còn có Wong và Wanda Maximoff cùng với nhân vật mới American Chavez.', N'image/movie/phuthuytoithuong.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (2, N'DAENG – HẬU DUỆ “TÌNH NGƯỜI DUYÊN MA”', N'Kinh Dị', CAST(N'2022-05-20' AS Date), CAST(N'2022-06-21' AS Date), 96, N'Tiếng Thái - Phụ đề tiếng Việt', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Nối tiếp câu chuyện “Tình Người Duyên Ma” của nàng Nak - ma nữ nổi tiếng của người Thái với người chồng tên Mak, truyền thuyết cổ dựa trên những sự kiện lịch sử diễn ra từ thời vua Rama IV, Daeng là bộ phim kể về đứa bé ma do Nak sinh ra. Bộ phim xoay quanh cuộc sống của Daeng khi không có bố mẹ bên cạnh và tình bạn cũng như tình yêu với con người. Liệu cậu bé có được chào đón ở thế giới của con người hay phải đối diện với sự xa lánh, xua đuổi của dân làng như mẹ Nak?', N'image/movie/hauduetinhnguoiduyenma.png')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (3, N'THẾ GIỚI KHỦNG LONG: LÃNH ĐỊA', N'Hài, Hoạt Hình, Phiêu Lưu', CAST(N'2022-06-10' AS Date), CAST(N'2022-08-30' AS Date), 147, N'Tiếng Anh với phụ đề tiếng Việt', N'C13 - PHIM CẤM KHÁN GIẢ DƯỚI 13 TUỔI', N'Bốn năm sau kết thúc Jurassic World: Fallen Kingdom, những con khủng long đã thoát khỏi nơi giam cầm và tiến vào thế giới loài người. Giờ đây, chúng xuất hiện ở khắp mọi nơi. Sinh vật to lớn ấy không còn chỉ ở trên đảo như trước nữa mà gần ngay trước mắt, thậm chí còn có thể chạm tới. Owen Grady may mắn gặp lại cô khủng long mà anh và khán giả vô cùng yêu mến - Blue. Tuy nhiên, Blue không đi một mình mà còn đem theo một chú khủng long con khác. Điều này khiến Owen càng quyết tâm bảo vệ mẹ con cô được sinh sống an toàn. Thế nhưng, hai giống loài quá khác biệt. Liệu có thể tồn tại một kỷ nguyên mà khủng long và con người sống chung một cách hòa bình?', N'image/movie/thegioikhunglonglanhdia.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (4, N'KẺ THỨ BA', N'Tâm Lý, Tình cảm', CAST(N'2022-05-13' AS Date), CAST(N'2022-06-26' AS Date), 87, N'Tiếng Việt - Phụ đề Tiếng Anh', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Kẻ Thứ Ba là câu chuyện về Thiên Di (diễn viên Lý Nhã Kỳ), một nữ bác sĩ bạc mệnh qua đời trong một vụ tai nạn giao thông. Dù đã ra đi hơn một năm nhưng Thiên Di vẫn để lại cho chồng cô, họa sĩ Quang Kha (nam tài tử xứ Hàn Han Jae Suk thủ vai) nỗi đau khôn xiết cùng những hoài niệm về tháng ngày hạnh phúc. Vô tình Quang Kha mua được một chiếc laptop có thể liên lạc được về quá khứ của một nữ VJ nổi tiếng (diễn viên Kim Tuyến). Quang Kha tìm cách nhờ nữ VJ cứu vợ khỏi cuộc tai nạn năm xưa, đổi lại anh cho cô biết dãy số trúng độc đắc Vietlott giải thưởng hơn trăm tỉ… Khi nữ VJ nhận lời giúp đỡ Quang Kha là lúc vòng xoáy của những âm mưu, tội ác và cả những cú twist liên tục được hé lộ, lôi cuốn khán giả đi từ bất ngờ này đến bất ngờ khác. Kẻ thứ ba, thậm chí là Kẻ thứ tư bất ngờ lộ diện, ai cũng có lý do với những mưu cầu cá nhân khiến câu chuyện trở nên kịch tính, khó đoán định. Kẻ Thứ Ba do diễn viên Lý Nhã Kỳ sản xuất trở thành bữa tiệc cuốn hút khác lạ của điện ảnh Việt bởi những drama, tình tiết lôi cuốn được ra rạp từ 13.5.2022', N'image/movie/kethuba.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (5, N'CUỘC CHIẾN ĐA VŨ TRỤ', N'Khoa Học Viễn Tưởng, Thần thoại', CAST(N'2022-06-24' AS Date), CAST(N'2022-08-30' AS Date), 140, N'Tiếng Anh - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Một phụ nữ trung niên nhập cư người Trung Quốc bị cuốn vào một cuộc phiêu lưu điên cuồng, nơi cô ấy một mình giải cứu thế giới bằng cách khám phá các vũ trụ khác và các bản thể khác của chính cô.', N'image/movie/davutru.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (6, N'CẢNH SÁT VŨ TRỤ LIGHTYEAR', N'Hoạt Hình', CAST(N'2022-06-17' AS Date), CAST(N'2022-08-30' AS Date), 105, N'Tiếng Anh - Phụ đề Tiếng Việt; Lồng tiếng', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Bộ phim kể về chuyến hành trình hành động kết hợp khoa học viễn tưởng nhằm giới thiệu câu chuyện về nguồn gốc của nhân vật Buzz Lightyear — người anh hùng đã truyền cảm hứng sáng tạo ra đồ chơi. “Lightyear” sẽ theo chân Cảnh Sát Vũ Trụ huyền thoại trong cuộc hành trình bước ra ngoài không gian cùng với một nhóm chiến binh đầy tham vọng và người bạn đồng hành là chú mèo máy Sox.', N'image/movie/canhsatvutrulightyear.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (7, N'EM VÀ TRỊNH', N'Tình cảm', CAST(N'2022-06-17' AS Date), CAST(N'2022-08-30' AS Date), 136, N'Tiếng Việt - Phụ đề Tiếng Anh', N'C13 - PHIM CẤM KHÁN GIẢ DƯỚI 13 TUỔI', N'Cuộc gặp gỡ định mệnh giữa Trịnh Công Sơn và nữ sinh viên Nhật Bản Michiko tại Paris năm 1990 đã mở ra một mối duyên kỳ ngộ. Từ đây bắt đầu hành trình ngược dòng thời gian, khám phá tuổi thanh xuân và tình yêu của người nhạc sĩ tài hoa với các nàng thơ Thanh Thuý, Bích Diễm, Dao Ánh, Khánh Ly, và những tình khúc mà họ lưu lại trong trái tim ông. Bộ phim lãng mạn, mở ra thế giới nhạc Trịnh quyến rũ với những mảnh ghép tình yêu đa sắc, lung linh tuyệt đẹp.', N'image/movie/emvatrinh.png')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (8, N'ĐẠI NÁO CUNG TRĂNG', N'Gia đình, Hoạt Hình, Phiêu Lưu', CAST(N'2022-06-03' AS Date), CAST(N'2022-08-30' AS Date), 84, N'Tiếng Anh - Phụ đề Tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Chuyến phiêu lưu đến Mặt Trăng của Peter bắt đầu khi em gái cậu, Anne, bị tên Trăng Tặc độc ác bắt cóc khi cô bé đang cố gắng giúp Bác Bọ Zoomzeman tìm lại vợ của mình. Trong cuộc hành trình đầy bất ngờ ấy, Peter gặp Thần Ngủ ở Đồng Cỏ Sao. Để giải cứu Anne, họ đã cùng nhau tham gia một cuộc đua kỳ thú dọc Dải Ngân Hà với 5 vị thần thiên nhiên: Ngài Bão Tố, Phù Thủy Sấm, Ngài Mưa Đá, Bậc Thầy Mưa Gió, và Bà Chúa Tuyết.', N'image/movie/dainaocungtrang.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (9, N'CHUYẾN PHIÊU LƯU CỦA PIL
', N'Hoạt Hình', CAST(N'2022-06-01' AS Date), CAST(N'2022-06-26' AS Date), 89, N'Tiếng Anh - Phụ đề Tiếng Việt; Lồng tiếng', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Ngày xửa ngày xưa, có một cô bé mồ côi phải trở thành nàng công chúa bất đắc dĩ không giống ai. Một ngày nọ, hoàng tử bị một tên quan độc ác đầu độc và khiến Pil cùng những người bạn phải đứng lên bảo vệ mình và cả vương quốc.', N'image/movie/pil.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (10, N'AVATAR 2 - DÒNG CHẢY CỦA NƯỚC', N'Khoa học viễn tưởng, Sử thi', CAST(N'2022-12-16' AS Date), NULL, 0, N'Tiếng Anh - Phụ đề Tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Hai nhân vật chính, Jake Sully và Neytiri, giờ đã thành đôi và nguyện sẽ ở bên nhau. Tuy nhiên, cả hai buộc phải rời khỏi nhà và khám phá những miền đất mới trên mặt trăng Pandora, cũng chính là lúc những mối nguy cũ quay lại cản trở họ', N'image/movie/avatardongchaycuanuoc.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (11, N'HARRY POTTER VÀ TÙ NHÂN AZKABAN (RE-RUN)', N'Phiêu Lưu, Thần thoại', CAST(N'2022-06-17' AS Date), CAST(N'2022-08-30' AS Date), 141, N'Tiếng Anh - Phụ đề Tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Năm thứ ba của Harry Potter bắt đầu trở nên tồi tệ khi Harry phát hiện ra tên sát nhân Sirius Black đã trốn thoát khỏi nhà tù Azkaban và đang tìm đến Harry để trả thù. Một loạt cai ngục Azkaban được cử đến để bảo vệ Hogwarts và truy đuổi Sirius Black. Một giáo viên bí ẩn đã xuất hiện để dạy Harry Potter cách bảo vệ bản thân. Tuy nhiên, Harry dần phát hiện ra bí mật của mối quan hệ giữa Harry và tên sát nhân Sirius Black phức tạp hơn cậu nghĩ. (Re-run)', N'image/movie/harrypotter&tunhan.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (12, N'ĐIỆN THOẠI ĐEN', N'Kinh Dị', CAST(N'2022-06-24' AS Date), CAST(N'2022-08-30' AS Date), 101, N'Tiếng Anh - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Finney Shaw, một cậu bé 13 tuổi nhút nhát nhưng thông minh, bị một kẻ giết người tàn bạo bắt cóc và nhốt trong một tầng hầm cách âm, nơi tiếng la hét trở nên vô ích. Khi một chiếc điện thoại bị ngắt kết nối trên tường bắt đầu đổ chuông, Finney phát hiện ra rằng cậu có thể nghe thấy giọng nói từ những nạn nhân trước đây của kẻ giết người. Và họ đã cố gắng đảm bảo rằng những gì đã xảy ra với họ không xảy ra với Finney.', N'image/movie/dienthoaiden.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (13, N'THOR: TÌNH YÊU VÀ SẤM SÉT', N'Hành Động, Phiêu Lưu, Thần thoại', CAST(N'2022-07-08' AS Date), NULL, 139, N'Tiếng Anh - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Vốn từng là một chiến binh hùng mạnh của Asgard, trải qua vô số trận chiến lớn nhỏ nhưng sau sự kiện trong Avengers: Endgame (2019) cùng vô số mất mát, Thần Sấm không còn muốn theo đuổi con đường siêu anh hùng. Từ đây, anh lên đường tìm ra ý nghĩa của cuộc sống và nhìn nhận lại bản thân mình.', N'image/movie/thortinhyeuvasamset.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (22, N'DORAEMON VÀ NOBITA VÀ CUỘC CHIẾN VŨ TRỤ TÍ HON 2021', N'Gia đình, Hoạt Hình', CAST(N'2022-05-27' AS Date), CAST(N'2022-08-30' AS Date), 109, N'Tiếng Nhật - Phụ đề Tiếng Việt; Lồng tiếng', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Nobita tình cờ gặp được người ngoài hành tinh tí hon Papi, vốn là Tổng thống của hành tinh Pirika, chạy trốn tới Trái Đất để thoát khỏi những kẻ nổi loạn nơi quê nhà. Doraemon, Nobita và hội bạn thân dùng bảo bối đèn pin thu nhỏ biến đổi theo kích cỡ giống Papi để chơi cùng cậu bé. Thế nhưng, một tàu chiến không gian tấn công cả nhóm. Cảm thấy có trách nhiệm vì liên lụy mọi người, Papi quyết định một mình đương đầu với quân phiến loạn tàn ác. Doraemon và các bạn lên đường đến hành tinh Pirika, sát cánh bên người bạn của mình.', N'image/movie/doremonvanobita.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (28, N'PHI CÔNG SIÊU ĐẲNG MAVERICK', N'Hành Động, Phiêu Lưu', CAST(N'2022-05-27' AS Date), CAST(N'2022-08-30' AS Date), 130, N'Tiếng Anh với phụ đề tiếng Việt', N'C13 - PHIM CẤM KHÁN GIẢ DƯỚI 13 TUỔI', N'Sau hơn ba mươi năm phục vụ, Pete “Maverick” Mitchell từng nổi danh là một phi công thử nghiệm quả cảm hàng đầu của Hải quân, né tránh cơ hội thăng chức, điều khiến anh cảm thấy bị bó buộc, để trở về làm chính mình.', N'image/movie/dssss.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (30, N'SÁT THỦ NHÂN TẠO 2: MẪU VẬT CÒN LẠI', N'Hành Động', CAST(N'2022-07-01' AS Date), CAST(N'2022-08-30' AS Date), 137, N'Tiếng Hàn - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Lợi dụng sự cố kinh hoàng tại cơ sở thí nghiệm, cô nàng 17 tuổi mang bí danh ARK-ADP1, một nữ sát thủ nhân tạo có siêu năng lực, đã thoát được ra ngoài. Cô bị những người tạo ra mình lẫn các thế lực bí ẩn khác truy bắt gắt gao.', N'image/movie/satthunhantao.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (31, N'THÁM TỬ LỪNG DANH CONAN: NÀNG DÂU HALLOWEEN', N'Hoạt Hình', CAST(N'2022-07-22' AS Date), NULL, 111, N'Tiếng Nhật - Phụ đề Tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Tại Shibuya náo nhiệt mùa Halloween, Thiếu úy Sato Miwako khoác lên mình chiếc váy cưới tinh khôi trong tiệc cưới như cổ tích, và người đàn ông bên cạnh cô không ai khác ngoài Trung sĩ Takagi Wataru. Trong giây phút trọng đại, một nhóm người xấu ập vào tấn công, Trung sĩ Takagi liều mình bảo vệ Sato. Anh tai qua nạn khỏi, nhưng Sato chết lặng khi nhìn thấy bóng ma Thần Chết trong giây phút sinh tử của Takagi. Điều này khiến cô nhớ lại cái chết của đồng nghiệp, cũng là người cô từng yêu trước đây, Thanh tra Matsuda Jinpei. Cùng lúc này, hung thủ của vụ đánh bom liên tiếp mà Matsuda điều tra năm xưa đã vượt ngục thành công. Khi Conan tìm đến Furuya Rei (hay Amuro Toru), người bạn cùng khóa với Matsuda, cậu được nghe câu chuyện liên quan đến vụ đánh bom với kẻ thủ ác mang bí danh "Plamya". Hôn lễ nguy hiểm nhất thế giới, buổi dạ hành đẫm máu tại Shibuya vào đêm Halloween sắp sửa bắt đầu.', N'image/movie/conan.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (32, N'BLACK ADAM', N'Hành Động, Phiêu Lưu', CAST(N'2022-10-21' AS Date), NULL, 0, N'Tiếng Anh với phụ đề tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Dwayne Johnson sẽ góp mặt trong tác phẩm hành động - phiêu lưu mới của New Line Cinema, mang tên BLACK ADAM. Đây là bộ phim đầu tiên trên màn ảnh rộng khai thác câu chuyện của siêu anh hùng DC này, dưới sự sáng tạo của đạo diễn Jaume Collet-Serra (đạo diễn của Jungle Cruise). Gần 5.000 năm sau khi bị cầm tù với quyền năng tối thượng từ những vị thần cổ đại, Black Adam (Dwayne Johnson) sẽ được giải phóng khỏi nấm mồ chết chóc của mình, mang tới thế giới hiện đại một kiểu nhận thức về công lý hoàn toàn mới.', N'image/movie/blackadam.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (33, N'MINIONS: SỰ TRỖI DẬY CỦA GRU', N'Hài, Hoạt Hình, Phiêu Lưu', CAST(N'2022-07-01' AS Date), CAST(N'2022-08-30' AS Date), 88, N'Tiếng Anh với phụ đề tiếng Việt và lồng tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Rất lâu trước khi trở thành một phản diện chuyên nghiệp, Gru chỉ là một cậu bé 12 tuổi sống ở vùng ngoại ô vào những năm 1970, với ước mơ một ngày sẽ làm “bá chủ” thế giới. Và 3 “quả chuối” vàng biết đi từ trên trời rơi xuống đã là những đồng đội đầu tiên của Gru, bên cạnh ủng hộ cậu bé, cùng nhau thiết kế những vũ khí đầu tiên, thực hiện những phi vụ đầu tiên.', N'image/movie/minions.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (34, N'LIÊN MINH SIÊU THÚ DC', N'Hoạt Hình', CAST(N'2022-07-29' AS Date), CAST(N'2022-08-15' AS Date), 0, N'Tiếng Anh với phụ đề tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Trong “Liên Minh Siêu Thú DC”, Siêu Cún Krypto và Superman là cặp bài trùng không thể tách rời, cùng sở hữu những siêu năng lực tương tự và cùng nhau chiến đấu chống lại tội phạm tại thành phố Metropolis. Khi Superman và những thành viên của Liên Minh Công Lý bị bắt cóc, Krypto phải thuyết phục cậu chàng Ace luộm thuộm, nàng Heo PB, Rùa Merton và Sóc Chip khai phá những sức mạnh tiềm ẩn và cùng nhau giải cứu các siêu anh hùng. “Liên Minh Siêu Thú DC” có sự góp giọng của bộ đôi ngôi sao nổi tiếng bậc nhất Hollywood Dwayne Johnson (lồng tiếng cho Siêu cún Krypto) và Kevin Hart (Superman). Đặc biệt, tài tử Keanu Reeves sẽ đảm nhận những câu thoại chất lừ đến từ Batman.', N'image/movie/sieuthu.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (35, N'Dragon Ball Super: SUPER HERO', N'Hoạt Hình', CAST(N'2022-08-15' AS Date), CAST(N'2022-08-30' AS Date), 125, N'Tiếng Nhật - Phụ đề Tiếng Việt', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Đội quân Ruy Băng Đỏ đã bị Son Goku tiêu diệt. Thế nhưng, những kẻ kế nghiệp của chúng đã tạo ra hai chiến binh Android mới là Gamma 1 và Gamma 2. Hai Android này tự nhận mình là “Siêu anh hùng”. Chúng bắt đầu tấn công Piccolo và Gohan… Mục tiêu của Đội quân Ruy Băng Đỏ mới này là gì? Trước nguy cơ cận kề, đã đến lúc các siêu anh hùng thực thụ phải thức tỉnh!', N'image/movie/dragonball.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (36, N'QUYẾT TÂM CHIA TAY', N'Hồi hộp, Tình cảm', CAST(N'2022-07-15' AS Date), CAST(N'2022-08-15' AS Date), 138, N'Tiếng Hàn - Phụ đề tiếng Việt, tiếng Anh', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Một thanh tra cảnh sát rơi vào lưới tình với goá phụ trẻ - nghi phạm giết người trong vụ án mà anh ta đang điều tra.', N'image/movie/quyettamchiatay.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (37, N'LINH HỒN VŨ NỮ', N'Kinh Dị', CAST(N'2022-07-22' AS Date), CAST(N'2022-08-22' AS Date), 123, N'Tiếng Indonesia với phụ đề tiếng Việt', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Sáu học sinh đi vào một ngôi làng hẻo lánh để thực hiện chương trình công ích. Và họ không biết được rằng đây là vùng đất của những linh hồn bị mắc kẹt dưới sự cai trị của Badarawuhi – một linh hồn vũ nữ.', N'image/movie/linhhonvunu.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (38, N'PORORO: CUỘC PHIÊU LƯU ĐẾN ĐẢO KHỦNG LONG', N'Hoạt Hình', CAST(N'2022-07-15' AS Date), CAST(N'2022-08-15' AS Date), 79, N'Tiếng Hàn - Phụ đề tiếng Việt, lồng tiếng', N'P - PHIM DÀNH CHO MỌI ĐỐI TƯỢNG', N'Pororo và những người bạn tìm thấy chú khủng long nhỏ Alo đang ngủ say trong chiếc phi thuyền hình quả trứng. Alo không nhớ gì ngoài tên của mình. Khi Pororo và bạn bè giúp Alo sửa phi thuyền thì phi thuyền vụt sáng và biến mất cùng Alo và người bạn của Pororo là Crong. Pororo đuổi theo chiếc phi thuyền đến Đảo Khủng Long và chạm trán với Mr.Y, kẻ chuyên bắt cóc khủng long để bán cho người ngoài hành tinh. Để giải cứu bạn của mình, Pororo phải vượt qua nỗi sợ khủng long để chiến đấu với người ngoài hành tinh và đội quân người máy của Mr.Y.', N'image/movie/pororo.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (39, N'KAREM: VẬT CHỨA TỬ THẦN', N'Kinh Dị', CAST(N'2022-07-15' AS Date), CAST(N'2022-08-15' AS Date), 80, N'Tiếng Tây Ban Nha - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Karem (Raquel Rodríguez), cô con út của gia đình Briseno bị một thế lực quỷ dữ vô cùng tàn ác đeo bám. Nhờ quyền năng của quỷ, cô bé có thể thao túng người khác. Lợi dụng sức mạnh đó, Karem lên kế hoạch trả đũa tất cả những ai từng bắt nạt mình. Nhưng chơi dao có ngày đứt tay, Karem không thể ngờ rằng cái bắt tay của cô bé và con quỷ lại dẫn tới hàng loạt bi kịch thảm khốc.', N'image/movie/karem.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (40, N'XÁC SỐNG 32s', N'Kinh Dị', CAST(N'2022-07-08' AS Date), CAST(N'2022-08-08' AS Date), 89, N'Tiếng Tây Ban Nha - Phụ đề Tiếng Việt', N'C18 - PHIM CẤM KHÁN GIẢ DƯỚI 18 TUỔI', N'Dịch bệnh xác sống bùng phát, dẫn đến hàng loạt vụ thảm sát rùng rợn trên các con phố của Montevideo (Uruquay). Kẻ nhiễm bệnh trở nên khát máu và liên tục sát hại những ai chưa mắc bệnh một cách tàn bạo. Không hay biết gì về điều này, Iris và con gái dành cả ngày tại câu lạc bộ thể thao nơi cô làm nhân viên bảo vệ. Khi đêm đến, đàn thây ma bắt đầu tấn công nơi này khiến Iris phải cố gắng chiến đấu để sống sót. Hy vọng duy nhất của họ là đám xác sống sẽ đứng yên trong 32 giây sau khi hạ sát một con mồi.', N'image/movie/xacsong32giay.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (41, N'LÀ MÂY TRÊN BẦU TRỜI AI ĐÓ', N'Hài, Tình cảm', CAST(N'2022-07-22' AS Date), CAST(N'2022-08-22' AS Date), 89, N'Tiếng Việt với phụ đề tiếng Anh', N'C13 - PHIM CẤM KHÁN GIẢ DƯỚI 13 TUỔI', N'Nàng tiểu thư đỏng đảnh Mây sang Thái Lan để theo đuổi một “nam thần” nổi tiếng, tình cờ lại va phải anh chàng “oan gia” và cùng nhau trải qua những tình huống dở khóc dở cười', N'image/movie/lamaytrenbautroi.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (42, N'CHERRY MAGIC: 30 TUỔI VẪN CÒN “ZIN” SẼ BIẾN THÀNH PHÙ THỦY', N'Tình cảm', CAST(N'2022-07-15' AS Date), CAST(N'2022-08-15' AS Date), 104, N'Tiếng Nhật - Phụ đề Tiếng Việt', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Bản phim điện ảnh lãng mạn, ấm áp của hiện tượng gây sốt châu Á “CHERRY MAGIC: 30 TUỔI VẪN CÒN “ZIN” SẼ BIẾN THÀNH PHÙ THỦY”. Adachi là một nhân viên văn phòng, bước sang tuổi 30 và vẫn còn "zin". Vào sinh nhật thứ 30 của mình, anh chàng được ban tặng phép thuật kỳ lạ. Adachi có thể đọc được suy nghĩ của những người anh ta chạm vào. Kurosawa là người yêu của Adachi tại nơi làm việc, nổi tiếng và thành đạt. Họ yêu nhau bí mật tại chốn công sở. Một ngày nọ, Adachi nhận được một cơ hội việc làm mới. Adachi sẽ được làm việc mình thích nhưng địa điểm mới lại ở Nagasaki, cách Kurosawa tận 1.200 km. Trải qua những khó khăn và thử thách khi yêu xa khiến họ phải suy nghĩ lại về mối quan hệ và tương lai của mình. Mối quan hệ của họ sẽ ra sao?', N'image/movie/cherrymagic.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (43, N'THOÁT KHỎI MOGADISHU', N'Hành Động, Hồi hộp, Tâm Lý', CAST(N'2022-07-15' AS Date), CAST(N'2022-08-15' AS Date), 121, N'Tiếng Hàn - Phụ đề tiếng Việt', N'C16 - PHIM CẤM KHÁN GIẢ DƯỚI 16 TUỔI', N'Dựa trên một sự kiện lịch sử khó tin nhưng có thật, bộ phim tái hiện lại lần hợp tác gay cấn, chưa từng có tiền lệ giữa các nhà ngoại giao Nam và Bắc Hàn nhằm giải thoát công dân của họ khỏi cuộc binh biến tại Somalia vào năm 1991.', N'image/movie/thoatkhoimogadishu.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (44, N'CHUYỆN MA GIẢNG ĐƯỜNG – HỌC KỲ 2', N'Kinh Dị', CAST(N'2022-07-29' AS Date), NULL, NULL, N'Tiếng Thái - Phụ đề tiếng Việt', NULL, N'Tiếng Thái - Phụ đề tiếng Việt', N'image/movie/chuyenmagiangduong.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (45, N'QUÁI THÚ', N'Hồi hộp, Kinh Dị', CAST(N'2022-08-19' AS Date), NULL, NULL, N'Tiếng Anh - Phụ đề Tiếng Việt', NULL, N'Người cha đơn thân là tiến sĩ Nate Daniels do Idris Elba thủ vai, cùng hai cô con gái trong chuyến đi dã ngoại tới khu bảo tồn thiên nhiên được quản lý bởi người bạn cũ của gia đình, và cũng là nhà sinh vật học, chuyên nghiên cứu về động vật hoang dã. Thế nhưng, những gì bắt đầu một cuộc hành trình gắn kết tình cảm gia đình và giải tỏa căng thẳng lại trở thành một cuộc chiến sinh tồn đáng sợ khi một loài thú khát máu coi tất cả là kẻ thù, bắt đầu rình rập họ.', N'image/movie/quaithu.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (46, N'SÁT THỦ ĐỐI ĐẦU', N'Hành Động, Hồi hộp', CAST(N'2022-08-12' AS Date), NULL, NULL, N'Tiếng Anh - Phụ đề Tiếng Việt', NULL, N'Ladybug (Brad Pitt) - một sát thủ lành nghề vừa trở lại sau khoảng thời gian nghỉ hưu. Anh nhận nhiệm vụ từ một phụ nữ bí ẩn là thu hồi chiếc vali trên chuyến tàu cao tốc ở Nhật Bản. Những tưởng đây sẽ là phi vụ dễ ăn thì một loạt biến cố ập đến. Ladybug phải đối mặt với vô số thế lực khác nhau trên chiếc tàu hỏa cùng nhắm vào chiếc vali kia. Đối thủ của anh lần lượt là Lemon (Brian Tyree Henry), Kimura (Andrew Koji), Hornet (Zazie Beetz), Prince (Joey King) và Tangerine (Aaron Taylor-Johnson). Mỗi người đều có những âm mưu và cách thức hoạt động riêng dẫn đến một cục diện vô cùng rối ren.', N'image/movie/satthudoidau.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (47, N'VÔ DIỆN SÁT NHÂN', N'Kinh Dị', CAST(N'2022-08-26' AS Date), NULL, NULL, N'Tiếng Việt - Phụ đề Tiếng Anh', NULL, N'Tác phẩm thuộc thể loại kinh dị - giật gân theo hướng slasher, một phong cách phim kinh dị mang đậm dấu ấn của điện ảnh Hollywood. Bộ phim nói về Phương Anh, một bác sĩ trẻ tài năng và có một cuộc sống tưởng chừng như hoàn hảo. Thế nhưng, hằng đêm cô đều phải đối mặt với một tên sát nhân vô diện trong mỗi giấc mơ. Cơn ác mộng dần trở nên kinh hoàng hơn khi hắn bắt đầu truy sát cô cả ngoài đời thực. Phương Anh quyết định đi tìm lời giải cho chính mình. "Vô Diện Sát Nhân" thực sự là ai? Sự thật đáng sợ nào đang nằm sau những bí mật này? Phim có sự tham gia của dàn diễn viên trẻ tiềm năng: Phương Anh Đào, Oanh Kiều, Hiếu Nguyễn, Quách Ngọc Tuyên, Hoàng Phúc...', N'image/movie/vodiensatnhan.jpg')
INSERT [dbo].[Movie] ([MovieId], [MovieName], [Category], [StartDate], [EndDate], [Duration], [Language], [Rated], [Description], [Img]) VALUES (48, N'MỒI QUỶ DỮ', N'Hồi hộp, Kinh Dị', CAST(N'2022-10-28' AS Date), NULL, NULL, N'Tiếng Anh - Phụ đề Tiếng Việt', NULL, N'“Mồi Quỷ Dữ” xoay quanh sơ Ann (do Jacqueline Byers thủ vai) bị kéo vào một cuộc chiến tại một Nhà Thờ Công Giáo trước thế lực quỷ ám đang ngày một hùng mạnh. Với khả năng chiến đấu với quỷ dữ, sơ Ann được phép thực hiện các buổi trừ tà dẫu cho các luật lệ xưa cũ chỉ cho phép Cha xứ thực hiện công việc này. Cùng với Cha Dante, sơ Ann chạm mặt một con quỷ dữ đang cố chiếm lấy linh hồn của một cô gái trẻ, và cũng có thể là kẻ đã ám lấy người mẹ quá cố của sơ. Sơ Ann dần nhận ra mối nguy đang đe dọa mình khủng khiếp thế nào, và cả lý do con quỷ dữ đó khao khát đoạt mạng cô.', N'image/movie/moiquydu.jpg')
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[MovieTime] ON 

INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (1, 1, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (2, 4, CAST(N'14:30:00' AS Time), CAST(N'16:30:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (3, 2, CAST(N'10:10:00' AS Time), CAST(N'12:10:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (4, 6, CAST(N'18:50:00' AS Time), CAST(N'20:50:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (5, 3, CAST(N'12:30:00' AS Time), CAST(N'14:30:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (6, 5, CAST(N'16:40:00' AS Time), CAST(N'18:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (7, 7, CAST(N'21:00:00' AS Time), CAST(N'23:00:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (8, 2, CAST(N'10:40:00' AS Time), CAST(N'12:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (9, 3, CAST(N'12:20:00' AS Time), CAST(N'14:20:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (10, 1, CAST(N'08:30:00' AS Time), CAST(N'10:30:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (11, 4, CAST(N'13:40:00' AS Time), CAST(N'15:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (12, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (13, 2, CAST(N'09:40:00' AS Time), CAST(N'11:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (14, 3, CAST(N'11:50:00' AS Time), CAST(N'13:50:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (17, 1, CAST(N'07:40:00' AS Time), CAST(N'09:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (24, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (25, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (26, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 1)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (27, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (28, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (29, 3, CAST(N'11:50:00' AS Time), CAST(N'13:30:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (30, 1, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), 5)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (31, 2, CAST(N'10:10:00' AS Time), CAST(N'12:10:00' AS Time), 5)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (32, 3, CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (33, 2, CAST(N'09:50:00' AS Time), CAST(N'11:50:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (34, 4, CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (35, 4, CAST(N'14:10:00' AS Time), CAST(N'16:10:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (36, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 6)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (38, 3, CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (39, 5, CAST(N'16:20:00' AS Time), CAST(N'18:40:00' AS Time), 2)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (41, 2, CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (42, 3, CAST(N'12:10:00' AS Time), CAST(N'13:40:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (43, 3, CAST(N'12:00:00' AS Time), CAST(N'14:20:00' AS Time), 4)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (44, 1, CAST(N'07:30:00' AS Time), CAST(N'09:50:00' AS Time), 7)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (45, 2, CAST(N'10:00:00' AS Time), CAST(N'12:00:00' AS Time), 7)
INSERT [dbo].[MovieTime] ([MovieTimeId], [Slot], [Start], [Finish], [DateRoomID]) VALUES (46, 1, CAST(N'07:30:00' AS Time), CAST(N'09:30:00' AS Time), 8)
SET IDENTITY_INSERT [dbo].[MovieTime] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (1, N'Cinema1')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (2, N'Cinema2')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (4, N'Cinema3')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (5, N'VIP1')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (6, N'VIP2')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (7, N'Cinema4')
INSERT [dbo].[Room] ([RoomId], [RoomName]) VALUES (11, N'Cinema5')
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[Seat] ON 

INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (1, 1, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (2, 2, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (3, 3, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (4, 4, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (5, 5, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (6, 6, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (7, 7, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (8, 8, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (9, 9, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (10, 10, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (11, 11, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (12, 12, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (13, 13, 65, N'A')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (14, 1, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (15, 2, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (16, 3, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (17, 4, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (18, 5, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (19, 6, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (20, 7, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (21, 8, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (22, 9, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (23, 10, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (24, 11, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (25, 12, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (26, 13, 65, N'B')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (27, 1, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (28, 2, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (29, 3, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (30, 4, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (31, 5, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (32, 6, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (33, 7, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (34, 8, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (35, 9, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (36, 10, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (37, 11, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (38, 12, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (39, 13, 65, N'C')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (40, 1, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (41, 2, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (42, 3, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (43, 4, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (44, 5, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (45, 6, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (46, 7, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (47, 8, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (48, 9, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (49, 10, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (50, 11, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (51, 12, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (52, 13, 65, N'D')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (53, 1, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (54, 2, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (55, 3, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (56, 4, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (57, 5, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (58, 6, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (59, 7, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (60, 8, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (61, 9, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (62, 10, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (63, 11, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (64, 12, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (65, 13, 65, N'E')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (66, 1, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (67, 2, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (68, 3, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (69, 4, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (70, 5, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (71, 6, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (72, 7, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (73, 8, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (74, 9, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (75, 10, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (76, 11, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (77, 12, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (78, 13, 65, N'F')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (79, 1, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (80, 2, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (81, 3, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (82, 4, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (83, 5, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (84, 6, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (85, 7, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (86, 8, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (87, 9, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (88, 10, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (89, 11, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (90, 12, 65, N'G')
INSERT [dbo].[Seat] ([SeatId], [SeatNumber], [SeatPrice], [SeatRow]) VALUES (91, 13, 65, N'G')
SET IDENTITY_INSERT [dbo].[Seat] OFF
GO
SET IDENTITY_INSERT [dbo].[SeatRoom] ON 

INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (1, 23, 26, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (2, 15, 1, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (3, 14, 1, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (4, 13, 1, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (5, 45, 3, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (6, 46, 3, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (7, 42, 3, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (8, 3, 5, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (9, 5, 5, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (10, 34, 5, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (11, 14, 5, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (12, 15, 5, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (13, 41, 21, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (15, 32, 19, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (62, 75, 19, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (63, 76, 19, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (72, 73, 43, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (73, 74, 43, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (76, 73, 44, 0)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (77, 74, 44, 0)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (81, 37, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (82, 31, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (83, 46, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (84, 65, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (85, 82, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (86, 58, 33, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (87, 59, 33, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (88, 63, 43, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (89, 64, 43, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (90, 8, 44, 1)
INSERT [dbo].[SeatRoom] ([SeatRoomId], [SeatId], [TimeRoomId], [status]) VALUES (91, 9, 44, 1)
SET IDENTITY_INSERT [dbo].[SeatRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[SeatRoomCart] ON 

INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (1, 2, 1)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (2, 3, 1)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (3, 4, 1)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (4, 1, 2)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (5, 5, 6)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (6, 6, 6)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (7, 12, 7)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (8, 13, 3)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (12, 62, 9)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (13, 63, 9)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (14, 72, 10)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (15, 73, 10)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (16, 76, 12)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (17, 77, 12)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (18, 81, 16)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (19, 82, 17)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (20, 83, 18)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (21, 84, 19)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (22, 85, 20)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (23, 86, 21)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (24, 87, 21)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (25, 88, 22)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (26, 89, 22)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (27, 90, 23)
INSERT [dbo].[SeatRoomCart] ([SeatRoomCartId], [SeatRoomId], [CartId]) VALUES (28, 91, 23)
SET IDENTITY_INSERT [dbo].[SeatRoomCart] OFF
GO
SET IDENTITY_INSERT [dbo].[TimeRoom] ON 

INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (1, 1, 3, 1, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (2, 1, 5, 3, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (3, 1, 6, 5, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (4, 1, 3, 2, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (5, 7, 7, 11, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (7, 4, 12, 12, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (8, 4, 8, 13, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (9, 4, 28, 14, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (12, 2, 5, 17, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (19, 2, 6, 24, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (20, 4, 7, 25, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (21, 7, 11, 26, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (22, 11, 22, 27, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (23, 5, 12, 28, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (24, 1, 3, 24, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (25, 6, 8, 24, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (26, 7, 8, 29, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (27, 2, 5, 30, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (28, 2, 7, 31, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (29, 5, 28, 32, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (30, 5, 5, 33, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (31, 1, 12, 4, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (32, 6, 8, 6, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (33, 4, 12, 34, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (34, 2, 11, 35, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (35, 2, 6, 36, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (37, 7, 12, 38, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (38, 2, 30, 39, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (43, 7, 33, 41, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (44, 1, 33, 42, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (45, 2, 30, 43, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (46, 4, 30, 44, 1)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (47, 4, 8, 45, 0)
INSERT [dbo].[TimeRoom] ([TimeRoomId], [RoomId], [MovieId], [MovieTimeId], [status]) VALUES (48, 4, 8, 46, 0)
SET IDENTITY_INSERT [dbo].[TimeRoom] OFF
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([AccountId])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Account]
GO
ALTER TABLE [dbo].[FastFoodCart]  WITH CHECK ADD  CONSTRAINT [FK_FastFoodCart_Cart] FOREIGN KEY([CartId])
REFERENCES [dbo].[Cart] ([CartId])
GO
ALTER TABLE [dbo].[FastFoodCart] CHECK CONSTRAINT [FK_FastFoodCart_Cart]
GO
ALTER TABLE [dbo].[FastFoodCart]  WITH CHECK ADD  CONSTRAINT [FK_FastFoodCart_FastFood] FOREIGN KEY([FastFoodId])
REFERENCES [dbo].[FastFood] ([FastFoodId])
GO
ALTER TABLE [dbo].[FastFoodCart] CHECK CONSTRAINT [FK_FastFoodCart_FastFood]
GO
ALTER TABLE [dbo].[MovieTime]  WITH CHECK ADD  CONSTRAINT [FK_MovieTime_DateRoom] FOREIGN KEY([DateRoomID])
REFERENCES [dbo].[DateRoom] ([DateRoomID])
GO
ALTER TABLE [dbo].[MovieTime] CHECK CONSTRAINT [FK_MovieTime_DateRoom]
GO
ALTER TABLE [dbo].[SeatRoom]  WITH NOCHECK ADD  CONSTRAINT [FK_SeatRoom_Seat1] FOREIGN KEY([SeatId])
REFERENCES [dbo].[Seat] ([SeatId])
GO
ALTER TABLE [dbo].[SeatRoom] CHECK CONSTRAINT [FK_SeatRoom_Seat1]
GO
ALTER TABLE [dbo].[SeatRoom]  WITH CHECK ADD  CONSTRAINT [FK_SeatRoom_TimeRoom1] FOREIGN KEY([TimeRoomId])
REFERENCES [dbo].[TimeRoom] ([TimeRoomId])
GO
ALTER TABLE [dbo].[SeatRoom] CHECK CONSTRAINT [FK_SeatRoom_TimeRoom1]
GO
ALTER TABLE [dbo].[SeatRoomCart]  WITH CHECK ADD  CONSTRAINT [FK_SeatRoomCart_Cart] FOREIGN KEY([CartId])
REFERENCES [dbo].[Cart] ([CartId])
GO
ALTER TABLE [dbo].[SeatRoomCart] CHECK CONSTRAINT [FK_SeatRoomCart_Cart]
GO
ALTER TABLE [dbo].[SeatRoomCart]  WITH CHECK ADD  CONSTRAINT [FK_SeatRoomCart_SeatRoom] FOREIGN KEY([SeatRoomId])
REFERENCES [dbo].[SeatRoom] ([SeatRoomId])
GO
ALTER TABLE [dbo].[SeatRoomCart] CHECK CONSTRAINT [FK_SeatRoomCart_SeatRoom]
GO
ALTER TABLE [dbo].[TimeRoom]  WITH CHECK ADD  CONSTRAINT [FK_TimeRoom_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([MovieId])
GO
ALTER TABLE [dbo].[TimeRoom] CHECK CONSTRAINT [FK_TimeRoom_Movie]
GO
ALTER TABLE [dbo].[TimeRoom]  WITH CHECK ADD  CONSTRAINT [FK_TimeRoom_MovieTime] FOREIGN KEY([MovieTimeId])
REFERENCES [dbo].[MovieTime] ([MovieTimeId])
GO
ALTER TABLE [dbo].[TimeRoom] CHECK CONSTRAINT [FK_TimeRoom_MovieTime]
GO
ALTER TABLE [dbo].[TimeRoom]  WITH CHECK ADD  CONSTRAINT [FK_TimeRoom_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
GO
ALTER TABLE [dbo].[TimeRoom] CHECK CONSTRAINT [FK_TimeRoom_Room]
GO
