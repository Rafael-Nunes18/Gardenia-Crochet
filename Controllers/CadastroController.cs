using Gardenia_MVC.Data;
using Gardenia_MVC.Models;
using Gardenia_MVC.Services;
using Microsoft.AspNetCore.Mvc;


namespace Gardenia_MVC.Controllers;

        public class CadastroController : Controller
        {
    
        private readonly AppDbContext _context;

        public CadastroController(AppDbContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Registrar(string nomeCompleto, string email, string senha)
        {
            if(string.IsNullOrWhiteSpace(nomeCompleto) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(senha))
            {
                ViewBag.Erro = "Preencha todos os campos.";
                return View("Index");
            }

            var usuarioExistente = _context.Clientes.FirstOrDefault(u => u.Email == email);
            if(usuarioExistente != null)
            {
                ViewBag.Erro = "E-mail já cadastrado.";
                return View("Index");
            }

            byte[] senhaHash = HashService.GerarHashBytes(senha);

            var novoUsuario = new Cliente
            {
                NomeCompleto = nomeCompleto,
                Email = email,
                SenhaHash = senhaHash
            };

            _context.Clientes.Add(novoUsuario);
            _context.SaveChanges();

            HttpContext.Session.SetString("UsuarioNome", novoUsuario.NomeCompleto);
            HttpContext.Session.SetInt32("UsuarioId", novoUsuario.ID_Cliente);

            return RedirectToAction("index", "Home");
        }
      }




    