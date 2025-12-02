using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Models;

[Table("Pagamento")]
public partial class Pagamento
{
    [Key]
    public int ID_Pagamento { get; set; }

    [StringLength(14)]
    [Unicode(false)]
    public string CPF { get; set; } = null!;

    [StringLength(25)]
    [Unicode(false)]
    public string FormaPagamento { get; set; } = null!;

    [Column(TypeName = "decimal(10, 2)")]
    public decimal ValorGasto { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? DataHora { get; set; }

    public int? ID_Pedido { get; set; }

    [ForeignKey("ID_Pedido")]
    [InverseProperty("Pagamentos")]
    public virtual Pedido? ID_PedidoNavigation { get; set; }
}
