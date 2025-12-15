using System.Security.Cryptography;
using System.Text;

namespace Gardenia_MVC.Services
{
    public static class HashService
    {
        public static string GerarHash(string senha)
        {
            using var sha256 = SHA256.Create();
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(senha));
            return Convert.ToBase64String(hashBytes);
        }
    }
}