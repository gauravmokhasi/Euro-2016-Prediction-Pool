CREATE TABLE [dbo].[Fixtures]
(
	[MatchId] INT PRIMARY KEY,
	[HomeTeam] NVARCHAR(50) NOT NULL,
	[AwayTeam] NVARCHAR(50) NOT NULL,
	[HomeTeamScore] INT NOT NULL DEFAULT 0,
	[AwayTeamScore] INT NOT NULL DEFAULT 0,
	[MatchDate] DATE NOT NULL
)