using Euro2016.BusinessLogic;
using Euro2016.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Euro2016.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Fixtures()
        {
            ViewBag.Message = "List of fixtures for Euro 2016";
            List<Fixture> fixtures = DbHelper.GetAllFixtures();
            return View(fixtures);
        }

        public ActionResult Leaderboard()
        {
            ViewBag.Message = "Current Leaderboard based on player predictions";
            List<Player> players = DbHelper.GetAllPlayers();
            return View(players);
        }
    }
}