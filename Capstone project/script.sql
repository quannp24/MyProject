USE [QuizArenaSQL]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[exam_id] [nvarchar](50) NOT NULL,
	[exam_name] [nvarchar](500) NULL,
	[quiz_id] [int] NULL,
	[description] [nvarchar](max) NULL,
	[exam_type] [int] NULL,
	[image] [nvarchar](255) NULL,
	[status] [int] NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_Exam] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamUser]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamUser](
	[exam_id] [nvarchar](50) NOT NULL,
	[user_id] [int] NOT NULL,
	[score] [int] NULL,
	[status] [int] NULL,
	[time_submit] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Friends]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Friends](
	[user_id] [int] NOT NULL,
	[friend_id] [int] NULL,
	[status] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistoryUser]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryUser](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[action_type] [int] NOT NULL,
	[quiz_id] [int] NULL,
	[date_action] [datetime] NOT NULL,
 CONSTRAINT [PK_HistoryUser] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[user_id] [int] NOT NULL,
	[content_notification] [nvarchar](255) NOT NULL,
	[value] [nvarchar](255) NULL,
	[date_notification] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[amount] [decimal](10, 2) NULL,
	[payment_date] [datetime] NULL,
	[payment_method] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[question_id] [int] IDENTITY(1,1) NOT NULL,
	[question_text] [text] NULL,
	[difficulty_level] [int] NULL,
	[category_id] [int] NULL,
	[user_id] [int] NULL,
	[correct_answer] [text] NULL,
	[status] [int] NULL,
	[options] [text] NULL,
 CONSTRAINT [PK__Question__2EC215494B1BF93D] PRIMARY KEY CLUSTERED 
(
	[question_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionsAttempts]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionsAttempts](
	[attempt_id] [int] IDENTITY(1,1) NOT NULL,
	[quiz_id] [int] NULL,
	[question_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[attempt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quizzes]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quizzes](
	[quiz_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](255) NULL,
	[category_id] [int] NULL,
	[description] [text] NULL,
	[quiz_type] [int] NULL,
	[status] [int] NULL,
	[image] [nvarchar](max) NULL,
	[difficulty_level] [int] NULL,
	[comment] [nvarchar](max) NULL,
	[time_limit] [int] NULL,
	[creator_id] [int] NULL,
	[create_date] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__Quizzes__2D7053EC876EAE07] PRIMARY KEY CLUSTERED 
(
	[quiz_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomQuiz]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomQuiz](
	[room_id] [nchar](10) NOT NULL,
	[quiz_id] [int] NOT NULL,
	[current_question] [int] NULL,
	[total_exp] [int] NULL,
 CONSTRAINT [PK_RoomQuiz] PRIMARY KEY CLUSTERED 
(
	[room_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoomQuiz]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoomQuiz](
	[room_id] [nchar](10) NOT NULL,
	[user_id] [int] NOT NULL,
	[role] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 20/12/2023 2:42:18 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NULL,
	[fullname] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[Description] [nvarchar](max) NULL,
	[password] [varchar](255) NULL,
	[role] [int] NULL,
	[exp] [int] NULL,
	[score] [int] NULL,
	[token] [varchar](255) NULL,
	[status] [int] NULL,
	[images] [varchar](255) NULL,
	[verification_code] [varchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK__Users__B9BE370F9B98699D] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (1, N'.NET6')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (2, N'Java')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (3, N'Angular')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (4, N'C#')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (5, N'C++')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (6, N'Python')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (7, N'NodeJS')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (8, N'HTML')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (9, N'PHP')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (10, N'TypeScript')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (11, N'JavaScript')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (12, N'SQL')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (13, N'Golang')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (14, N'Kotlin')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (15, N'Ruby')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'cYSjk4D29216A4B', N'CHALLENGE EVENT', 28, N'test challenge', 2, N'', 0, CAST(N'2023-12-10T22:00:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'hdic93HNid', N'Test challenge đây', 28, N'here we go', 1, N' image/challenge/74830c39-4854-4f6e-bfe4-209bc1cb8ea7.jpg', 0, CAST(N'2023-12-15T22:20:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'IJn9b1JHus', N'Boss Quiz', 34, N'where your knowledge will be challenged with many questions and everyone will have the right to participate', 2, N'image/challenge/bossquiz.png', 5, CAST(N'2022-08-24T18:30:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'k0Dow2jdoJ', N'Challenge Spring24', 5, N'End-of-season challenge for those ranked silver or higher, where your extensive knowledge is demonstrated. Get the top position to win', 1, NULL, 1, CAST(N'2024-05-30T18:30:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'k9fjeISuJ2', N'Challenge SP23', 32, N'End-of-season challenge for those ranked silver or higher, where your extensive knowledge is demonstrated. Get the top position to win', 1, N'image/challenge/SP23.png', 5, CAST(N'2023-05-30T20:00:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'kOj9dnUHj3', N'Challenge Fall22', 33, N'End-of-season challenge for those ranked silver or higher, where your extensive knowledge is demonstrated. Get the top position to win', 1, N'image/challenge/FALL22.png', 5, CAST(N'2022-12-28T19:30:00.000' AS DateTime))
INSERT [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [exam_type], [image], [status], [date]) VALUES (N'pErHAJVyTz', N'Challenge Fall23', 31, N'End-of-season challenge for those ranked silver or higher, where your extensive knowledge is demonstrated. Get the top position to win', 1, N'image/challenge/fall23.png', 5, CAST(N'2023-12-19T12:00:00.000' AS DateTime))
GO
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'k9fjeISuJ2', 1, 110, 2, CAST(N'2023-05-30T20:46:30.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'k9fjeISuJ2', 2, 80, 2, CAST(N'2023-05-30T20:40:31.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'k9fjeISuJ2', 3, 112, 2, CAST(N'2023-05-30T20:51:41.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'k9fjeISuJ2', 4, 110, 2, CAST(N'2023-05-30T20:51:00.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'kOj9dnUHj3', 1, 82, 2, CAST(N'2022-12-28T19:57:02.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'kOj9dnUHj3', 2, 102, 2, CAST(N'2022-12-28T20:21:00.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'kOj9dnUHj3', 3, 98, 2, CAST(N'2022-12-28T20:19:08.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'IJn9b1JHus', 1, 46, 2, CAST(N'2022-08-24T18:38:09.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'IJn9b1JHus', 2, 63, 2, CAST(N'2022-08-24T19:24:00.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'IJn9b1JHus', 3, 112, 2, CAST(N'2022-08-24T19:13:54.000' AS DateTime))
INSERT [dbo].[ExamUser] ([exam_id], [user_id], [score], [status], [time_submit]) VALUES (N'pErHAJVyTz', 1, 98, 2, CAST(N'2023-12-19T12:01:15.120' AS DateTime))
GO
INSERT [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (4, 1, 1)
INSERT [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (4, 2, 1)
INSERT [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (1, 4, 1)
INSERT [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (2, 4, 1)
INSERT [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (3, 4, 0)
GO
SET IDENTITY_INSERT [dbo].[HistoryUser] ON 

INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (2, 4, 1, 1, CAST(N'2023-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (3, 4, 2, NULL, CAST(N'2023-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (4, 4, 1, 2, CAST(N'2023-11-05T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (6, 4, 2, NULL, CAST(N'2023-11-06T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (7, 4, 1, 1, CAST(N'2023-11-06T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (8, 4, 1, 3, CAST(N'2023-11-07T06:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (9, 2, 1, 5, CAST(N'2023-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (10, 4, 2, NULL, CAST(N'2023-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (11, 4, 2, NULL, CAST(N'2023-11-08T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (12, 4, 1, 4, CAST(N'2023-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (13, 2, 1, 4, CAST(N'2023-11-12T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (14, 4, 1, 2, CAST(N'2023-11-12T17:56:23.250' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (15, 4, 1, 3, CAST(N'2023-11-13T00:00:00.000' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (16, 4, 2, NULL, CAST(N'2023-11-13T10:48:56.053' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (17, 4, 1, 3, CAST(N'2023-11-13T10:49:12.160' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (18, 4, 1, 3, CAST(N'2023-11-13T11:08:31.410' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (19, 4, 1, 1, CAST(N'2023-11-13T11:11:33.450' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (20, 4, 2, NULL, CAST(N'2023-11-13T11:53:59.053' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (21, 4, 2, NULL, CAST(N'2023-11-13T11:55:42.050' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (22, 4, 1, 2, CAST(N'2023-11-13T23:29:09.590' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (23, 4, 1, 3, CAST(N'2023-11-21T14:23:03.393' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (24, 1, 1, 3, CAST(N'2023-11-23T19:14:30.243' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (25, 4, 1, 3, CAST(N'2023-11-23T19:14:30.243' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (26, 1, 1, 3, CAST(N'2023-11-23T19:14:30.243' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (27, 1, 1, 3, CAST(N'2023-11-23T19:14:30.243' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (28, 1, 1, 3, CAST(N'2023-11-23T19:24:54.927' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (29, 4, 1, 3, CAST(N'2023-11-23T19:24:55.043' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (30, 4, 1, 3, CAST(N'2023-11-23T19:26:43.880' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (31, 4, 1, 3, CAST(N'2023-11-23T19:27:55.733' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (32, 2, 1, 3, CAST(N'2023-11-23T22:28:36.133' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (33, 1, 1, 3, CAST(N'2023-11-23T22:28:36.133' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (34, 4, 1, 3, CAST(N'2023-11-23T22:28:36.237' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (35, 2, 1, 3, CAST(N'2023-11-24T12:25:11.873' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (36, 4, 1, 3, CAST(N'2023-11-24T12:25:11.907' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (37, 4, 1, 3, CAST(N'2023-11-24T14:00:55.790' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (38, 4, 1, 3, CAST(N'2023-11-24T14:38:23.590' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (39, 1, 1, 3, CAST(N'2023-11-24T14:38:23.590' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (40, 1, 1, 3, CAST(N'2023-11-24T14:46:37.030' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (41, 4, 1, 3, CAST(N'2023-11-24T14:46:37.077' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (42, 1, 1, 3, CAST(N'2023-11-24T14:52:30.283' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (43, 4, 1, 3, CAST(N'2023-11-24T14:52:30.327' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (44, 1, 1, 3, CAST(N'2023-11-24T14:57:43.563' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (45, 4, 1, 3, CAST(N'2023-11-24T14:57:43.607' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (46, 1, 1, 3, CAST(N'2023-11-24T15:00:09.817' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (47, 4, 1, 3, CAST(N'2023-11-24T15:00:09.850' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (48, 4, 1, 3, CAST(N'2023-11-25T11:15:04.953' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (49, 4, 1, 4, CAST(N'2023-11-25T11:15:20.287' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (50, 4, 1, 3, CAST(N'2023-11-25T11:50:07.690' AS DateTime))
INSERT [dbo].[HistoryUser] ([history_id], [user_id], [action_type], [quiz_id], [date_action]) VALUES (51, 4, 1, 1, CAST(N'2023-12-04T15:03:56.373' AS DateTime))
SET IDENTITY_INSERT [dbo].[HistoryUser] OFF
GO
INSERT [dbo].[Notification] ([user_id], [content_notification], [value], [date_notification]) VALUES (4, N'User 3 send request add friend with you', N'/profile-orther/3', CAST(N'2023-11-30T16:34:20.000' AS DateTime))
INSERT [dbo].[Notification] ([user_id], [content_notification], [value], [date_notification]) VALUES (4, N'Your quiz is approved', N'edit-quiz/29', CAST(N'2023-12-09T11:52:16.577' AS DateTime))
INSERT [dbo].[Notification] ([user_id], [content_notification], [value], [date_notification]) VALUES (4, N'Your quiz is approved', N'edit-quiz/29', CAST(N'2023-12-09T12:00:06.153' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([payment_id], [user_id], [amount], [payment_date], [payment_method]) VALUES (1, 1, CAST(10.00 AS Decimal(10, 2)), CAST(N'2023-02-08T12:00:00.000' AS DateTime), N'Momo')
INSERT [dbo].[Payments] ([payment_id], [user_id], [amount], [payment_date], [payment_method]) VALUES (2, 2, CAST(10.00 AS Decimal(10, 2)), CAST(N'2023-03-12T12:30:00.000' AS DateTime), N'Momo')
INSERT [dbo].[Payments] ([payment_id], [user_id], [amount], [payment_date], [payment_method]) VALUES (3, 3, CAST(10.00 AS Decimal(10, 2)), CAST(N'2023-02-21T13:00:00.000' AS DateTime), N'Momo')
INSERT [dbo].[Payments] ([payment_id], [user_id], [amount], [payment_date], [payment_method]) VALUES (4, 1, CAST(10.00 AS Decimal(10, 2)), CAST(N'2023-12-08T12:00:00.000' AS DateTime), N'Momo')
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Questions] ON 

INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (1, N'what will happen when you attempt to compile and run the following
    program (please note that the Object class does not have the foo() method):', 1, 1, 2, N'1', 1, N'Object t = new A();|System.out.printf("C"); hen you attempt to compile and run the |what will happen when you attempt to compile and run the following progra)|happen when you attempt to compile and run the following')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (2, N'Which of the following statements related to the Generic Method is True?', 1, 1, 2, N'3', 1, N'Generic methods can not be defined within non-generic classes|None of the others|A method declared with the type parameters for its return type or parameters is called a generic method|Generic methods can only be used to static methods')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (3, N'Which of the following statements related to Generic Class is True?', 1, 1, 2, N'2', 1, N'None of the others|Generic classes encapsulate operations that are not specific to a particular data type|When creating generic classes, important considerations include: class type to generalize into type parameters|Generic classes are defined using a type parameter in parentheses after the class name')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (4, N'Which is keyword meaning access is limited to the current assembly or types derived from the defining class in the current assembly?', 1, 1, 2, N'2', 1, N'internal|protected internal|public|private')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (5, N'Which of the following is one of the Creational Design Patterns?', 1, 1, 2, N'2', 1, N'Decorator|Singleton|Adapter|All of the others')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (6, N'Which of the following keywords meaning access is limited in the same assembly but not outside the assembly?', 1, 1, 3, N'3', 1, N'private|protected internal|internal|public')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (7, N'Choose the correct statement related to the Namespaces in C#?', 2, 1, 3, N'3', 1, N'All of the others|It helps to control the scope of methods and variables in larger .Net programming projects|It is used to organize the classes|The members of a namespace can be interfaces, structures, and delegates but not namespaces')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (8, N'Which statement is incorrect about C# language?', 2, 1, 1, N'2', 1, N'There is no pointer required in C#|C# does support Automatic memory management through the delete keyword|C# fully supports interface-based programming techniques|C# fully supports aspect-oriented programming techniques')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (9, N'For the following statements related to Thread:
Statement 1. Foreground threads can prevent the current application from terminating. The Core CLR will not shut down an application until all foreground threads have ended.
Statement 2. Background threads are viewed by the Core CLR as expendable paths of execution that can be ignored at any point in time.
Choose the correct answer :', 2, 1, 1, N'3', 1, N'Statement 1 is True and 2 is False|Statement 1 and 2 are False|Statement 1 and 2 are True|Statement 1 is False and 2 is True')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (10, N'Which of the following is the Issue of Concurrency?', 1, 1, 1, N'1', 1, N'Blocking: Processes can block waiting for resources. A process could be blocked for a long period waiting for input from a terminal|Average response time: Without concurrency, each application has to be run to completion before the next one can be run|None of the others|Resource utilization: It enables that the resources that are unused by one application can be used for other applications')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (11, N'Choose the correct statement about .NET Framework.', 1, 1, 1, N'2', 1, N'It used to develop two application types: ASP.NET Web Forms and WinForms applications|It was developed to run on the Windows platform only|It is open source|None of the others')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (12, N'Which of the following statements related to the characteristics of the delegate type is True?
Statement 1: Invoke to methods that have the same signature.
Statement 2: Can be used as the parameters of any method.
Statement 3: Can be used to invoke methods via synchronous model by BeginInvoke() method.', 2, 1, 1, N'4', 1, N'Statement 1 and 3|Statement 1, 2 and 3|Statement 2 and 3|Statement 1 and 2')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (13, N'To read a line from the command line window (console window), which of the following statements should be used?', 1, 1, 1, N'4', 1, N'System.Read.ReadLine();|System.Console.WriteLine();|System.ReadLine();|System.Console.ReadLine();')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (14, N'Which of the following statements related to the ThreadPool is True?', 1, 1, 1, N'3', 1, N'Once thread pool threads finish executing their tasks, they will be killed|None of the others|A thread pool is a pool of worker threads that have already been created and are available for apps to use as needed|The thread pool manages threads efficiently by minimizing the number of threads that must be killed')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (15, N'Choose the correct statement related to the Design Pattern?', 1, 1, 1, N'4', 1, N'Increased software development costs, because problems arise, are not known|None of the others|Design patterns provide specific solutions, documented in a format that require specifics tied to a particular problem|Patterns allow developers to communicate using well-known, well-understood names for software interactions')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (16, N'Which of the following statement is one of the core components of the .NET Framework integral to any application or service development?', 2, 1, 4, N'3', 1, N'Microsoft Intermediate Language (MSIL)|Custom Assemblies|NET Framework Class Library (FCL)|None of the others')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (17, N'Choose the correct statement related to Lambda Expressions', 2, 1, 4, N'4', 1, N'The ''-&gt;'' is the lambda operator which is used in all lambda expressions|With Lambda expressions we need to specify the type of the value that we input thus making it more flexible to use|All of the others|Lambda expressions in C# are used like anonymous functions')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (18, N'What is the benefit of Generics?', 1, 1, 4, N'4', 1, N'Can be reusable with different types but can not accept values of a single type at a time|All of the others|Allow safely upgrading the code with casting or boxing|Ensure type-safety at compile-time (ensure strongly-typed programming model)')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (19, N'Which of the following keywords is used to extend or modify the abstract or virtual implementation of an inherited method, property, or event?', 1, 1, 4, N'2', 1, N'abstract|override|sealed|virtual')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (20, N'Which of the following statements related to Static Constructor is True?', 2, 1, 4, N'3', 1, N'The Static Constructor executes after any instance-level constructors|The Static Constructor executes exactly one time, regardless of how many objects of the type are created|The Static Constructors can be used to initialize the value for members in the level object.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (21, N'Which of the following statements related to Constraints on Type Parameters in Generic is True?', 1, 1, 4, N'4', 1, N'All of the others|Constraints are specified by using the new contextual keyword|Without any constraints, the type argument could be default is an integer type|Constraints inform the compiler about the capabilities a type argument must have')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (22, N'Choose the incorrect statement about the delegate.', 1, 1, 4, N'1', 1, N'A delegate cannot use with event|Delegates are of reference types|Delegates are used to invoke methods that have the same signatures|Delegates are type-safe')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (23, N'Choose the correct statement related to Concurrency in Operating System', 2, 1, 2, N'3', 1, N'The running process threads always communicate with each other through shared memory or message passing|Concurrency happens in the operating system when several process threads are running in parallelAll of the others|Concurrency is the execution of the multiple instruction sequences at the same time')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (24, N'U06-Q007 Which the following query operators can use to calculate the sum of the elements in the expression?', 3, 1, 2, N'2', 1, N'SumWhile|Sum|SumAll|All of the others')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (25, N'Which of the following entry points of the application does not the C# compiler accept?', 2, 1, 2, N'1', 1, N'public static void Main(int[] agrs)|public static int Main()|public static void Main(string[] Arguments)|public static int Main(string [] Arguments)')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (26, N'a programmer need to create a logging method that can accept an arbitrary number of argument. For example, it may be called in these ways:
loglt("log message 1");
loglt("log message 2","log message 3");
loglt("log message 4","log message 5","log message 6");
which declaration satisfies this requirement?
', 1, 2, 4, N'1', 1, N'public void loglt(String... msgs)|public void loglt(String[] msgs)|public void loglt(String * msgs)|public void loglt(String msgs1, String msgs2, String msgs3)')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (27, N'In order for objects in a List to be sorted, those objects must implement which interface method?', 1, 2, 2, N'2', 1, N'Comparable interface its compare method|Comparable interface its compareTo method|Comparable interface its equals method|ompare interface its compareTo method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (28, N'which of the following classes supports developers to get the pointer if a file?', 3, 2, 2, N'3', 1, N'java.io.FileStream|java.io.File|java.io.RandomAccessFile|java.io.FileInputStream')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (29, N'which of the following is the correct syntax for suggesting that the JVM performs garbage collection?', 3, 2, 3, N'3', 1, N'System.free();|System.setGarbageCollection();|System.gc();|System.out.gc();')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (30, N'when creating your own class and you want to make it directly support sorting, which interface must it implement?', 1, 2, 3, N'1', 1, N'Comparable|Sortator|Sortable|Comparator')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (31, N'Which of the following statements is true?', 1, 2, 3, N'4', 1, N'A final object''s data cannot be changed|A final class can be subclassed|A final method cannot be overloaded|A final object cannot ve reassigned a now address in memory')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (32, N'To write object to an object file. The right order of object creations is:
', 3, 2, 3, N'1', 1, N'FileOutputStream- ObjectOutputStream|FileReader - ObjectOutputStream|File - ObjectOutputStream - FileOutputStream|File - ObjectOutputStream - Writer')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (33, N'which of the following is true about Wrapped classes?', 1, 2, 3, N'3', 1, N'Wrapper classes are: Boolean, Char, Byte, Short, Integer, Long, Float, and Double|Wrapper classes are: Boolean, Character, Byte, Integer, Long, Float, and Double|Wrapper classes are classes that allow primitive types to be accessed as objects')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (34, N'Which of the following methods of the java.io.File can be used to create a new file?', 3, 2, 3, N'3', 1, N'newFile()|There is no such method. Just do File f = new File ("filename.txt"); then the newfile, named filename.txt will be created|createNewFile()|makeNewFile()')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (35, N'which of the following modifiers does not allow a variable to be modified its value once it was initialized?', 1, 2, 3, N'2', 1, N' transient|final|private|static')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (36, N'which of the following most closely dexcribes the process of overriding?', 1, 2, 3, N'4', 1, N'A method with the same name but different parameters gives multiple uses for the same method name|A class is prevented from accessing methods in its immadiate ancestor|A class with the same name replaces the functionality if a class defined earlier in the hierarchy|A method with the same name completely replaces the functionality of a method earlier in the hierarchy')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (37, N'which statement is true about the following method?
int seltXor(int i) {
return i ^ i;
}', 2, 2, 3, N'1', 1, N'it alway returns 0.| it alway returns 1.|it alway an int where every bit is 1|The returned value varies depending on the argument')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (38, N'Select correct statement', 1, 2, 3, N'1', 1, N'String objects are constants. StringBuffer objects are not|StringBuffer objects are constants. String objects are not|Both String and StringBuffer pbject are constants|Both String and StringBuffer pbject are not constants')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (39, N'An instance of the java.ulti.Scanner class can read date from the keyboard (1), a file (2), a string of characters (3)
1 is ..., 2 is ..., 3 is ...', 3, 2, 3, N'5', 1, N'None of the others|T F F|T F T|T T F|T T T')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (40, N'what is the output of the following code?

1: String str = "Welcome";
2: str.concat( to Java!");
3: System.out.println(str);', 2, 2, 1, N'2', 1, N'Prints "Welcome to Java!"|Prints "Welcome"|Runtime exception at line 2|Compilation error at line 2')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (41, N'what will happen it you try to compile and run the following code: 

public class MyClass{

static int i;

public static void main(String argv[]){

System.out.println(i); 

}

}', 1, 2, 1, N'4', 1, N'null|1|Error Variable i may not have been intialized|0')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (42, N'select the correct syntax for throwing an exception when declaring a method', 3, 2, 1, N'1', 1, N'[Modifier] {Return type] Identifier (Parameters) throws TypeOfException|[Modifier] {Return Type] Identifier (Parameters) {
throws TypeOfException;
}|[Modifier] {Return type] Identifier (Parameters){
throw TypeOfException;
}|[Modifier] {Return type] Identifier (Parameters) throw TypeOfException')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (43, N'how do you use the File class to list the contents of a directory?', 1, 2, 1, N'3', 1, N'StringBuider [] contents = newFile.list();|The File class does not provide a way to list the contents of a directory|String [] contents = myFile.list();|File [] contents = myFile.list();')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (44, N'is this code snippet incorrect?
Lict<String>myIntList = new LinkedList<String>();
myIntList.add(0);', 3, 2, 4, N'2', 1, N'false|true')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (45, N'all the method of the ___ class are static', 3, 2, 4, N'2', 1, N'String |Math|System|Runtime')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (46, N'Interfaces cannot extend ____ , but they can extend___', 3, 2, 2, N'2', 1, N'interfaces, classes|classes, interfaces|classes, objects')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (47, N'which of these class is used to read characters in a file?', 1, 2, 2, N'1', 1, N'FileReader|InputStreamReader|FileInputStream|FileWriter')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (48, N'which of the following may override a method whose signature is void xyz(float f)?', 1, 2, 3, N'2', 1, N'public int xyz(float f)|public void xyz(float f)|private int xyz(float f)|private void xyz(float f)')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (49, N'in which stream, data unit is primitive data type or string?', 2, 2, 1, N'1', 1, N'Binary high-level stream|Binary low-level stream|Character stream|Object stream')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (50, N'____ is the process of identifying and grouping attributes and actions related to a particular entity as relevant to the application at hand', 3, 2, 3, N'2', 1, N'Persistence|Construction|Polymorphism|Data abstraction')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (51, N'What is the RouterModule.forRoot method used for?', 1, 3, 1, N'2', 1, N'Registering any providers that you intend to use in routed components.|Registering route definitions at the root application level.|Indicating that Angular should cheer on your routes to be successful.|Declaring that you intend to use routing only at the root level.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (52, N'Which DOM elements will this component metadata selector match on?', 3, 3, 3, N'3', 1, N'Any element with the attribute app-user-card, such as <div app-user-card></div>.|The first instance of <app-user-card></app-user-card>.|All instances of <app-user-card></app-user-card>.| All instances of <user-card></user-card>')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (53, N'What is the difference between the paramMap and the queryParamMap on the ActivatedRoute class?', 3, 3, 4, N'4', 1, N'The paramMap is an object literal of the parameters in a route''s URL path. The queryParamMap is an Observable of those same parameters.|The paramMap is an Observable that contains the parameter values that are part of a route''s URL path. The queryParamMap is a method that takes in an array of keys and is used to find specific parameters in the paramMap.|paramMap is the legacy name from Angular 3. The new name is queryParamMap.|Both are Observables containing values from the requested route''s URL string. The paramMap contains the parameter values that are in the URL path and the queryParamMap contains the URL query parameters.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (54, N'What method is used to wire up a FormControl to a native DOM input element in reactive forms?', 2, 3, 2, N'3', 1, N'Add the string name given to the FormControl to an attribute named controls on the <form> element to indicate what fields it should include.|Use the square bracket binding syntax around the value attribute on the DOM element and set that equal to an instance of the FormControl.|Use the formControlName directive and set the value equal to the string name given to the FormControl.|Use the string name given to the FormControl as the value for the DOM element id attribute.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (55, N'What are the two-component decorator metadata properties used to set up CSS styles for a component?', 2, 3, 1, N'4', 1, N'viewEncapsulation and viewEncapsulationFiles.|There is only one and it is the property named css.| css and cssUrl.|styles and styleUrls.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (56, N' What is the purpose of the valueChanges method on a FormControl?', 1, 3, 3, N'4', 1, N' It is used to configure what values are allowed for the control.|It is used to change the value of a control to a new value. You would call that method and pass in the new value for the form field. It even supports passing in an array of values that can be set over time.|It returns a Boolean based on if the value of the control is different from the value with which it was initialized.|It is an observable that emits every time the value of the control changes, so you can react to new values and make logic decisions at that time.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (57, N'What directive is used to link an <a> tag to routing?', 3, 3, 2, N'2', 1, N'routeTo|routerLink|routePath|appLink')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (58, N'You want to see what files would be generated by creating a new contact-card component. Which command would you use?', 3, 3, 1, N'1', 1, N'ng generate component contact-card --dry-run|ng generate component contact-card --no-files|ng generate component component --dry|ng generate component --exclude')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (59, N'What are Angular lifecycle hooks?', 1, 3, 3, N'4', 1, N'loggers for tracking the health of an Angular app|providers that can be used to track the instances of components|built-in pipes that can be used in templates for DOM events|reserved named methods for components and directives that Angular will call during set times in its execution, and can be used to tap into those lifecycle moments')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (60, N'What is the value type that will be stored in the headerText template reference variable in this markup? <h1 #headerText>User List</h1>', 2, 3, 1, N'1', 1, N'an Angular ElementRef, a wrapper around a native element|the inner text of the <h1> element| a header component class|the native DOM element type of HTMLHeadingElement')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (61, N'When a service is provided for root and is also added to the provider''s configuration for a lazy-loaded module, what instance of that service does the injector provide to constructors in the lazy-loaded module?', 3, 3, 3, N'1', 1, N'A new instance of that service is created when the module is lazy loaded.|Providing a service of the same type at a lazy-loaded module level is not allowed.|If an instance of the service has not been created at the root level yet. it will create one there and then use it|A single instance of that service is always instantiated at the root and is the only one ever used, including within lazy modules.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (62, N'In reactive forms, what Angular form class type is used on the native DOM <form> element to wire it up?', 3, 3, 4, N'3', 1, N'FormArray|FormControl|FormGroup|all of these answers')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (63, N'How does the emulated view encapsulation mode handle CSS for a component?', 1, 3, 4, N'3', 1, N'It renders the CSS exactly how you wrote it without any changes.|It makes use of shadow DOM markup and CSS.|It creates unique attributes for DOM elements and scopes the CSS selectors you write to those attribute IDs.|It renders all of the CSS rules you write as inline CSS on all of the DOM elements you use in the template.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (64, N'When a service requires some setup to initialize its default state through a method, how can you make sure that said method is invoked before the service gets injected anywhere?', 3, 3, 1, N'2', 1, N'Put the logic of that service method into the service constructor instead.|Use a factory provider at the root AppModule level that depends on the service to call that service method.|It is not possible to do it at the application start; you can do it only at a component level.|Instantiate an instance of the service at the global level (window scope) and then call that method.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (65, N' What is the primary difference between a component and a directive?', 3, 3, 2, N'3', 1, N'A component uses a selector metadata property and a directive does not.|A directive can be used for adding custom events to the DOM and a component cannot.|A component has a template and a directive does not.|A directive can target only native DOM elements.')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (66, N'What does SQL stand for?', 1, 12, 2, N'1', 1, N'Structured Query Language|System Query Language|Structured Question Language|Simple Query Language')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (67, N'Which SQL command is used to retrieve data from a database?', 1, 12, 2, N'3', 1, N'GET|FETCH|SELECT|FIND')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (68, N'What is the primary key in a SQL table?', 3, 12, 1, N'3', 1, N'Any column with unique values|A column that is auto-incremented|A column that uniquely identifies each row|A column with the most data')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (69, N'Which SQL statement is used to update data in a database?', 3, 12, 2, N'1', 1, N'UPDATE|MODIFY|CHANGE|ALTER')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (70, N'Which SQL clause is used to filter the results of a SELECT query?', 1, 12, 3, N'1', 1, N'WHERE|FILTER|LIMIT|SORT')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (71, N'What SQL command is used to remove a table from a database?', 1, 12, 1, N'2', 1, N'DELETE|DROP|REMOVE|ERASE')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (72, N'Which SQL function is used to count the number of rows in a table?', 1, 12, 4, N'1', 1, N'COUNT()|SUM()|AVG()|TOTAL()')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (73, N'What does the SQL keyword "DISTINCT" do in a SELECT statement?', 3, 12, 3, N'2', 1, N'Sorts the result set in ascending order|Removes duplicate values from the result set|Groups the result set by a specific column|Combines multiple tables')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (74, N'Which SQL operator is used to combine two or more conditions in a WHERE clause?', 3, 12, 2, N'1', 1, N'AND|OR|NOT|XOR')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (75, N'What is the purpose of the SQL command "INSERT INTO"?', 3, 12, 1, N'3', 1, N'Update existing records|Delete records from a table|Insert new records into a table|Modify table structure')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (76, N'Which SQL statement is used to sort the result set in descending order?', 1, 12, 2, N'4', 1, N'ORDER BY DESC|SORT DESC|DESCENDING|DESC')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (77, N'What is the SQL function for finding the highest value in a column?', 1, 12, 3, N'1', 1, N'MAX()|TOP()|HIGHEST()|LARGEST()')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (78, N'Which SQL command is used to create a new database?', 1, 12, 4, N'2', 1, N'NEW DATABASE|CREATE DATABASE|ADD DATABASE|MAKE DATABASE')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (79, N'What is the purpose of the SQL GROUP BY clause?', 1, 12, 1, N'2', 1, N'Combine multiple tables into one result set|Group rows with the same values into summary rows|Filter rows based on specific conditions|Create a new table')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (80, N'Which SQL statement is used to add a new column to an existing table?', 3, 12, 2, N'1', 1, N'ALTER TABLE ADD COLUMN|INSERT COLUMN|ADD COLUMN|CREATE Column')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (81, N'What SQL command is used to delete all records from a table without deleting the table itself?', 1, 12, 2, N'3', 1, N'DELETE|REMOVE|TRUNCATE|PURGE')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (82, N'Which SQL operator is used to compare if a value is equal to another value?', 1, 12, 2, N'1', 1, N'= (equal)|<> (not equal)|> (greater than)|< (less than)')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (83, N'What SQL function is used to find the average value of a numeric column?', 3, 12, 3, N'1', 1, N'AVG()|MEAN()|AVERAGE()|MEDIAN()')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (84, N'Which SQL statement is used to join two or more tables based on a related column?', 1, 12, 1, N'2', 1, N'MERGE|JOIN|COMBINE|CONNECT')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (85, N'What is the purpose of the SQL HAVING clause?', 1, 12, 4, N'2', 1, N'Filter rows before they are grouped|Filter rows after they are grouped|Sort rows in the result set|Aggregate rows')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (86, N'What is a C++ header file used for?', 3, 5, 4, N'3', 1, N'To include pre-written code|To declare global variables|To include function prototypes|To define class methods')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (87, N'Which of the following is not a C++ data type?', 2, 5, 4, N'4', 1, N'int|char|boolean|real')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (88, N'What is the C++ operator for the modulus (remainder) operation?', 2, 5, 1, N'2', 1, N'%|&|/|*')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (89, N'What is the purpose of the "cin" object in C++?', 2, 5, 1, N'1', 1, N'To input data from the console|To display output on the console|To perform mathematical calculations|To define user-defined functions')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (90, N'In C++, what is the keyword used to allocate memory for a variable?', 3, 5, 1, N'4', 1, N'malloc|alloc|new|memory')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (91, N'What does the C++ "const" keyword indicate?', 2, 5, 1, N'3', 1, N'A constant variable that cannot be modified|A variable that can be changed at any time|A variable that is used for mathematical operations|A variable that is not initialized')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (92, N'Which C++ loop is used to iterate a specific number of times?', 2, 5, 1, N'1', 1, N'for|while|do-while|if')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (93, N'What is the purpose of the "break" statement in C++?', 3, 5, 1, N'2', 1, N'To exit a loop prematurely|To skip the next iteration of a loop|To terminate the program|To display output')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (94, N'In C++, how can you define a function outside of the class?', 2, 5, 2, N'4', 1, N'Using the "extern" keyword|Using the "global" keyword|Using the "private" keyword|Using the scope resolution operator')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (95, N'What is the default access specifier for members of a C++ class?', 2, 5, 3, N'3', 1, N'public|private|protected|global')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (96, N'What is the difference between "malloc" and "new" in C++?', 2, 5, 3, N'1', 1, N'"malloc" is a C function, and "new" is a C++ operator|"new" is a C function, and "malloc" is a C++ operator|"malloc" is used for dynamic memory allocation, and "new" is used for static memory allocation|"new" is used for dynamic memory allocation, and "malloc" is used for object creation')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (97, N'What is the purpose of the "this" pointer in C++?', 3, 5, 3, N'2', 1, N'To refer to the current object in a class|To store the memory address of a variable|To reference a null value|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (98, N'In C++, what is operator overloading?', 2, 5, 3, N'4', 1, N'Creating custom operators in C++|Using the same operator for different data types|Changing the precedence of operators|Combining multiple operators into one')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (99, N'What is a C++ template?', 2, 5, 1, N'1', 1, N'A way to create generic functions or classes|A pre-compiled header file|A special type of class in C++|A header file used for including graphics')
GO
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (100, N'What is the purpose of the "try", "catch", and "throw" keywords in C++?', 2, 5, 3, N'3', 1, N'To perform file I/O operations|To create new classes and objects|To handle exceptions in the code|To define user-defined functions')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (101, N'In C++, what is the "nullptr" keyword used for?', 3, 5, 4, N'1', 1, N'To represent a null pointer|To declare a variable|To create a new object|To define a new function')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (102, N'What is the C++ Standard Template Library (STL)?', 2, 5, 2, N'4', 1, N'A collection of templates used for code generation|A template for creating standard C++ libraries|A set of guidelines for C++ coding|A library of data structures and algorithms')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (103, N'What is the C++ "namespace" used for?', 2, 5, 1, N'2', 1, N'To define a new class|To declare a global variable|To avoid naming conflicts|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (104, N'What is a C++ constructor?', 2, 5, 2, N'3', 1, N'A variable used for mathematical calculations|A function that is called when an object is created|A reserved keyword in C++|A template for creating new objects')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (105, N'What is the C++ keyword used to create a new instance of a class?', 2, 5, 3, N'2', 1, N'new|instance|create|initialize')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (116, N'test day ne', 3, 0, 4, N'2', 1, N'f|a|C|D')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (117, N'dddfv có gì', 1, 0, 1, N'2', 1, N'THIS|TEST|B|NE')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (118, N'? dây u ', 1, 0, 2, N'5', 1, N'F|D|F|D|dg h?i')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (119, N'test ndddg', 1, 0, 3, N'2', 1, N'f|a|C|D')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (120, N'hihi', 3, 0, 4, N'2', 1, N'THIS|TEST|B|NE')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (121, N'haha', 1, 0, 2, N'2', 1, N'F|D|F|D')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (122, N'fbbb', 2, 0, 2, N'4', 1, N'g|h|b|s')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (126, N'hrf', 1, 0, 2, N'2', 1, N'g|h|hi|kk|ko')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (127, N'hêt bn', 2, 0, 2, N'4', 1, N'dap an A|DAP AN B|DAP AN C|DAP AN D|DAP AN E')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (128, N'KO TEST NUA', 1, 0, 2, N'2', 1, N'FA|MAI|mai|lun')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (129, N'xin 2', 3, 0, 2, N'3', 1, N'fok|lol|gan|gun')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (130, N'jog', 1, 0, 3, N'3', 1, N'hyu|naruto|conan|luffy')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (131, N'What is Python?', 1, 6, 2, N'1', 1, N'A high-level programming language|A low-level programming language|A database management system|A markup language')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (132, N'Which keyword is used to define a function in Python?', 1, 6, 2, N'3', 1, N'def|function|define|method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (133, N'What is the purpose of the "self" parameter in Python?', 3, 6, 3, N'2', 1, N'To refer to the current instance of the class|To define a new variable|To perform mathematical operations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (134, N'What is JavaScript?', 1, 11, 1, N'1', 1, N'A scripting language that runs in the browser|A compiled programming language|A database management system|An operating system')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (135, N'Which keyword is used to declare a variable in JavaScript?', 1, 11, 2, N'4', 1, N'var|let|const|declare')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (136, N'What is the purpose of the "document.getElementById()" function in JavaScript?', 3, 11, 2, N'1', 1, N'To retrieve an HTML element from the document|To declare a new function|To perform mathematical calculations|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (137, N'What is Java?', 1, 2, 2, N'2', 1, N'A high-level programming language|A low-level programming language|A markup language|An operating system')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (138, N'Which keyword is used to define a class in Java?', 1, 2, 2, N'1', 1, N'class|define|struct|interface')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (139, N'What is the purpose of the "public" access modifier in Java?', 3, 2, 2, N'3', 1, N'To make a class, method, or field accessible from any other class|To hide the implementation details of a class|To restrict access to the same package|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (140, N'What is Ruby?', 1, 15, 2, N'1', 1, N'A dynamic, object-oriented programming language|A markup language|A low-level programming language|A database management system')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (141, N'Which keyword is used to define a method in Ruby?', 1, 15, 2, N'2', 1, N'def|function|method|define')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (142, N'What is the purpose of the "gem" in Ruby?', 2, 15, 2, N'3', 1, N'A package manager for Ruby libraries and programs|A built-in Ruby method|A module in Ruby|A type of loop in Ruby')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (143, N'What is C#?', 1, 4, 3, N'1', 1, N'A programming language developed by Microsoft|A database management system|A scripting language|A markup language')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (144, N'Which keyword is used to declare a variable in C#?', 2, 4, 1, N'2', 1, N'var|int|string|declare')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (145, N'What is the purpose of the "using" statement in C#?', 3, 4, 1, N'3', 1, N'To include a namespace in the program|To define a new variable|To perform file I/O operations|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (146, N'What is the purpose of the "lambda" function in Python?', 2, 6, 1, N'1', 1, N'To create anonymous functions|To declare global variables|To include pre-written code|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (147, N'How is exception handling done in Python?', 2, 6, 1, N'3', 1, N'Using try, except, and finally blocks|Using if-else statements|Using switch-case statements|Using assert statements')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (148, N'What is the purpose of the "with" statement in Python?', 2, 6, 1, N'2', 1, N'To simplify resource management using context managers|To declare a new variable|To perform database operations|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (149, N'What is a closure in JavaScript?', 2, 2, 4, N'1', 1, N'A function defined inside another function|An object with private variables|A conditional statement|A type of loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (150, N'What is the purpose of the "bind" method in JavaScript?', 3, 11, 1, N'3', 1, N'To set the value of "this" for a function permanently|To concatenate two strings|To perform mathematical calculations|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (151, N'What is event delegation in JavaScript?', 2, 11, 4, N'2', 1, N'Handling events using a single event listener on a common ancestor|Creating new events programmatically|Defining events in a separate file|Attaching multiple event listeners to a single element')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (152, N'What is the purpose of the "super" keyword in Java?', 2, 2, 4, N'1', 1, N'To refer to the parent class|To exit a loop|To define a new method|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (153, N'What is method overloading in Java?', 2, 2, 4, N'2', 1, N'Creating multiple methods with the same name but different parameters|Creating a method with the same name and parameters|Creating a new class with the same name as an existing class|Changing the return type of a method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (154, N'What is the purpose of the "interface" in Java?', 2, 2, 1, N'3', 1, N'To define a contract for classes that implement it|To create a new class|To restrict access to class members|To declare a variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (155, N'What is the purpose of the "yield" keyword in Ruby?', 3, 15, 1, N'1', 1, N'To pause execution and transfer control to the calling method|To declare a new variable|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (156, N'What is metaprogramming in Ruby?', 2, 15, 1, N'3', 1, N'Writing code that writes code|Creating multiple threads in Ruby|Handling errors in Ruby|Connecting to a database in Ruby')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (157, N'What is the purpose of the "require" statement in Ruby?', 2, 15, 2, N'2', 1, N'To include external libraries or files|To define a new method|To perform file I/O operations|To declare a variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (158, N'What is LINQ in C#?', 2, 4, 3, N'1', 1, N'Language Integrated Query - a feature that adds query capabilities to C#|A new programming language|A data type in C#|A type of loop in C#')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (159, N'What is the purpose of the "async" and "await" keywords in C#?', 2, 4, 1, N'3', 1, N'To perform asynchronous programming|To declare a new method|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (160, N'What is the difference between "const" and "readonly" in C#?', 3, 4, 3, N'2', 1, N'"const" is evaluated at compile time, and "readonly" at runtime|"readonly" can be assigned a value in runtime, but "const" cannot|"const" can be used for both variables and methods, while "readonly" is only for variables|"readonly" is a reserved keyword in C#')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (161, N'What is the purpose of the "enumerate" function in Python?', 2, 15, 2, N'1', 1, N'To iterate over both the index and the value of an iterable|To create a new variable|To perform file I/O operations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (162, N'How are list comprehensions used in Python?', 2, 6, 1, N'2', 1, N'To create concise and readable lists using a single line of code|To filter elements from a list using a loop|To sort elements in a list alphabetically|To declare a new variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (163, N'What is the purpose of the "map" function in Python?', 1, 6, 4, N'3', 1, N'To apply a function to all items in an input list|To create a new list|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (164, N'What is the purpose of the "Promise" object in JavaScript?', 2, 11, 1, N'1', 1, N'To represent the eventual completion or failure of an asynchronous operation|To declare a new variable|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (165, N'What is the purpose of the "JSON.stringify()" method in JavaScript?', 3, 11, 2, N'2', 1, N'To convert a JavaScript object to a JSON string|To parse a JSON string|To create a new object|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (166, N'How is prototypal inheritance implemented in JavaScript?', 1, 11, 3, N'3', 1, N'By linking objects through prototypes|By using classes and subclasses|By creating new instances of existing objects|By importing external libraries')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (167, N'What is the purpose of the "this" keyword in Java?', 2, 2, 4, N'1', 1, N'To refer to the current instance of the class|To exit a loop|To create a new object|To define a new method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (168, N'What is the difference between "==" and ".equals()" in Java?', 2, 2, 3, N'2', 1, N'"==" compares object references, and ".equals()" compares object contents|"==" compares primitive types, and ".equals()" compares object references|"==" is used for arithmetic operations, and ".equals()" for string comparison|"==" is a reserved keyword, and ".equals()" is a method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (169, N'How is multiple inheritance achieved in Java?', 1, 2, 3, N'3', 1, N'By using interfaces|By using abstract classes|By importing external libraries|By creating new instances of existing objects')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (170, N'What is the purpose of the "module" in Ruby?', 3, 15, 3, N'1', 1, N'To organize code into reusable and maintainable units|To declare a new method|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (171, N'What is the Ruby Gemfile used for?', 2, 15, 2, N'2', 1, N'To manage project dependencies|To declare a new variable|To create a new object|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (172, N'What is the purpose of the "include" statement in Ruby?', 1, 15, 1, N'3', 1, N'To mix in the methods of a module into a class|To import external libraries|To create a new object|To define a new variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (173, N'What is the purpose of the "using" directive in C#?', 2, 4, 3, N'1', 1, N'To include namespaces in the code|To declare a new variable|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (174, N'What is the purpose of the "Nullable" type in C#?', 2, 4, 4, N'2', 1, N'To represent an object that can be assigned a null value|To create a new variable|To perform mathematical calculations|To define a new method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (175, N'How are events and delegates related in C#?', 3, 4, 4, N'3', 1, N'Delegates are used to implement events|Events and delegates are unrelated concepts|Events are a type of delegate|Delegates are only used for asynchronous programming')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (176, N'What is the purpose of the "enumerate" function in Python?', 2, 6, 1, N'1', 1, N'To iterate over both the index and the value of an iterable|To create a new variable|To perform file I/O operations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (177, N'How are list comprehensions used in Python?', 2, 6, 2, N'2', 1, N'To create concise and readable lists using a single line of code|To filter elements from a list using a loop|To sort elements in a list alphabetically|To declare a new variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (178, N'What is the purpose of the "map" function in Python?', 1, 6, 3, N'3', 1, N'To apply a function to all items in an input list|To create a new list|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (179, N'What is the purpose of the "lambda" function in Python?', 1, 6, 3, N'1', 1, N'To create anonymous functions|To declare global variables|To include pre-written code|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (180, N'How is exception handling done in Python?', 2, 6, 2, N'3', 1, N'Using try, except, and finally blocks|Using if-else statements|Using switch-case statements|Using assert statements')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (181, N'What is the purpose of the "Promise" object in JavaScript?', 3, 11, 1, N'1', 1, N'To represent the eventual completion or failure of an asynchronous operation|To declare a new variable|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (182, N'What is the purpose of the "JSON.stringify()" method in JavaScript?', 2, 11, 1, N'2', 1, N'To convert a JavaScript object to a JSON string|To parse a JSON string|To create a new object|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (183, N'How is prototypal inheritance implemented in JavaScript?', 1, 11, 1, N'3', 1, N'By linking objects through prototypes|By using classes and subclasses|By creating new instances of existing objects|By importing external libraries')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (184, N'What is a closure in JavaScript?', 2, 11, 1, N'1', 1, N'A function defined inside another function|An object with private variables|A conditional statement|A type of loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (185, N'What is the purpose of the "bind" method in JavaScript?', 2, 11, 1, N'3', 1, N'To set the value of "this" for a function permanently|To concatenate two strings|To perform mathematical calculations|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (186, N'What is the purpose of the "this" keyword in Java?', 2, 2, 1, N'1', 1, N'To refer to the current instance of the class|To exit a loop|To create a new object|To define a new method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (187, N'What is the difference between "==" and ".equals()" in Java?', 3, 2, 1, N'2', 1, N'"==" compares object references, and ".equals()" compares object contents|"==" compares primitive types, and ".equals()" compares object references|"==" is used for arithmetic operations, and ".equals()" for string comparison|"==" is a reserved keyword, and ".equals()" is a method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (188, N'How is multiple inheritance achieved in Java?', 1, 2, 1, N'3', 1, N'By using interfaces|By using abstract classes|By importing external libraries|By creating new instances of existing objects')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (189, N'What is the purpose of the "super" keyword in Java?', 2, 2, 1, N'1', 1, N'To refer to the parent class|To exit a loop|To define a new method|To create a new object')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (190, N'What is method overloading in Java?', 2, 2, 1, N'2', 1, N'Creating multiple methods with the same name but different parameters|Creating a method with the same name and parameters|Creating a new class with the same name as an existing class|Changing the return type of a method')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (191, N'What is the purpose of the "module" in Ruby?', 2, 15, 1, N'1', 1, N'To organize code into reusable and maintainable units|To declare a new method|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (192, N'What is the Ruby Gemfile used for?', 2, 15, 1, N'2', 1, N'To manage project dependencies|To declare a new variable|To create a new object|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (193, N'What is the purpose of the "include" statement in Ruby?', 3, 15, 2, N'3', 1, N'To mix in the methods of a module into a class|To import external libraries|To create a new object|To define a new variable')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (194, N'What is the purpose of the "yield" keyword in Ruby?', 2, 15, 3, N'1', 1, N'To pause execution and transfer control to the calling method|To declare a new variable|To perform mathematical calculations|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (195, N'What is metaprogramming in Ruby?', 2, 15, 4, N'3', 1, N'Writing code that writes code|Creating multiple threads in Ruby|Handling errors in Ruby|Connecting to a database in Ruby')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (196, N'What is LINQ in C#?', 2, 4, 1, N'1', 1, N'Language Integrated Query - a feature that adds query capabilities to C#|A new programming language|A data type in C#|A type of loop in C#')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (197, N'What is the purpose of the "async" and "await" keywords in C#?', 2, 4, 2, N'3', 1, N'To perform asynchronous programming|To declare a new method|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (198, N'What is the difference between "const" and "readonly" in C#?', 1, 4, 3, N'2', 1, N'"const" is evaluated at compile time, and "readonly" at runtime|"readonly" can be assigned a value in runtime, but "const" cannot|"const" can be used for both variables and methods, while "readonly" is only for variables|"readonly" is a reserved keyword in C#')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (199, N'What is the purpose of the "using" directive in C#?', 3, 4, 4, N'1', 1, N'To include namespaces in the code|To declare a new variable|To create a new object|To exit a loop')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (200, N'What is LINQ in C# used for?', 1, 4, 1, N'3', 1, N'To query and manipulate data from different data sources|To create a new object|To declare a new method|To perform file I/O operations')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (201, N'cau hoi 1', 1, NULL, 2, N'3', 1, N'A|B|C|D')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (202, N'CAU HOI 2', 1, NULL, 3, N'5', 1, N'f|C|D|C|b')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (203, N'cau hoi 3', 1, NULL, 4, N'3', 1, N'dap an A|c|test| a')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (209, N'add new ques 2', 2, 1, 4, N'2', 2, N'test|A|b|csd')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (210, N'test question .net6 fix', 1, 1, 4, N'3', 1, N'overlay|cort|pay|ment')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (211, N'cau hoi 1 .net 6 fix', 2, 1, 4, N'2', 2, N'dap an A|b|c|d')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (212, N'cau hoi 2 .net6', 2, 1, 4, N'3', 1, N'hard|next|tip|to')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (213, N'When did Vietnam gain independence from France?', 1, NULL, NULL, N'2', NULL, N'1954|1975|1986|2001')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (214, N'Who was the leader of the Viet Minh during the First Indochina War?', 1, NULL, NULL, N'1', NULL, N'Ho Chi Minh|Vo Nguyen Giap|Ngo Dinh Diem')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (215, N'What was the name of the historical Vietnamese kingdom that existed from 111 BC to 938 AD?', 1, NULL, NULL, N'3', NULL, N'Van Lang|Champa|Au Lac')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (216, N'Which Vietnamese emperor founded the Nguyen Dynasty and moved the capital to Hue?', 1, NULL, NULL, N'1', NULL, N'Gia Long|Le Loi|Tu Duc')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (217, N'What is the smallest unit of matter?', 1, NULL, NULL, N'1', NULL, N'Atom|Cell|Proton|Kali')
GO
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (218, N'Which planet is known as the Red Planet?', 1, NULL, NULL, N'3', NULL, N'Venus|Mars|Jupiter')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (219, N'What does DNA stand for?', 1, NULL, NULL, N'2', NULL, N'Deoxyribonucleic Acid|Dihydrogen Monoxide|Digital Network Access')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (220, N'What is the process by which plants convert sunlight into energy called?', 1, NULL, NULL, N'1', NULL, N'Photosynthesis|Respiration|Fertilization')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (221, N'Who discovered the theory of relativity?', 1, NULL, NULL, N'3', NULL, N'Marie Curie|Albert Einstein|Isaac Newton')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (234, N'When did the Vietnam War against the US start?', 1, NULL, NULL, N'3', NULL, N'1955|1959|1965')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (235, N'What was the primary reason for Vietnam to fight against the US?', 1, NULL, NULL, N'2', NULL, N'Independence|Territorial expansion|Political turmoil')
INSERT [dbo].[Questions] ([question_id], [question_text], [difficulty_level], [category_id], [user_id], [correct_answer], [status], [options]) VALUES (236, N'Which event marked the turning point in the Vietnam War?', 1, NULL, NULL, N'1', NULL, N'Tet Offensive|Gulf of Tonkin incident|Ho Chi Minh Trail')
SET IDENTITY_INSERT [dbo].[Questions] OFF
GO
SET IDENTITY_INSERT [dbo].[QuestionsAttempts] ON 

INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (1, 1, 1)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (2, 1, 2)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (3, 1, 3)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (4, 1, 4)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (5, 1, 5)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (6, 1, 6)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (7, 1, 7)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (8, 1, 8)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (9, 1, 9)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (10, 1, 10)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (11, 1, 11)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (12, 1, 12)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (13, 1, 13)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (14, 1, 14)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (15, 1, 15)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (16, 1, 16)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (17, 1, 17)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (18, 1, 18)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (19, 1, 19)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (20, 1, 20)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (21, 1, 21)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (22, 1, 22)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (23, 1, 23)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (24, 1, 24)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (25, 1, 25)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (26, 2, 26)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (27, 2, 27)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (28, 2, 28)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (29, 2, 29)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (30, 2, 30)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (32, 2, 31)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (33, 2, 32)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (34, 2, 33)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (35, 2, 34)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (36, 2, 35)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (37, 2, 36)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (38, 2, 37)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (39, 2, 38)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (40, 2, 39)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (41, 2, 40)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (42, 2, 41)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (43, 2, 42)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (44, 2, 43)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (45, 2, 44)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (46, 2, 45)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (47, 2, 46)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (48, 2, 47)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (49, 2, 48)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (50, 2, 49)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (51, 2, 50)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (52, 3, 51)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (53, 3, 52)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (54, 3, 53)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (55, 3, 54)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (56, 3, 55)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (57, 3, 56)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (58, 3, 57)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (59, 3, 58)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (60, 3, 59)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (61, 3, 60)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (62, 3, 61)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (63, 3, 62)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (64, 3, 63)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (65, 3, 64)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (66, 3, 65)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (67, 4, 66)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (68, 4, 67)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (69, 4, 68)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (70, 4, 69)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (71, 4, 70)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (72, 4, 71)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (73, 4, 72)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (74, 4, 73)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (75, 4, 74)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (76, 4, 75)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (77, 4, 76)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (78, 4, 77)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (79, 4, 78)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (80, 4, 79)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (81, 4, 80)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (82, 4, 81)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (83, 4, 82)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (84, 4, 83)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (85, 4, 84)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (86, 4, 85)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (88, 5, 86)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (89, 5, 87)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (90, 5, 88)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (91, 5, 89)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (92, 5, 90)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (93, 5, 91)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (94, 5, 92)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (95, 5, 93)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (96, 5, 94)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (97, 5, 95)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (98, 5, 96)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (99, 5, 97)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (100, 5, 98)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (101, 5, 99)
GO
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (102, 5, 100)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (103, 5, 101)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (104, 5, 105)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (116, 28, 116)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (117, 28, 117)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (118, 28, 118)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (119, 29, 119)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (120, 29, 120)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (121, 29, 121)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (122, 29, 122)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (126, 29, 126)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (127, 30, 127)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (128, 30, 128)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (129, 30, 129)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (130, 30, 130)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (131, 31, 131)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (132, 31, 132)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (135, 31, 133)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (136, 31, 134)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (137, 31, 135)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (138, 31, 136)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (139, 31, 137)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (140, 31, 138)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (141, 31, 139)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (142, 31, 140)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (143, 31, 141)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (144, 31, 142)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (145, 31, 143)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (146, 31, 144)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (147, 31, 145)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (149, 32, 146)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (150, 32, 147)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (151, 32, 148)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (152, 32, 149)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (153, 32, 150)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (154, 32, 151)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (155, 32, 152)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (156, 32, 153)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (157, 32, 154)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (158, 32, 155)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (159, 32, 156)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (160, 32, 157)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (161, 32, 158)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (162, 32, 159)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (163, 32, 160)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (165, 33, 161)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (166, 33, 162)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (167, 33, 163)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (168, 33, 164)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (169, 33, 165)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (170, 33, 166)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (171, 33, 167)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (172, 33, 168)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (173, 33, 169)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (174, 33, 170)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (175, 33, 171)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (176, 33, 172)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (179, 33, 173)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (180, 33, 174)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (181, 33, 175)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (182, 34, 176)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (183, 34, 177)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (184, 34, 178)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (185, 34, 179)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (186, 34, 180)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (187, 34, 181)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (188, 34, 182)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (189, 34, 183)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (190, 34, 184)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (191, 34, 185)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (192, 34, 186)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (193, 34, 187)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (194, 34, 188)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (195, 34, 189)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (196, 34, 190)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (197, 34, 191)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (198, 34, 192)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (199, 34, 193)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (200, 34, 194)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (201, 34, 195)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (202, 34, 196)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (203, 34, 197)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (204, 34, 198)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (205, 34, 199)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (206, 34, 200)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (207, 35, 201)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (208, 35, 202)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (209, 35, 203)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (231, 47, 15)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (232, 47, 17)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (233, 47, 3)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (234, 47, 4)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (236, 48, 3)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (237, 48, 2)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (238, 49, 213)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (239, 49, 214)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (240, 49, 215)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (241, 49, 216)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (242, 50, 217)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (243, 50, 218)
GO
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (244, 50, 219)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (245, 50, 220)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (246, 50, 221)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (250, 49, 234)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (251, 49, 235)
INSERT [dbo].[QuestionsAttempts] ([attempt_id], [quiz_id], [question_id]) VALUES (252, 49, 236)
SET IDENTITY_INSERT [dbo].[QuestionsAttempts] OFF
GO
SET IDENTITY_INSERT [dbo].[Quizzes] ON 

INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (1, N'.NET 6 Knowledge', 1, N'This quiz tests the advanced knowledge and skills of .NET developers who are up-to-date with the latest features introduced in .NET 6. Most of the questions include pieces of code that evaluate your understanding of .NET and ASP.NET up to version 6.
Topics: Middleware, Razor, Dependency injection, Web API, FileStream, System.Text.Json, Throw helpers, LINQ, Ranges, Compile time source generation, Tasks.', 1, 1, N'image/quiz-practice/1.png', 2, NULL, 0, 1, CAST(N'2023-10-08T14:00:00.000' AS DateTime), CAST(N'2023-10-08T14:30:00.000' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (2, N' Object-Oriented Programming in Java ', 2, N'Object-oriented programming (OOP) is a fundamental programming paradigm based on the concept of “objects”. These objects can contain data in the form of fields (often known as attributes or properties) and code in the form of procedures (often known as methods).

The core concept of the object-oriented approach is to break complex problems into smaller objects.', 1, 1, N'image/quiz-practice/2.png', 2, NULL, 0, 2, CAST(N'2023-10-08T15:00:00.000' AS DateTime), CAST(N'2023-10-08T15:30:00.000' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (3, N'Angular Basic for Beginer', 3, N'Angular is a TypeScript-based, free and open-source single-page web application framework led by the Angular Team at Google and by a community of individuals and corporations. Angular is a complete rewrite from the same team that built AngularJS.', 1, 1, N'image/quiz-practice/3.png', 2, NULL, 0, 1, CAST(N'2023-10-08T16:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (4, N'SQL Basic for Beginer', 12, N'Data is just information. Data for a particular entity or user can be stored in a container called a relational database. data.world doesn’t use databases. Instead, we use datasets. A dataset is a snapshot of all the information in a database at a given moment in time.

', 1, 1, N'image/quiz-practice/4.png', 1, NULL, 0, 1, CAST(N'2023-10-09T00:12:53.597' AS DateTime), CAST(N'2023-10-09T00:12:53.610' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (5, N'Dev basic with C++', 5, N'C++ is a cross-platform language that can be used to create high-performance applications. C++ was developed by Bjarne Stroustrup, as an extension to the C language. C++ gives programmers a high level of control over system resources and memory.', 2, 1, N'image/quiz-practice/5.png', 1, NULL, 60, 1, CAST(N'2023-10-09T01:16:08.513' AS DateTime), CAST(N'2023-10-09T01:16:08.523' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (6, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:16:59.087' AS DateTime), CAST(N'2023-10-09T01:16:59.100' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (7, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:21:33.657' AS DateTime), CAST(N'2023-10-09T01:21:33.670' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (12, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:26:17.323' AS DateTime), CAST(N'2023-10-09T01:26:17.323' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (13, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:29:59.633' AS DateTime), CAST(N'2023-10-09T01:29:59.633' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (14, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:31:48.723' AS DateTime), CAST(N'2023-10-09T01:31:48.723' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (15, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:33:37.230' AS DateTime), CAST(N'2023-10-09T01:33:37.230' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (16, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T01:36:27.140' AS DateTime), CAST(N'2023-10-09T01:36:27.140' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (20, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T02:27:48.240' AS DateTime), CAST(N'2023-10-09T02:27:48.240' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (22, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T02:31:09.473' AS DateTime), CAST(N'2023-10-09T02:31:09.473' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (23, N'string', 1, N'string', 0, 0, NULL, 0, NULL, 30, 1, CAST(N'2023-10-09T02:33:05.060' AS DateTime), CAST(N'2023-10-09T02:33:05.060' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (28, N'here we go 2 ne lai', 0, N'Angular is a TypeScript-based, free and open-source single-page web application framework led by the Angular Team at Google and by a community of individuals and corporations. Angular is a complete rewrite from the same team that built AngularJS.', 2, 1, N'image/quiz-practice/d073c20c-53e1-418b-87be-114ee48c9c31.jpg', 1, NULL, 50, 4, CAST(N'2023-11-25T02:05:59.477' AS DateTime), CAST(N'2023-11-30T15:27:13.623' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (29, N'test lai nè hi', 2, N'Data is just information. Data for a particular entity or user can be stored in a container called a relational database. data.world doesn’t use databases. Instead, we use datasets. A dataset is a snapshot of all the information in a database at a given moment in time.
', 1, 4, N'image/quiz-practice/3065a5df-ccec-4df3-9c3d-34bdccf522ea.png', 2, N'test tinh nang reject', 0, 4, CAST(N'2023-11-25T18:40:07.643' AS DateTime), CAST(N'2023-12-09T13:02:28.380' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (30, N'tét típ dây ne 2', 0, N'C++ is a cross-platform language that can be used to create high-performance applications. C++ was developed by Bjarne Stroustrup, as an extension to the C language. C++ gives programmers a high level of control over system resources and memory.', 2, -1, N'image/quiz-practice/4938ce2c-cf10-4de8-aa38-4a3bae06a5f9.jpg', 2, NULL, 56, 4, CAST(N'2023-11-26T13:23:27.680' AS DateTime), CAST(N'2023-11-30T15:38:59.313' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (31, N'Challenge Fall23', 0, N'quiz for challenge', 2, 1, NULL, 2, NULL, 60, 4, CAST(N'2023-11-26T13:23:27.680' AS DateTime), CAST(N'2023-11-26T13:23:27.680' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (32, N'Challenge Spring23', NULL, N'quiz for challenge', 2, 1, NULL, 2, NULL, 60, 4, CAST(N'2023-11-26T13:23:27.680' AS DateTime), CAST(N'2023-11-26T13:23:27.680' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (33, N'Challenge Fall22', NULL, N'quiz for challenge', 2, 1, NULL, 2, NULL, 60, 4, CAST(N'2023-11-26T13:23:27.680' AS DateTime), CAST(N'2023-11-26T13:23:27.680' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (34, N'Boss Question', NULL, N'quiz for challenge', 2, 1, NULL, 2, NULL, 60, 4, CAST(N'2023-11-26T13:23:27.680' AS DateTime), CAST(N'2023-11-26T13:23:27.680' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (35, N'test t?o quiz', 2, N'hhhhhhhhhhh ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggghhhhhhhhhh ggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg', 1, 3, N'image/quiz-practice/5664b324-fc94-461c-9358-8d8732ef28c0.jpg', 1, NULL, 0, 4, CAST(N'2023-12-04T14:22:00.750' AS DateTime), CAST(N'2023-12-04T14:22:00.750' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (47, N'demo tao quiz fix 2', 1, N'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', 1, 4, NULL, 2, N'ko phu hop', 0, 4, CAST(N'2023-12-14T17:59:25.510' AS DateTime), CAST(N'2023-12-14T18:04:14.070' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (48, N'test ne d', 1, N'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh', 1, 2, NULL, 1, NULL, 0, 4, CAST(N'2023-12-15T01:07:23.593' AS DateTime), CAST(N'2023-12-15T01:07:32.767' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (49, N'History of Vietnames ne', 0, N'this my quiz about history VN', 3, 1, N'image/quiz-private/c755d6a2-0a51-45d1-ae73-0a26218abdb9.jpg', 1, NULL, 0, 4, CAST(N'2023-12-15T18:10:30.867' AS DateTime), CAST(N'2023-12-18T01:16:09.563' AS DateTime))
INSERT [dbo].[Quizzes] ([quiz_id], [title], [category_id], [description], [quiz_type], [status], [image], [difficulty_level], [comment], [time_limit], [creator_id], [create_date], [updated_at]) VALUES (50, N'Technology of World', 0, N'Technology of World', 3, 1, NULL, 1, NULL, 0, 4, CAST(N'2023-05-15T18:49:40.160' AS DateTime), CAST(N'2023-05-15T18:49:40.160' AS DateTime))
SET IDENTITY_INSERT [dbo].[Quizzes] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([user_id], [username], [fullname], [email], [Description], [password], [role], [exp], [score], [token], [status], [images], [verification_code], [created_at], [updated_at]) VALUES (1, N'User1', N'User One', N'user1@example.com', NULL, N'password1', 4, 1000, 500, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxIiwicm9sZSI6IjQiLCJleHAiOjE3MDMwNDkwNjEsImlzcyI6IldQRVJZeEZnOFVORExWeTZ3WkphOUNuUXVydjNwN3pCIiwiYXVkIjoiVXM1OXZZVlJtekJmUGdTQVhEazJjeGpXQzN1S3lwNDYifQ.qSA-_lYhdU3wQBDM3meFL_rGejnaVzaB31zaB10TKbo', 1, N'', NULL, CAST(N'2023-10-08T08:00:00.000' AS DateTime), CAST(N'2023-10-08T08:30:00.000' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [fullname], [email], [Description], [password], [role], [exp], [score], [token], [status], [images], [verification_code], [created_at], [updated_at]) VALUES (2, N'User2', N'User Two', N'user2@example.com', NULL, N'password2', 2, 150, 600, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyIiwicm9sZSI6IjIiLCJleHAiOjE3MDIzOTA3NjYsImlzcyI6IldQRVJZeEZnOFVORExWeTZ3WkphOUNuUXVydjNwN3pCIiwiYXVkIjoiVXM1OXZZVlJtekJmUGdTQVhEazJjeGpXQzN1S3lwNDYifQ.bvqA9-wHS0_7efLT5y5SzFMjt_xr5gSoxam6m5ujaAg', 1, N'image/avatar/User2.jpg', NULL, CAST(N'2023-10-08T08:30:00.000' AS DateTime), CAST(N'2023-10-08T09:00:00.000' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [fullname], [email], [Description], [password], [role], [exp], [score], [token], [status], [images], [verification_code], [created_at], [updated_at]) VALUES (3, N'User3', N'User Three', N'user3@example.com', NULL, N'password3', 3, 75, 400, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIzIiwicm9sZSI6IjMiLCJleHAiOjE3MDMwNDg2ODYsImlzcyI6IldQRVJZeEZnOFVORExWeTZ3WkphOUNuUXVydjNwN3pCIiwiYXVkIjoiVXM1OXZZVlJtekJmUGdTQVhEazJjeGpXQzN1S3lwNDYifQ.hQlleyzKzPCelq-67bkWOASyctBrT7Bz0-KwmO5AcRI', 0, NULL, NULL, CAST(N'2023-10-08T09:00:00.000' AS DateTime), CAST(N'2023-10-08T09:30:00.000' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [fullname], [email], [Description], [password], [role], [exp], [score], [token], [status], [images], [verification_code], [created_at], [updated_at]) VALUES (4, N'hello221', N'Phan Quan', N'hellone@gmail.com', N'-----I AMn HERO 😎😍------', N'password1', 1, 1000, 100, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0Iiwicm9sZSI6IjEiLCJleHAiOjE3MDMwNDcwMzAsImlzcyI6IldQRVJZeEZnOFVORExWeTZ3WkphOUNuUXVydjNwN3pCIiwiYXVkIjoiVXM1OXZZVlJtekJmUGdTQVhEazJjeGpXQzN1S3lwNDYifQ.i1Iyic8ErYZEAaGP1uMsmUn2Bvvh9gPJOfb7_yBQ6os', 1, N'image/avatar/hello221.jpg', NULL, CAST(N'2023-10-08T09:00:00.000' AS DateTime), CAST(N'2023-10-08T09:30:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Quizzes] FOREIGN KEY([quiz_id])
REFERENCES [dbo].[Quizzes] ([quiz_id])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Quizzes]
GO
ALTER TABLE [dbo].[ExamUser]  WITH CHECK ADD  CONSTRAINT [FK_ExamUser_Exam] FOREIGN KEY([exam_id])
REFERENCES [dbo].[Exam] ([exam_id])
GO
ALTER TABLE [dbo].[ExamUser] CHECK CONSTRAINT [FK_ExamUser_Exam]
GO
ALTER TABLE [dbo].[ExamUser]  WITH CHECK ADD  CONSTRAINT [FK_ExamUser_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[ExamUser] CHECK CONSTRAINT [FK_ExamUser_Users]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK_Friends_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK_Friends_Users]
GO
ALTER TABLE [dbo].[Friends]  WITH CHECK ADD  CONSTRAINT [FK_Friends_Users1] FOREIGN KEY([friend_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Friends] CHECK CONSTRAINT [FK_Friends_Users1]
GO
ALTER TABLE [dbo].[HistoryUser]  WITH CHECK ADD  CONSTRAINT [FK_HistoryUser_Quizzes] FOREIGN KEY([quiz_id])
REFERENCES [dbo].[Quizzes] ([quiz_id])
GO
ALTER TABLE [dbo].[HistoryUser] CHECK CONSTRAINT [FK_HistoryUser_Quizzes]
GO
ALTER TABLE [dbo].[HistoryUser]  WITH CHECK ADD  CONSTRAINT [FK_HistoryUser_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[HistoryUser] CHECK CONSTRAINT [FK_HistoryUser_Users]
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD  CONSTRAINT [FK_Notification_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Notification] CHECK CONSTRAINT [FK_Notification_Users]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Users] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Users]
GO
ALTER TABLE [dbo].[QuestionsAttempts]  WITH CHECK ADD  CONSTRAINT [FK__Questions__quest__34C8D9D1] FOREIGN KEY([question_id])
REFERENCES [dbo].[Questions] ([question_id])
GO
ALTER TABLE [dbo].[QuestionsAttempts] CHECK CONSTRAINT [FK__Questions__quest__34C8D9D1]
GO
ALTER TABLE [dbo].[QuestionsAttempts]  WITH CHECK ADD  CONSTRAINT [FK__Questions__quiz___35BCFE0A] FOREIGN KEY([quiz_id])
REFERENCES [dbo].[Quizzes] ([quiz_id])
GO
ALTER TABLE [dbo].[QuestionsAttempts] CHECK CONSTRAINT [FK__Questions__quiz___35BCFE0A]
GO
ALTER TABLE [dbo].[Quizzes]  WITH CHECK ADD  CONSTRAINT [FK__Quizzes__creator__36B12243] FOREIGN KEY([creator_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Quizzes] CHECK CONSTRAINT [FK__Quizzes__creator__36B12243]
GO
ALTER TABLE [dbo].[RoomQuiz]  WITH CHECK ADD  CONSTRAINT [FK_RoomQuiz_Quizzes] FOREIGN KEY([quiz_id])
REFERENCES [dbo].[Quizzes] ([quiz_id])
GO
ALTER TABLE [dbo].[RoomQuiz] CHECK CONSTRAINT [FK_RoomQuiz_Quizzes]
GO
ALTER TABLE [dbo].[UserRoomQuiz]  WITH CHECK ADD  CONSTRAINT [FK_UserRoomQuiz_RoomQuiz] FOREIGN KEY([room_id])
REFERENCES [dbo].[RoomQuiz] ([room_id])
GO
ALTER TABLE [dbo].[UserRoomQuiz] CHECK CONSTRAINT [FK_UserRoomQuiz_RoomQuiz]
GO
ALTER TABLE [dbo].[UserRoomQuiz]  WITH CHECK ADD  CONSTRAINT [FK_UserRoomQuiz_Users1] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[UserRoomQuiz] CHECK CONSTRAINT [FK_UserRoomQuiz_Users1]
GO
