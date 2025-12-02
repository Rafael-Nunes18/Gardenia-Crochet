using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("Produto")]
public partial class Produto
{
    [Key]
    public int ID_Produto { get; set; }

    [StringLength(78)]
    [Unicode(false)]
    public string Nome { get; set; } = null!;

    [Column(TypeName = "decimal(10, 2)")]
    public decimal Preco { get; set; }

    public int Estoque { get; set; }

    public int? ID_CategoriaProduto { get; set; }

    [ForeignKey("ID_CategoriaProduto")]
    [InverseProperty("Produtos")]
    public virtual CategoriaProduto? ID_CategoriaProdutoNavigation { get; set; }

    [InverseProperty("ID_ProdutoNavigation")]
    public virtual ICollection<ItensPedido> ItensPedidos { get; set; } = new List<ItensPedido>();
}
