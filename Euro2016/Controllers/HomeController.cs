using Euro2016.BusinessLogic;
using Euro2016.Models;
using System.Collections.Generic;
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

        public ActionResult Predictions()
        {
            ViewBag.Message = "List of all predictions you have made so far";
            List<Prediction> predictions = DbHelper.GetPredictionHistory(@User.Identity.Name);
            return View(predictions);
        }

        [HttpPost]
        public ActionResult Predict(Prediction prediction)
        {
            prediction.UserName = @User.Identity.Name;
            DbHelper.RecordPredictionReceived(prediction);
            return RedirectToAction("Predictions");
        }
    }
}