using Euro2016.Models;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;

namespace Euro2016.BusinessLogic
{
    public static class DbHelper
    {
        private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"]?.ConnectionString;

        public static void RecordPredictionReceived(Prediction prediction)
        {
            if (!CheckPlayerInPointsTable(prediction.UserName))
            {
                AddPlayerToPointsTable(prediction.UserName);
            }

            string sqlQuery = "";
            if (!CheckPlayerHasPredictionForMatch(prediction)){
                sqlQuery = "INSERT INTO MatchPredictions(UserName, MatchId, HomeTeamPredictedScore, AwayTeamPredictedScore) VALUES ('" + prediction.UserName + "', " + prediction.MatchId + ", " + prediction.HomeTeamPredictedScore + ", " + prediction.AwayTeamPredictedScore + ")";
            }
            else
            {
                sqlQuery = "UPDATE MatchPredictions SET HomeTeamPredictedScore = " + prediction.HomeTeamPredictedScore + ", AwayTeamPredictedScore = " + prediction.AwayTeamPredictedScore + " WHERE MatchId = " + prediction.MatchId;
            }
            WriteToDb(sqlQuery);
        }

        private static bool CheckPlayerHasPredictionForMatch(Prediction prediction)
        {
            List<Prediction> predictions = GetPredictionHistory(prediction.UserName);
            return predictions.Exists(x => x.MatchId == prediction.MatchId);
        }

        private static bool CheckPlayerInPointsTable(string userName)
        {
            List<Player> players = GetAllPlayers();
            return players.Exists(x => x.UserName == userName);
        }

        private static void AddPlayerToPointsTable(string userName)
        {
            string sqlQuery = "INSERT INTO Points(UserName) VALUES ('" + userName + "')";
            WriteToDb(sqlQuery);
        }

        public static void UpdateScore(Fixture fixture)
        {
            string sqlQuery = "UPDATE Fixtures SET HomeTeamScore = " + fixture.HomeTeamScore + ", AwayTeamScore = " + fixture.AwayTeamScore + " WHERE MatchId = " + fixture.MatchId;
            WriteToDb(sqlQuery);
        }

        public static List<Fixture> GetAllFixtures()
        {
            List<Fixture> fixtures = new List<Fixture>();
            using (IDataReader reader = GetIDataReader("SELECT * FROM Fixtures ORDER BY MatchDate"))
            {
                while (reader.Read())
                {
                    fixtures.Add(new Fixture
                    {
                        MatchId = (int)reader["MatchId"],
                        HomeTeam = (string)reader["HomeTeam"],
                        AwayTeam = (string)reader["AwayTeam"],
                        HomeTeamScore = (int)reader["HomeTeamScore"],
                        AwayTeamScore = (int)reader["AwayTeamScore"],
                        MatchDate = (DateTime)reader["MatchDate"]
                    });
                }
            }
            return fixtures;
        }

        public static void UpdateLeaderboard()
        {
            List<Player> players = GetAllPlayers();
            List<Fixture> fixtures = GetAllFixtures();
            foreach (Player player in players)
            {
                int points = 0;
                List<Prediction> predictions = GetPredictionHistory(player.UserName);
                foreach (Fixture fixture in fixtures)
                {
                    int pointsIncrement = 0;
                    if (fixture.MatchDate < DateTime.UtcNow)
                    {
                        if(predictions.Exists(x=> x.MatchId == fixture.MatchId))
                        {
                            Prediction matchPrediction = predictions.Find(x => x.MatchId == fixture.MatchId);
                            int actualResult = fixture.HomeTeamScore - fixture.AwayTeamScore;
                            int predictedResult = matchPrediction.HomeTeamPredictedScore - matchPrediction.AwayTeamPredictedScore;
                            if (fixture.HomeTeamScore == matchPrediction.HomeTeamPredictedScore && fixture.AwayTeamScore == matchPrediction.AwayTeamPredictedScore)
                            {
                                pointsIncrement = 8;
                            }
                            else if (actualResult == predictedResult)
                            {
                                pointsIncrement = 5;
                            }
                            else if (actualResult.CompareTo(0) == predictedResult.CompareTo(0))
                            {
                                pointsIncrement = 3;
                            }
                        }
                        points += pointsIncrement;
                    }
                }
                string sqlQuery = "UPDATE Points SET Points = " + points + " WHERE username = '" + player.UserName + "'";
                WriteToDb(sqlQuery);
            }
        }

        public static List<Player> GetAllPlayers()
        {
            List<Player> players = new List<Player>();
            using (IDataReader reader = GetIDataReader("SELECT * FROM Points ORDER BY Points DESC"))
            {
                while (reader.Read())
                {
                    players.Add(new Player
                    {
                        UserName = (string)reader["UserName"],
                        Points = (int)reader["Points"]
                    });
                }
            }
            return players;
        }

        public static List<Prediction> GetPredictionHistory(string username)
        {
            List<Prediction> predictions = new List<Prediction>();
            using (IDataReader reader = GetIDataReader("SELECT MP.MatchId AS MatchId, UserName, HomeTeamPredictedScore, AwayTeamPredictedScore, HomeTeam, AwayTeam, MatchDate FROM MatchPredictions MP, Fixtures F WHERE MP.MatchId = F.MatchId AND UserName = '" + username + "'"))
            {
                while (reader.Read())
                {
                    predictions.Add(new Prediction
                    {
                        MatchId = (int)reader["MatchId"],
                        UserName = (string)reader["UserName"],
                        HomeTeamPredictedScore = (int)reader["HomeTeamPredictedScore"],
                        AwayTeamPredictedScore = (int)reader["AwayTeamPredictedScore"],
                        HomeTeam = (string)reader["HomeTeam"],
                        AwayTeam = (string)reader["AwayTeam"],
                        MatchDate = ((DateTime)reader["MatchDate"]).Date
                    });
                }
            }
            return predictions;
        }

        private static int WriteToDb(string sqlQuery)
        {
            try
            {
                SqlDatabase database = new SqlDatabase(ConnectionString);
                DbCommand command = database.GetSqlStringCommand(sqlQuery);
                return database.ExecuteNonQuery(command);
            }
            catch (Exception ex)
            {
                return -1;
            }
        }

        private static IDataReader GetIDataReader(string sqlQuery)
        {
            SqlDatabase database = new SqlDatabase(ConnectionString);
            DbCommand command = database.GetSqlStringCommand(sqlQuery);
            return database.ExecuteReader(command);
        }
    }
}