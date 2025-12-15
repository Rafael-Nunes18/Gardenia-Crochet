using Microsoft.AspNetCore.Mvc;

namespace Gardenia_MVC.Controllers
{
    public class PortfolioController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}