using Gardenia_MVC.Models;
using Microsoft.EntityFrameworkCore;

namespace Gardenia_MVC.Data;

public partial class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<CategoriaProduto> CategoriaProdutos { get; set; }

    public virtual DbSet<Cliente> Clientes { get; set; }

    public virtual DbSet<Endereco> Enderecos { get; set; }

    public virtual DbSet<ItensPedido> ItensPedidos { get; set; }

    public virtual DbSet<Pagamento> Pagamentos { get; set; }

    public virtual DbSet<Pedido> Pedidos { get; set; }

    public virtual DbSet<Produto> Produtos { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<CategoriaProduto>(entity =>
        {
            entity.HasKey(e => e.ID_CategoriaProduto).HasName("PK__Categori__AE749A4877CD7BAD");
        });

        modelBuilder.Entity<Cliente>(entity =>
        {
            entity.HasKey(e => e.ID_Cliente).HasName("PK__Cliente__E005FBFF7C897A80");
        });

        modelBuilder.Entity<Endereco>(entity =>
        {
            entity.HasKey(e => e.ID_Endereco).HasName("PK__Endereco__FDCCCFA61D645972");

            entity.Property(e => e.Estado).IsFixedLength();
        });

        modelBuilder.Entity<ItensPedido>(entity =>
        {
            entity.HasKey(e => e.ID_ItensPedidos).HasName("PK__ItensPed__25333901255D7DA9");

            entity.Property(e => e.Quantidade).HasDefaultValue(1);

            entity.HasOne(d => d.ID_PedidoNavigation).WithMany(p => p.ItensPedidos)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("F_K_ItensPedidos_Pedido");

            entity.HasOne(d => d.ID_ProdutoNavigation).WithMany(p => p.ItensPedidos)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("F_K_ItensPedidos_Produtos");
        });

        modelBuilder.Entity<Pagamento>(entity =>
        {
            entity.HasKey(e => e.ID_Pagamento).HasName("PK__Pagament__B25E7A22CB3E5493");

            entity.Property(e => e.DataHora).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.ID_PedidoNavigation).WithMany(p => p.Pagamentos).HasConstraintName("F_K_Pedido");
        });

        modelBuilder.Entity<Pedido>(entity =>
        {
            entity.HasKey(e => e.ID_Pedido).HasName("PK__Pedido__FD768070737EBC28");

            entity.Property(e => e.DataHoraPedido).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.ID_ClienteNavigation).WithMany(p => p.Pedidos).HasConstraintName("F_K_Cliente");

            entity.HasOne(d => d.ID_EnderecoNavigation).WithMany(p => p.Pedidos).HasConstraintName("F_K_Endereco");
        });

        modelBuilder.Entity<Produto>(entity =>
        {
            entity.HasKey(e => e.ID_Produto).HasName("PK__Produto__525292A115C094BE");

            entity.HasOne(d => d.ID_CategoriaProdutoNavigation).WithMany(p => p.Produtos).HasConstraintName("F_K_CategoriaProduto");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
