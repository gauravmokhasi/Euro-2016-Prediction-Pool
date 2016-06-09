CREATE TABLE [dbo].[MatchPredictions]
(
	[Id] INT IDENTITY(1,1),
	[UserName] NVARCHAR(30) NOT NULL,
	[MatchId] INT NOT NULL,
	[HomeTeamPredictedScore] INT NOT NULL DEFAULT 0,
	[AwayTeamPredictedScore] INT NOT NULL DEFAULT 0,
	Primary Key (UserName, MatchId),
	Foreign Key (UserName) references Points(UserName),
	Foreign Key (MatchId) references Fixtures(MatchId)
)