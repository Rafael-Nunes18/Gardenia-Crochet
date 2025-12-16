using Microsoft.AspNetCore.Mvc;

namespace Gardenia_MVC.Controllers
{
    public class CarrinhoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}