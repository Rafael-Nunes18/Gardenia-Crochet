using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

public partial class ItensPedido
{
    [Key]
    public int ID_ItensPedidos { get; set; }

    public int ID_Pedido { get; set; }

    public int ID_Produto { get; set; }

    public int Quantidade { get; set; }

    [Column(TypeName = "decimal(10, 2)")]
    public decimal PrecoUnitario { get; set; }

    [ForeignKey("ID_Pedido")]
    [InverseProperty("ItensPedidos")]
    public virtual Pedido ID_PedidoNavigation { get; set; } = null!;

    [ForeignKey("ID_Produto")]
    [InverseProperty("ItensPedidos")]
    public virtual Produto ID_ProdutoNavigation { get; set; } = null!;
}
