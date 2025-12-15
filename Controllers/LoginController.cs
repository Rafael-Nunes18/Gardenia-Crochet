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

            string senhaDigitadaHash = HashService.GerarHash(senha);

            var usuario = _context.Cliente.FirstOrDefault(usuario => usuario.Email == email);

    if (usuario == null || usuario.Senha != senhaDigitadaHash)
            {
                ViewBag.Erro = "email ou senha incorretos.";
                ViewBag.EmailDigitado = email;
                return View("Index");
            }

            HttpContext.Session.SetInt32("ID_Cliente", usuario.ID_Cliente);
            HttpContext.Session.SetString("UsuarioNome", usuario.NomeCompleto);

            return RedirectToAction("Index","Home");
        }

        public IActionResult Sair()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }

    }

        