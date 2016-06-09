﻿using Euro2016.Models;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

namespace Euro2016.BusinessLogic
{
    public class DbHelper
    {
        private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"]?.ConnectionString;

        public static void RecordPredictionReceived(string userName, int matchId, int homeTeamScore, int awayTeamScore)
        {
            if (!CheckPlayerInPointsTable(userName))
            {
                AddPlayerToPointsTable(userName);
            }
            string sqlQuery = "INSERT INTO MatchPredictions(UserName, MatchId, HomeTeamScore, AwayTeamScore) VALUES (" + userName + ", " + matchId + ", " + homeTeamScore + ", " + awayTeamScore + ")";
            WriteToDb(sqlQuery);
        }

        private static bool CheckPlayerInPointsTable(string userName)
        {
            List<Player> players = GetAllPlayers();
            int count = 0;
            foreach (Player player in players)
            {
                if (player.UserName == userName)
                {
                    break;
                }
                count += 1;
            }
            if (count == players.Count)
            {
                return false;
            }
            return true;
        }

        private static void AddPlayerToPointsTable(string userName)
        {
            string sqlQuery = "INSERT INTO Points(UserName) VALUES (" + userName + ")";
            WriteToDb(sqlQuery);
        }

        public static List<Fixture> GetAllFixtures()
        {
            List<Fixture> fixtures = new List<Fixture>();
            using (IDataReader reader = GetIDataReader("SELECT * FROM Fixtures"))
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

        private static List<Player> GetAllPlayers()
        {
            List<Player> players = new List<Player>();
            using (IDataReader reader = GetIDataReader("SELECT * FROM Points"))
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

        public static int WriteToDb(string sqlQuery)
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

        public static IDataReader GetIDataReader(string sqlQuery)
        {
            SqlDatabase database = new SqlDatabase(ConnectionString);
            DbCommand command = database.GetSqlStringCommand(sqlQuery);
            return database.ExecuteReader(command);
        }
    }
}