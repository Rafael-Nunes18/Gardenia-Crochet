using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("Cliente")]
[Index("Email", Name = "UQ__Cliente__A9D1053495BCFA8F", IsUnique = true)]
public partial class Cliente
{
    [Key]
    public int ID_Cliente { get; set; }

    [StringLength(85)]
    [Unicode(false)]
    public string NomeCompleto { get; set; } = null!;

    [StringLength(200)]
    [Unicode(false)]
    public string Email { get; set; } = null!;

    [StringLength(32)]
    [Unicode(false)]
    public string Senha { get; set; } = null!;

    [StringLength(14)]
    [Unicode(false)]
    public string? Telefone { get; set; }

    [InverseProperty("ID_ClienteNavigation")]
    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
