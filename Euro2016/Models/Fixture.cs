using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Euro2016.Models
{
    public class Fixture
    {
        public int MatchId { get; set; }
        public string HomeTeam { get; set; }
        public string AwayTeam { get; set; }
        public int HomeTeamScore { get; set; }
        public int AwayTeamScore { get; set; }
        public DateTime MatchDate { get; set; }
    }
}