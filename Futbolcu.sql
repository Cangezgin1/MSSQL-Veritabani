USE [Futbol]
GO
/****** Object:  Table [dbo].[Futbolcu]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Futbolcu](
	[FutbolcuID] [tinyint] NOT NULL,
	[TakımID] [tinyint] NULL,
	[Adı] [nvarchar](20) NULL,
	[FormaNo] [nvarchar](20) NULL,
	[PozisyonID] [tinyint] NULL,
	[Kayıtlımı] [char](1) NULL,
 CONSTRAINT [PK_Futbolcu] PRIMARY KEY CLUSTERED 
(
	[FutbolcuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Takım]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Takım](
	[TakimID] [tinyint] NOT NULL,
	[TakimAd] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_Takım] PRIMARY KEY CLUSTERED 
(
	[TakimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Musakaba]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musakaba](
	[MusakabaID] [tinyint] NOT NULL,
	[MusakabaAdi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Musakaba] PRIMARY KEY CLUSTERED 
(
	[MusakabaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fikstür]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fikstür](
	[FikstürID] [tinyint] NOT NULL,
	[MüsakabaTarihi] [nvarchar](15) NOT NULL,
	[MüsakabaZamani] [time](7) NOT NULL,
	[EvSahibiTakımID] [tinyint] NOT NULL,
	[KonukTakımID] [tinyint] NOT NULL,
	[MusakabaID] [tinyint] NOT NULL,
 CONSTRAINT [PK_Fikstür] PRIMARY KEY CLUSTERED 
(
	[FikstürID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FutbolcuFikstür]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FutbolcuFikstür](
	[FikstürID] [tinyint] NOT NULL,
	[FutbolcuID] [tinyint] NOT NULL,
	[GolSayısı] [tinyint] NOT NULL,
	[AsistSayısı] [tinyint] NOT NULL,
 CONSTRAINT [PK_FutbolcuFikstür] PRIMARY KEY CLUSTERED 
(
	[FikstürID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[FutbolcuArama1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[FutbolcuArama1]
		as
		select f.Adı,t.TakimAd,m.MusakabaAdi,ff.GolSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on  f.FutbolcuID = ff.FutbolcuID
		inner join Fikstür fik on ff.FikstürID=fik.FikstürID
		inner join Musakaba m on fik.MusakabaID=m.MusakabaID
		where ff.GolSayısı > 0
		and m.MusakabaID = 4 
		and fik.MüsakabaZamani = '21:45:00'
		and fik.MüsakabaTarihi = 'Feb 16 2022'
GO
/****** Object:  Table [dbo].[Geçmiş]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Geçmiş](
	[FutbolcuID] [tinyint] NOT NULL,
	[Önceki Takım] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Geçmiş] PRIMARY KEY CLUSTERED 
(
	[FutbolcuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Geçmişler]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[Geçmişler]
		as
		select f.Adı,t.TakimAd,g.[Önceki Takım] from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
GO
/****** Object:  View [dbo].[AsistyapanıBulma]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[AsistyapanıBulma]
		as
		select f.Adı,t.TakimAd,m.MusakabaAdi,ff.AsistSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on  f.FutbolcuID = ff.FutbolcuID
		inner join Fikstür fik on ff.FikstürID=fik.FikstürID
		inner join Musakaba m on fik.MusakabaID=m.MusakabaID
		where ff.AsistSayısı > 0
		and m.MusakabaID = 5 
		and fik.MüsakabaZamani = '21:45:00'
		and fik.MüsakabaTarihi = 'Feb 16 2022'
GO
/****** Object:  Table [dbo].[Maaş]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maaş](
	[FutbolcuID] [tinyint] NOT NULL,
	[Yıllık Ücret] [int] NOT NULL,
 CONSTRAINT [PK_Maaş] PRIMARY KEY CLUSTERED 
(
	[FutbolcuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MaaşSorgulama]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[MaaşSorgulama]
		as
		select f.Adı,t.TakimAd,t.TakimID,m.[Yıllık Ücret] from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where t.TakimID = '8'
GO
/****** Object:  View [dbo].[GolveAsistGösterme]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[GolveAsistGösterme]
		as
		select f.Adı,t.TakimAd,ff.GolSayısı,ff.AsistSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on f.FutbolcuID=ff.FutbolcuID
		where ff.GolSayısı > 0
		or ff.AsistSayısı > 0
GO
/****** Object:  View [dbo].[GolveAsistGösterme1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create view [dbo].[GolveAsistGösterme1]
		as
		select f.Adı,t.TakimAd,ff.GolSayısı,ff.AsistSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on f.FutbolcuID=ff.FutbolcuID
		where ff.GolSayısı > 0
		or ff.AsistSayısı > 0
GO
/****** Object:  View [dbo].[MaaşSorgulama1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create view [dbo].[MaaşSorgulama1]
		as
		select f.Adı,t.TakimAd,t.TakimID,m.[Yıllık Ücret] from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where t.TakimID = '8'
GO
/****** Object:  View [dbo].[AsistyapanıBulma1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create view [dbo].[AsistyapanıBulma1]
		as
		select f.Adı,t.TakimAd,m.MusakabaAdi,ff.AsistSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on  f.FutbolcuID = ff.FutbolcuID
		inner join Fikstür fik on ff.FikstürID=fik.FikstürID
		inner join Musakaba m on fik.MusakabaID=m.MusakabaID
		where ff.AsistSayısı > 0
		and m.MusakabaID = 5 
		and fik.MüsakabaZamani = '21:45:00'
		and fik.MüsakabaTarihi = 'Feb 16 2022'
GO
/****** Object:  View [dbo].[GolAtanıBulma]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		create view [dbo].[GolAtanıBulma]
		as
		select f.Adı,t.TakimAd,m.MusakabaAdi,ff.GolSayısı from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join FutbolcuFikstür ff on  f.FutbolcuID = ff.FutbolcuID
		inner join Fikstür fik on ff.FikstürID=fik.FikstürID
		inner join Musakaba m on fik.MusakabaID=m.MusakabaID
		where ff.GolSayısı > 0
		and m.MusakabaID = 4 
		and fik.MüsakabaZamani = '21:45:00'
		and fik.MüsakabaTarihi = 'Feb 16 2022'
GO
/****** Object:  UserDefinedFunction [dbo].[ZamYap]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE function [dbo].[ZamYap]
		(
			@TakımAdı nvarchar(10)
		)
		returns table
		as
		return select t.TakimAd,f.Adı,m.[Yıllık Ücret],(m.[Yıllık Ücret]+m.[Yıllık Ücret]*0.2) as 'Zamlı Yıllık Ücret' from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join Maaş m on m.FutbolcuID=f.FutbolcuID
		where t.TakimAd = @TakımAdı
GO
/****** Object:  UserDefinedFunction [dbo].[FikstürListele]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create function [dbo].[FikstürListele]
		(
			@FikstürIDD tinyint
		)
		returns table
		as
		return select f.FikstürID,f.EvSahibiTakımID,f.KonukTakımID from Fikstür f
		inner join FutbolcuFikstür ff on f.FikstürID=ff.FikstürID
		inner join Musakaba m on f.MusakabaID=m.MusakabaID
		inner join Takım t on t.TakimID=f.EvSahibiTakımID
		inner join Futbolcu fut on fut.TakımID=t.TakimID
		where f.FikstürID = @FikstürIDD

GO
/****** Object:  Table [dbo].[Pozisyon]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pozisyon](
	[PozisyonID] [tinyint] NOT NULL,
	[PozisyonBilgisi] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Pozisyon] PRIMARY KEY CLUSTERED 
(
	[PozisyonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[PozisyonBilgisi1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create function [dbo].[PozisyonBilgisi1]
		(
			@PozisyonBilgi nvarchar(20)
		)
		returns table
		as
		return select f.Adı,p.PozisyonBilgisi from Pozisyon p
		inner join Futbolcu f on p.PozisyonID=f.PozisyonID
		where p.PozisyonBilgisi = @PozisyonBilgi

GO
/****** Object:  UserDefinedFunction [dbo].[PozisyonBilgisii]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create function [dbo].[PozisyonBilgisii]
		(
			@PozisyonBilgi nvarchar(20)
		)
		returns table
		as
		return select f.Adı,p.PozisyonBilgisi,ff.GolSayısı,ff.AsistSayısı from Pozisyon p
		inner join Futbolcu f on p.PozisyonID=f.PozisyonID
		inner join FutbolcuFikstür ff on f.FutbolcuID=ff.FutbolcuID
		where p.PozisyonBilgisi = @PozisyonBilgi

GO
/****** Object:  UserDefinedFunction [dbo].[İsmeGöreGeçmişGetirmee]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create function [dbo].[İsmeGöreGeçmişGetirmee]
		(
			@Futbolcuİsmi nvarchar(20)
		)
		returns table
		as
		return select f.Adı,g.[Önceki Takım],t.TakimAd from FutbolcuFikstür ff
		inner join Futbolcu f on ff.FutbolcuID=f.FutbolcuID
		inner join Takım t on t.TakimID=f.TakımID
		inner join Geçmiş g on g.FutbolcuID=f.FutbolcuID
		inner join Maaş m on m.FutbolcuID=f.FutbolcuID
		where f.Adı = @Futbolcuİsmi

GO
/****** Object:  View [dbo].[OrtAltındaGol]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[OrtAltındaGol]
		as
		select f.Adı,ff.GolSayısı,ff.AsistSayısı from FutbolcuFikstür ff
		inner join Futbolcu f on f.FutbolcuID=ff.FutbolcuID 
		where GolSayısı < (select AVG(GolSayısı) from FutbolcuFikstür)
GO
/****** Object:  View [dbo].[OrtAltındaGoll]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE view [dbo].[OrtAltındaGoll]
		as
		select f.Adı,ff.GolSayısı,ff.AsistSayısı from FutbolcuFikstür ff
		inner join Futbolcu f on f.FutbolcuID=ff.FutbolcuID 
		where GolSayısı < 3
GO
/****** Object:  Table [dbo].[Maaş Detay]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Maaş Detay](
	[FutbolcuID] [tinyint] NOT NULL,
	[Gol Başı] [nvarchar](10) NOT NULL,
	[Asist Başı] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (1, N'Feb 15 2022', CAST(N'21:45:00' AS Time), 1, 3, 1)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (2, N'Feb 15 2022', CAST(N'21:45:00' AS Time), 2, 4, 2)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (3, N'Feb 15 2022', CAST(N'21:45:00' AS Time), 5, 7, 3)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (4, N'Feb 16 2022', CAST(N'21:45:00' AS Time), 6, 10, 4)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (5, N'Feb 16 2022', CAST(N'21:45:00' AS Time), 8, 9, 5)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (6, N'Feb 16 2022', CAST(N'21:45:00' AS Time), 11, 15, 6)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (7, N'Feb 17 2022', CAST(N'21:45:00' AS Time), 12, 16, 7)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (8, N'Feb 17 2022', CAST(N'21:45:00' AS Time), 13, 17, 8)
INSERT [dbo].[Fikstür] ([FikstürID], [MüsakabaTarihi], [MüsakabaZamani], [EvSahibiTakımID], [KonukTakımID], [MusakabaID]) VALUES (9, N'Feb 17 2022', CAST(N'21:45:00' AS Time), 14, 18, 9)
GO
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (1, 1, N'Mesut Özil', N'10', 5, N'h')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (2, 1, N'Ferdi Kadıoğlu', N'2', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (3, 2, N'Muslera', N'1', 1, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (4, 2, N'Gomis', N'9', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (5, 3, N'Mount', N'11', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (6, 3, N'Kante', N'5', 5, N'h')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (7, 4, N'Strling', N'3', 3, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (8, 4, N'Foden', N'8', 6, N'h')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (9, 5, N'Adama Traore', N'4', 2, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (10, 5, N'Ferran Torres', N'17', 7, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (11, 7, N'Kimmich', N'20', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (12, 7, N'Lewandowski', N'21', 6, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (13, 8, N'Neymar', N'7', 6, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (14, 8, N'Messi', N'10', 7, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (15, 9, N'Hakan Çalhanoğlu', N'99', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (16, 9, N'Dzeko', N'10', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (17, 6, N'Toni Kross', N'4', 2, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (18, 6, N'Karim Benzema', N'3', 4, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (19, 10, N'Vlahovic', N'9', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (20, 10, N'Dybala', N'10', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (21, 11, N'Pizzi', N'8', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (22, 11, N'Okaka', N'7', 6, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (23, 12, N'C.Ronaldo', N'7', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (24, 12, N'Pogba', N'10', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (25, 13, N'Mane', N'9', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (26, 13, N'Thiago Alcantara', N'5', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (27, 14, N'Lacazette', N'11', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (28, 14, N'Martinelli', N'11', 7, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (29, 15, N'Pjanic', N'8', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (30, 15, N'Gzhall', N'17', 7, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (31, 16, N'Balotelli', N'9', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (32, 16, N'Yunus Akgün', N'7', 7, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (33, 17, N'İnsigne', N'7', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (34, 17, N'Eljif Elmas', N'10', 8, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (35, 18, N'G.Riana', N'8', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (36, 18, N'Belingam', N'6', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (37, 1, N'Arda Güler', N'8', 5, N'e')
INSERT [dbo].[Futbolcu] ([FutbolcuID], [TakımID], [Adı], [FormaNo], [PozisyonID], [Kayıtlımı]) VALUES (38, 5, N'asd', N'8', 5, NULL)
GO
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (1, 1, 0, 2)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (2, 8, 2, 1)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (3, 12, 2, 2)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (4, 19, 5, 0)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (5, 16, 0, 7)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (6, 21, 5, 1)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (7, 23, 11, 4)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (8, 26, 1, 9)
INSERT [dbo].[FutbolcuFikstür] ([FikstürID], [FutbolcuID], [GolSayısı], [AsistSayısı]) VALUES (9, 35, 4, 7)
GO
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (1, N'Arsenal')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (2, N'Fenerbahçe II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (3, N'Lazio')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (4, N'Al Ahli')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (5, N'İnter')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (6, N'Leicester City')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (7, N'Tottenham')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (8, N'Liverpool')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (9, N'Barcelona')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (10, N'Wolwes')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (11, N'Bayern II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (12, N'Hoffenheim')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (13, N'Barcelona')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (14, N'Barcelona')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (15, N'Lazio')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (16, N'Milan')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (17, N'Racing Club')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (18, N'Real Madrid')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (19, N'Fierontina')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (20, N'Juventus II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (21, N'Benfica')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (22, N'Aston Villa')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (23, N'Juventus')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (24, N'Benfica')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (25, N'Porto')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (26, N'Bayern Munih')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (27, N'Lyon')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (28, N'Arsenal II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (29, N'Barcelona')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (30, N'Leicester City')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (31, N'Milan')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (32, N'Galatasaray')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (33, N'Fenerbahçe')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (34, N'Napoli II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (35, N'B.Dortmund II')
INSERT [dbo].[Geçmiş] ([FutbolcuID], [Önceki Takım]) VALUES (36, N'B.Dortmund II')
GO
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (1, 2500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (2, 3500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (3, 4500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (4, 1500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (5, 2500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (6, 3500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (7, 4500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (8, 8500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (9, 9500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (10, 4500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (11, 2600000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (12, 4400000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (13, 2300000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (14, 7400000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (15, 4200000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (16, 4900000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (17, 7500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (18, 7400000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (19, 1900000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (20, 4800000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (21, 4600000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (22, 3700000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (23, 5200000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (24, 4700000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (25, 6500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (26, 6600000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (27, 4800000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (28, 2800000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (29, 3200000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (30, 4100000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (31, 3300000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (32, 7800000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (33, 4600000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (34, 4500000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (35, 2900000)
INSERT [dbo].[Maaş] ([FutbolcuID], [Yıllık Ücret]) VALUES (36, 4800000)
GO
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (1, N'100.000', N'50.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (2, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (3, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (4, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (5, N'100.000', N'60.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (6, N'100.000', N'10.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (7, N'100.000', N'20.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (8, N'100.000', N'50.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (9, N'100.000', N'80.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (10, N'100.000', N'10.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (11, N'100.000', N'20.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (12, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (13, N'100.000', N'90.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (14, N'100.000', N'10.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (15, N'100.000', N'20.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (16, N'100.000', N'80.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (17, N'100.000', N'30.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (18, N'100.000', N'80.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (19, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (20, N'100.000', N'60.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (21, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (22, N'100.000', N'50.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (23, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (24, N'100.000', N'60.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (25, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (26, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (27, N'100.000', N'90.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (28, N'100.000', N'10.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (29, N'100.000', N'20.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (30, N'100.000', N'30.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (31, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (32, N'100.000', N'80.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (33, N'100.000', N'40.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (34, N'100.000', N'70.000')
INSERT [dbo].[Maaş Detay] ([FutbolcuID], [Gol Başı], [Asist Başı]) VALUES (35, N'100.000', N'50.000')
GO
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (1, N'A Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (2, N'B Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (3, N'C Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (4, N'D Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (5, N'E Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (6, N'F Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (7, N'G Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (8, N'H Grubu')
INSERT [dbo].[Musakaba] ([MusakabaID], [MusakabaAdi]) VALUES (9, N'I Grubu')
GO
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (1, N'Kaleci')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (2, N'Stoper')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (3, N'Sağ Bek')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (4, N'Sol Bek')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (5, N'Orta Saha')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (6, N'Sol Kanat')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (7, N'Sağ Kanat')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (8, N'Forvet')
INSERT [dbo].[Pozisyon] ([PozisyonID], [PozisyonBilgisi]) VALUES (9, N'Libero')
GO
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (1, N'Fenerbahçe')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (2, N'Galatasaray')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (3, N'Chelsea')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (4, N'M.City')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (5, N'Barcelona')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (6, N'Real Madrid')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (7, N'Bayern Münih')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (8, N'PSG')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (9, N'İnter')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (10, N'Juventus')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (11, N'Başakşehir')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (12, N'M.United')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (13, N'Liverpool')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (14, N'Arsenal')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (15, N'Beşiktaş')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (16, N'Adana Demir Spor')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (17, N'Napoli')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (18, N'B.Dortmund')
INSERT [dbo].[Takım] ([TakimID], [TakimAd]) VALUES (19, N'asd')
GO
ALTER TABLE [dbo].[Fikstür]  WITH CHECK ADD  CONSTRAINT [FK_Fikstür_Musakaba1] FOREIGN KEY([MusakabaID])
REFERENCES [dbo].[Musakaba] ([MusakabaID])
GO
ALTER TABLE [dbo].[Fikstür] CHECK CONSTRAINT [FK_Fikstür_Musakaba1]
GO
ALTER TABLE [dbo].[Fikstür]  WITH CHECK ADD  CONSTRAINT [FK_Fikstür_Takım2] FOREIGN KEY([EvSahibiTakımID])
REFERENCES [dbo].[Takım] ([TakimID])
GO
ALTER TABLE [dbo].[Fikstür] CHECK CONSTRAINT [FK_Fikstür_Takım2]
GO
ALTER TABLE [dbo].[Fikstür]  WITH CHECK ADD  CONSTRAINT [FK_Fikstür_Takım3] FOREIGN KEY([KonukTakımID])
REFERENCES [dbo].[Takım] ([TakimID])
GO
ALTER TABLE [dbo].[Fikstür] CHECK CONSTRAINT [FK_Fikstür_Takım3]
GO
ALTER TABLE [dbo].[Futbolcu]  WITH CHECK ADD  CONSTRAINT [FK_Futbolcu_Pozisyon1] FOREIGN KEY([PozisyonID])
REFERENCES [dbo].[Pozisyon] ([PozisyonID])
GO
ALTER TABLE [dbo].[Futbolcu] CHECK CONSTRAINT [FK_Futbolcu_Pozisyon1]
GO
ALTER TABLE [dbo].[Futbolcu]  WITH CHECK ADD  CONSTRAINT [FK_Futbolcu_Takım1] FOREIGN KEY([TakımID])
REFERENCES [dbo].[Takım] ([TakimID])
GO
ALTER TABLE [dbo].[Futbolcu] CHECK CONSTRAINT [FK_Futbolcu_Takım1]
GO
ALTER TABLE [dbo].[FutbolcuFikstür]  WITH CHECK ADD  CONSTRAINT [FK_FutbolcuFikstür_Fikstür] FOREIGN KEY([FikstürID])
REFERENCES [dbo].[Fikstür] ([FikstürID])
GO
ALTER TABLE [dbo].[FutbolcuFikstür] CHECK CONSTRAINT [FK_FutbolcuFikstür_Fikstür]
GO
ALTER TABLE [dbo].[FutbolcuFikstür]  WITH CHECK ADD  CONSTRAINT [FK_FutbolcuFikstür_Futbolcu] FOREIGN KEY([FutbolcuID])
REFERENCES [dbo].[Futbolcu] ([FutbolcuID])
GO
ALTER TABLE [dbo].[FutbolcuFikstür] CHECK CONSTRAINT [FK_FutbolcuFikstür_Futbolcu]
GO
ALTER TABLE [dbo].[Geçmiş]  WITH CHECK ADD  CONSTRAINT [FK_Geçmiş_Futbolcu] FOREIGN KEY([FutbolcuID])
REFERENCES [dbo].[Futbolcu] ([FutbolcuID])
GO
ALTER TABLE [dbo].[Geçmiş] CHECK CONSTRAINT [FK_Geçmiş_Futbolcu]
GO
ALTER TABLE [dbo].[Maaş]  WITH CHECK ADD  CONSTRAINT [FK_Maaş_Futbolcu] FOREIGN KEY([FutbolcuID])
REFERENCES [dbo].[Futbolcu] ([FutbolcuID])
GO
ALTER TABLE [dbo].[Maaş] CHECK CONSTRAINT [FK_Maaş_Futbolcu]
GO
ALTER TABLE [dbo].[Maaş Detay]  WITH CHECK ADD  CONSTRAINT [FK_Maaş Detay_Futbolcu] FOREIGN KEY([FutbolcuID])
REFERENCES [dbo].[Futbolcu] ([FutbolcuID])
GO
ALTER TABLE [dbo].[Maaş Detay] CHECK CONSTRAINT [FK_Maaş Detay_Futbolcu]
GO
/****** Object:  StoredProcedure [dbo].[Asist]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[Asist]
		(
			@Ort tinyint
		)
		as
		select f.Adı,ff.AsistSayısı from Futbolcu f
		inner join FutbolcuFikstür ff on ff.FutbolcuID=f.FutbolcuID
		where AsistSayısı > @Ort
GO
/****** Object:  StoredProcedure [dbo].[FikstürIDyeGöreDetay]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[FikstürIDyeGöreDetay]
		(
			@FikstürID tinyint
		)
		as
		select f.FikstürID,f.EvSahibiTakımID,f.KonukTakımID from Fikstür f
		inner join FutbolcuFikstür ff on f.FikstürID=ff.FikstürID
		inner join Musakaba m on f.MusakabaID=m.MusakabaID
		inner join Takım t on t.TakimID=f.EvSahibiTakımID
		inner join Futbolcu fut on fut.TakımID=t.TakimID
		where f.FikstürID = @FikstürID

GO
/****** Object:  StoredProcedure [dbo].[FikstürIDyeGöreDetay11]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[FikstürIDyeGöreDetay11]
		(
			@FikstürID tinyint
		)
		as
		select f.FikstürID,f.EvSahibiTakımID,f.KonukTakımID from Fikstür f
		inner join FutbolcuFikstür ff on f.FikstürID=ff.FikstürID
		inner join Musakaba m on f.MusakabaID=m.MusakabaID
		inner join Takım t on t.TakimID=f.EvSahibiTakımID
		inner join Futbolcu fut on fut.TakımID=t.TakimID
		where f.FikstürID = @FikstürID

GO
/****** Object:  StoredProcedure [dbo].[FutbolcuEkleme]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[FutbolcuEkleme]
		(
			@FutbolcuID tinyint,
			@TakımID tinyint,
			@Adı nvarchar(20),
			@FormaNo nvarchar(20),
			@PozisyonID tinyint
		)
		as
		Insert Into Futbolcu
		Values (@FutbolcuID,@TakımID,@Adı,@FormaNo,@PozisyonID)
GO
/****** Object:  StoredProcedure [dbo].[FutbolcuİsmineGöreDetay]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[FutbolcuİsmineGöreDetay]
		(
			@Futbolcuİsmi nvarchar(15)
		)
		as
		select * from Futbolcu f
		inner join Takım t on f.TakımID=t.TakimID
		inner join FutbolcuFikstür ff on f.FutbolcuID=ff.FutbolcuID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where f.Adı=@Futbolcuİsmi

GO
/****** Object:  StoredProcedure [dbo].[FutbolcuİsmineGöreDetay1]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[FutbolcuİsmineGöreDetay1]
		(
			@Futbolcuİsmi1 nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd,m.[Yıllık Ücret] from Futbolcu f
		inner join Takım t on f.TakımID=t.TakimID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where f.Adı = @Futbolcuİsmi1

GO
/****** Object:  StoredProcedure [dbo].[FutbolcuİsmineGöreDetayy]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[FutbolcuİsmineGöreDetayy]
		(
			@Futbolcuİsmi1 nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd,m.[Yıllık Ücret] from Futbolcu f
		inner join Takım t on f.TakımID=t.TakimID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where f.Adı = @Futbolcuİsmi1

GO
/****** Object:  StoredProcedure [dbo].[FutbolcuİsmineGöreDetayyy]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[FutbolcuİsmineGöreDetayyy]
		(
			@Futbolcuİsmi1 nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd,m.[Yıllık Ücret] from Futbolcu f
		inner join Takım t on f.TakımID=t.TakimID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
		inner join Maaş m on f.FutbolcuID=m.FutbolcuID
		where f.Adı = @Futbolcuİsmi1

GO
/****** Object:  StoredProcedure [dbo].[İsmeGöreDetayGetirme]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		CREATE proc [dbo].[İsmeGöreDetayGetirme]
		(
			@Futbolcuİsmi nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd from FutbolcuFikstür ff
		inner join Futbolcu f on ff.FutbolcuID=f.FutbolcuID
		inner join Takım t on t.TakimID=f.TakımID
		inner join Geçmiş g on g.FutbolcuID=f.FutbolcuID
		inner join Maaş m on m.FutbolcuID=f.FutbolcuID
		where f.Adı = @Futbolcuİsmi

GO
/****** Object:  StoredProcedure [dbo].[İsmeGöreGeçmişGetirme]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[İsmeGöreGeçmişGetirme]
		(
			@Futbolcuİsmi nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd from FutbolcuFikstür ff
		inner join Futbolcu f on ff.FutbolcuID=f.FutbolcuID
		inner join Takım t on t.TakimID=f.TakımID
		inner join Geçmiş g on g.FutbolcuID=f.FutbolcuID
		inner join Maaş m on m.FutbolcuID=f.FutbolcuID
		where f.Adı = @Futbolcuİsmi

GO
/****** Object:  StoredProcedure [dbo].[MUSTAFA]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
			CREATE procedure [dbo].[MUSTAFA]
			(
				@ID tinyint=null,
				@TakımID varchar(100)=null,
				@FutbolcuAdı varchar(100)=null,
				@FormaNo varchar(100)=null,
				@PozisyonID varchar(100)=null,
				@Action varchar(100)=null

			)
			as begin
			if @Action='Delete'
			begin
			Update Futbolcu set Kayıtlımı='h' where FutbolcuID =@ID
			end 
			end
GO
/****** Object:  StoredProcedure [dbo].[PozisyonBilgisi]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[PozisyonBilgisi]
		(
			@PozisyonBilgi nvarchar(20)
		)
		as
		select f.Adı,p.PozisyonBilgisi from Pozisyon p
		inner join Futbolcu f on p.PozisyonID=f.PozisyonID
		where p.PozisyonBilgisi = @PozisyonBilgi

GO
/****** Object:  StoredProcedure [dbo].[TakımAdı]    Script Date: 4.03.2022 19:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		Create proc [dbo].[TakımAdı]
		(
			@TakımAdı nvarchar(20)
		)
		as
		select f.Adı,g.[Önceki Takım],t.TakimAd from Takım t
		inner join Futbolcu f on t.TakimID=f.TakımID
		inner join Geçmiş g on f.FutbolcuID=g.FutbolcuID
		where t.TakimAd = @TakımAdı

GO
