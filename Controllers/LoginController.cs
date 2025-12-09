using Gardenia_MVC.Data;
using Gardenia_MVC.Services;
using Microsoft.AspNetCore.Mvc;


namespace Gardenia_MVC.Controllers;

        public class LoginController : Controller
        {
    
        private readonly AppDbContext _context;

        public LoginController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

          [HttpPost]
        public IActionResult Entrar(string email, string senha)
        {
            if(string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(senha))
            {
                ViewBag.Erro = "Preencha todos os campos.";
                return View("Index");
            }

            byte[] senhaDigitadaHash = HashService.GerarHashBytes(senha);

            var usuario = _context.Clientes.FirstOrDefault(usuario => usuario.Email == email);

            if(usuario == null)
            {
                ViewBag.Erro = "Email ou senha incorretos.";
                ViewBag.EmailDigitado = email;
                return View("Index");
            }

            if(!usuario.SenhaHash.SequenceEqual(senhaDigitadaHash))
            {
                ViewBag.Erro = "Email ou senha incorretos.";
                return View("Index");
            }

            HttpContext.Session.SetString("UsuarioNome", usuario.NomeCompleto);
            HttpContext.Session.SetInt32("UsuarioId", usuario.ID_Cliente);

            return RedirectToAction("Index","Home");
        }

        public IActionResult Sair()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }

    }

        