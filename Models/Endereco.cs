using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("Endereco")]
[Index("Rua", "Numero", "Complemento", "Bairro", "CEP", "Municipio", "Estado", Name = "UQ_Endereco", IsUnique = true)]
public partial class Endereco
{
    [Key]
    public int ID_Endereco { get; set; }

    [StringLength(86)]
    [Unicode(false)]
    public string Rua { get; set; } = null!;

    public int Numero { get; set; }

    [StringLength(20)]
    [Unicode(false)]
    public string? Complemento { get; set; }

    [StringLength(45)]
    [Unicode(false)]
    public string Bairro { get; set; } = null!;

    [StringLength(9)]
    [Unicode(false)]
    public string CEP { get; set; } = null!;

    [StringLength(45)]
    [Unicode(false)]
    public string Municipio { get; set; } = null!;

    [StringLength(2)]
    [Unicode(false)]
    public string Estado { get; set; } = null!;

    [InverseProperty("ID_EnderecoNavigation")]
    public virtual ICollection<Pedido> Pedidos { get; set; } = new List<Pedido>();
}
