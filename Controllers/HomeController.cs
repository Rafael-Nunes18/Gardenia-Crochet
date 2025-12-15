<<<<<<< HEAD
using Microsoft.AspNetCore.Mvc;

using Gardenia_MVC.Data;
=======
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Mvc;

using Gardenia_MVC.Data;
using Gardenia_MVC.Models;
using System.Security.Claims;
>>>>>>> 171399d6080b09c1a848a1754b7b868eb726a6f5

namespace Gardenia_Crochet.Controllers
{
    public class HomeController : Controller
    {
        public AppDbContext _context;

        public HomeController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult VerificarAcesso()
        {
            var IdCliente = HttpContext.Session.GetInt32("ID_Cliente");
            if (IdCliente != null)
                return RedirectToAction("Index", "Login");
            else
                return RedirectToAction("Index", "Perfil");

        }

        public IActionResult acessarEncomenda()
        {
            if (HttpContext.Session.GetInt32("ID_Cliente") == null)
                return RedirectToAction("Index", "Login");
            else
                return RedirectToAction("Index", "Encomenda");
        }

        public IActionResult acessarCarrinho()
        {
            if (HttpContext.Session.GetInt32("ID_Cliente") == null)
                return RedirectToAction("Index", "Login");
            else
                return RedirectToAction("Index", "Carrinho");
        }

        public IActionResult acessarPerfil()
        {
            if (HttpContext.Session.GetInt32("ID_Cliente") == null)
                return RedirectToAction("Index", "Login");
            else
                return RedirectToAction("Index", "Perfil");
        }

        public IActionResult acessarPortfolio()
        {
            if (HttpContext.Session.GetInt32("ID_Cliente") == null)
                return RedirectToAction("Index", "Login");
            else
                return RedirectToAction("Index", "Portfolio");
        }

        public IActionResult acessarTrabalheConosco()
        {
            if (HttpContext.Session.GetInt32("ID_Cliente") == null)
            {
                return RedirectToAction("Index", "Login");
            }
            else
            {
                return RedirectToAction("Index", "TrabalheConosco");
            }
        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> 171399d6080b09c1a848a1754b7b868eb726a6f5
