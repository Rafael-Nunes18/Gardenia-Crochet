using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("Pedido")]
public partial class Pedido
{
    [Key]
    public int ID_Pedido { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime DataHoraPedido { get; set; }

    [StringLength(25)]
    [Unicode(false)]
    public string StatusPedido { get; set; } = null!;

    public int? ID_Cliente { get; set; }

    public int? ID_Endereco { get; set; }

    [ForeignKey("ID_Cliente")]
    [InverseProperty("Pedidos")]
    public virtual Cliente? ID_ClienteNavigation { get; set; }

    [ForeignKey("ID_Endereco")]
    [InverseProperty("Pedidos")]
    public virtual Endereco? ID_EnderecoNavigation { get; set; }

    [InverseProperty("ID_PedidoNavigation")]
    public virtual ICollection<ItensPedido> ItensPedidos { get; set; } = new List<ItensPedido>();

    [InverseProperty("ID_PedidoNavigation")]
    public virtual ICollection<Pagamento> Pagamentos { get; set; } = new List<Pagamento>();
}
