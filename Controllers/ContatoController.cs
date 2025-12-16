using Microsoft.AspNetCore.Mvc;

namespace Gardenia_MVC.Controllers
{
    public class ContatoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}