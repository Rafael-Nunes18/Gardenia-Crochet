using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Mvc;

using Gardenia_MVC.Data;
using Gardenia_MVC.Models;
using System.Security.Claims;

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
}
