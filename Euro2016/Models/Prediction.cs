using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Euro2016.Models
{
    public class Prediction
    {
        public string UserName { get; set; }
        public int MatchId { get; set; }
        public int HomeTeamPredictedScore { get; set; }
        public int AwayTeamPredictedScore { get; set; }
    }
}