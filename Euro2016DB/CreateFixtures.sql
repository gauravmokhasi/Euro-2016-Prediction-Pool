USE [master]
GO
/****** Object:  Database [Euro2016DB]    Script Date: 6/24/2016 10:14:23 AM ******/
CREATE DATABASE [Euro2016DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Euro2016DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Euro2016DB_Primary.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Euro2016DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Euro2016DB_Primary.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Euro2016DB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Euro2016DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Euro2016DB] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [Euro2016DB] SET ANSI_NULLS ON 
GO
ALTER DATABASE [Euro2016DB] SET ANSI_PADDING ON 
GO
ALTER DATABASE [Euro2016DB] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [Euro2016DB] SET ARITHABORT ON 
GO
ALTER DATABASE [Euro2016DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Euro2016DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Euro2016DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Euro2016DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Euro2016DB] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [Euro2016DB] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [Euro2016DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Euro2016DB] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [Euro2016DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Euro2016DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Euro2016DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Euro2016DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Euro2016DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Euro2016DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Euro2016DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Euro2016DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Euro2016DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Euro2016DB] SET RECOVERY FULL 
GO
ALTER DATABASE [Euro2016DB] SET  MULTI_USER 
GO
ALTER DATABASE [Euro2016DB] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [Euro2016DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Euro2016DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Euro2016DB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Euro2016DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Euro2016DB', N'ON'
GO
USE [Euro2016DB]
GO
/****** Object:  Table [dbo].[Fixtures]    Script Date: 6/24/2016 10:14:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fixtures](
	[MatchId] [int] NOT NULL,
	[HomeTeam] [nvarchar](50) NOT NULL,
	[AwayTeam] [nvarchar](50) NOT NULL,
	[HomeTeamScore] [int] NOT NULL DEFAULT ((0)),
	[AwayTeamScore] [int] NOT NULL DEFAULT ((0)),
	[MatchDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MatchPredictions]    Script Date: 6/24/2016 10:14:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchPredictions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](30) NOT NULL,
	[MatchId] [int] NOT NULL,
	[HomeTeamPredictedScore] [int] NOT NULL DEFAULT ((0)),
	[AwayTeamPredictedScore] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC,
	[MatchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Points]    Script Date: 6/24/2016 10:14:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Points](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](30) NOT NULL,
	[Points] [int] NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (1, N'France', N'Romania', 2, 1, CAST(N'2016-06-10' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (2, N'Albania', N'Switzerland', 0, 1, CAST(N'2016-06-11' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (3, N'Wales', N'Slovakia', 2, 1, CAST(N'2016-06-11' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (4, N'England', N'Russia', 1, 1, CAST(N'2016-06-11' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (5, N'Turkey', N'Croatia', 0, 1, CAST(N'2016-06-12' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (6, N'Poland', N'Northern Ireland', 1, 0, CAST(N'2016-06-12' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (7, N'Germany', N'Ukraine', 2, 0, CAST(N'2016-06-12' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (8, N'Spain', N'Czech Republic', 1, 0, CAST(N'2016-06-13' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (9, N'Republic of Ireland', N'Sweden', 1, 1, CAST(N'2016-06-13' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (10, N'Belgium', N'Italy', 0, 2, CAST(N'2016-06-13' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (11, N'Austria', N'Hungary', 0, 2, CAST(N'2016-06-14' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (12, N'Portugal', N'Iceland', 1, 1, CAST(N'2016-06-14' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (13, N'Russia', N'Slovakia', 1, 2, CAST(N'2016-06-15' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (14, N'Romania', N'Switzerland', 1, 1, CAST(N'2016-06-15' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (15, N'France', N'Albania', 2, 0, CAST(N'2016-06-15' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (16, N'England', N'Wales', 2, 1, CAST(N'2016-06-16' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (17, N'Ukraine', N'Northern Ireland', 0, 2, CAST(N'2016-06-16' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (18, N'Germany', N'Poland', 0, 0, CAST(N'2016-06-16' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (19, N'Italy', N'Sweden', 1, 0, CAST(N'2016-06-17' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (20, N'Czech Republic', N'Croatia', 2, 2, CAST(N'2016-06-17' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (21, N'Spain', N'Turkey', 3, 0, CAST(N'2016-06-17' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (22, N'Belgium', N'Republic of Ireland', 3, 0, CAST(N'2016-06-18' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (23, N'Iceland', N'Hungary', 1, 1, CAST(N'2016-06-18' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (24, N'Portugal', N'Austria', 0, 0, CAST(N'2016-06-18' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (25, N'Romania', N'Albania', 0, 1, CAST(N'2016-06-19' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (26, N'Switzerland', N'France', 0, 0, CAST(N'2016-06-19' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (27, N'Russia', N'Wales', 0, 3, CAST(N'2016-06-20' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (28, N'Slovakia', N'England', 0, 0, CAST(N'2016-06-20' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (29, N'Ukraine', N'Poland', 0, 1, CAST(N'2016-06-21' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (30, N'Northern Ireland', N'Germany', 0, 1, CAST(N'2016-06-21' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (31, N'Czech Republic', N'Turkey', 0, 2, CAST(N'2016-06-21' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (32, N'Croatia', N'Spain', 2, 1, CAST(N'2016-06-21' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (33, N'Iceland', N'Austria', 2, 1, CAST(N'2016-06-22' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (34, N'Hungary', N'Portugal', 3, 3, CAST(N'2016-06-22' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (35, N'Italy', N'Republic of Ireland', 0, 1, CAST(N'2016-06-22' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (36, N'Sweden', N'Belgium', 0, 1, CAST(N'2016-06-22' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (37, N'Switzerland', N'Poland', -99, -99, CAST(N'2016-06-25' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (38, N'Wales', N'Northern Ireland', -99, -99, CAST(N'2016-06-25' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (39, N'Croatia', N'Portugal', -99, -99, CAST(N'2016-06-25' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (40, N'France', N'Republic of Ireland', -99, -99, CAST(N'2016-06-26' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (41, N'Germany', N'Slovakia', -99, -99, CAST(N'2016-06-26' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (42, N'Hungary', N'Belgium', -99, -99, CAST(N'2016-06-26' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (43, N'Italy', N'Spain', -99, -99, CAST(N'2016-06-27' AS Date))
INSERT [dbo].[Fixtures] ([MatchId], [HomeTeam], [AwayTeam], [HomeTeamScore], [AwayTeamScore], [MatchDate]) VALUES (44, N'England', N'Iceland', -99, -99, CAST(N'2016-06-27' AS Date))
SET IDENTITY_INSERT [dbo].[MatchPredictions] ON 

INSERT [dbo].[MatchPredictions] ([Id], [UserName], [MatchId], [HomeTeamPredictedScore], [AwayTeamPredictedScore]) VALUES (1014, N'VISA\gmokhasi', 13, 3, 1)
INSERT [dbo].[MatchPredictions] ([Id], [UserName], [MatchId], [HomeTeamPredictedScore], [AwayTeamPredictedScore]) VALUES (1015, N'VISA\gmokhasi', 14, 2, 1)
INSERT [dbo].[MatchPredictions] ([Id], [UserName], [MatchId], [HomeTeamPredictedScore], [AwayTeamPredictedScore]) VALUES (1016, N'VISA\gmokhasi', 27, 0, 1)
INSERT [dbo].[MatchPredictions] ([Id], [UserName], [MatchId], [HomeTeamPredictedScore], [AwayTeamPredictedScore]) VALUES (1017, N'VISA\gmokhasi', 33, 0, 0)
INSERT [dbo].[MatchPredictions] ([Id], [UserName], [MatchId], [HomeTeamPredictedScore], [AwayTeamPredictedScore]) VALUES (1018, N'VISA\gmokhasi', 34, 1, 2)
SET IDENTITY_INSERT [dbo].[MatchPredictions] OFF
SET IDENTITY_INSERT [dbo].[Points] ON 

INSERT [dbo].[Points] ([UserId], [UserName], [Points]) VALUES (1002, N'VISA\gmokhasi', 3)
SET IDENTITY_INSERT [dbo].[Points] OFF
ALTER TABLE [dbo].[MatchPredictions]  WITH CHECK ADD FOREIGN KEY([MatchId])
REFERENCES [dbo].[Fixtures] ([MatchId])
GO
ALTER TABLE [dbo].[MatchPredictions]  WITH CHECK ADD FOREIGN KEY([UserName])
REFERENCES [dbo].[Points] ([UserName])
GO
USE [master]
GO
ALTER DATABASE [Euro2016DB] SET  READ_WRITE 
GO
