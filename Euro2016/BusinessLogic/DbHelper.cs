using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Linq;
using System.Web;

namespace Euro2016.BusinessLogic
{
    public class DbHelper
    {
        private static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"]?.ConnectionString;

        public static void RecordPredictionReceive(int homeTeamScore, int awayTeamScore)
        {
            string sqlQuery = "INSERT INTO "
        }

        public static int WriteToDb(string sqlQuery)
        {
            try
            {
                SqlDatabase db = new SqlDatabase(ConnectionString);
                DbCommand cmd = db.GetSqlStringCommand(sqlQuery);

                //return the number of rows affected
                return db.ExecuteNonQuery(cmd);
            }
            catch (Exception ex)
            {
            }
            return -1;
        }
    }


}