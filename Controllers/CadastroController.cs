<<<<<<< HEAD
=======
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
>>>>>>> 171399d6080b09c1a848a1754b7b868eb726a6f5
using Microsoft.AspNetCore.Mvc;
using GoogleLogin.Data;
using GoogleLogin.Models;

<<<<<<< HEAD
namespace Gardenia_MVC.Controllers
{
    public class CadastroController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
=======
namespace GoogleLogin.Controllers
{
    public class AuthController : Controller
    {
        private readonly AppDbContext _db;

        public AuthController(AppDbContext db)
        {
            _db = db;
        }

        public IActionResult Login()
        {
            return View();
        }

        public IActionResult LoginGoogle()
        {
            var redirectUrl = Url.Action("GoogleResponse", "Auth");
            return Challenge(new AuthenticationProperties { RedirectUri = redirectUrl }, GoogleDefaults.AuthenticationScheme);
        }

        public async Task<IActionResult> GoogleResponse()
        {
            var result = await HttpContext.AuthenticateAsync();

            var email = result.Principal.FindFirst(c => c.Type.Contains("email"))?.Value;
            var nome = result.Principal.FindFirst(c => c.Type.Contains("name"))?.Value;

            // Buscar no banco
            var usuario = _db.Usuario.FirstOrDefault(u => u.Email == email);

            if (usuario == null)
            {
                usuario = new Usuario
                {
                    Email = email,
                    NomeCompleto = nome,
                    NomeUsuario = nome,
                    Senha = null,
                    CriadoEm = DateTime.Now,
                    RegraId = 2
                };

                _db.Usuario.Add(usuario);
                _db.SaveChanges();
            }

            return RedirectToAction("Index", "Home");
        }

        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync();
            return RedirectToAction("Login");
        }
    }
}
>>>>>>> 171399d6080b09c1a848a1754b7b868eb726a6f5
