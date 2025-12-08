using System.Security.Cryptography;
using System.Text;

namespace Gardenia_MVC.Services
{
    public static class HashService
    {
        public static byte[] GerarHashBytes(string senha)
        {
            return SHA256.HashData(Encoding.UTF8.GetBytes(senha));
        }
    }
}