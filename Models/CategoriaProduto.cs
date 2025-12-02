using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("CategoriaProduto")]
public partial class CategoriaProduto
{
    [Key]
    public int ID_CategoriaProduto { get; set; }

    [StringLength(56)]
    [Unicode(false)]
    public string NomeCategoria { get; set; } = null!;

    [InverseProperty("ID_CategoriaProdutoNavigation")]
    public virtual ICollection<Produto> Produtos { get; set; } = new List<Produto>();
}
