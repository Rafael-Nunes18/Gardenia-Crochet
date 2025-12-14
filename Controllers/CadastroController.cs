using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Mvc;
using GoogleLogin.Data;
using GoogleLogin.Models;

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
