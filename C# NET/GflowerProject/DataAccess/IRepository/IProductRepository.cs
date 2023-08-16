using BusinessObject;

namespace DataAccess.IRepository
{
    public interface IProductRepository
    {
        Task<List<Product>> GetProducts();
        Task<List<Product>> GetProductsAdmin();
        Task<Product> GetProduct(int productId);
        Task<Product> GetProductBestSale();

        Task<Product> AddProduct(Product product);
        Task UpdateProduct(Product product);
        Task RemoveProduct(int Id);

    }
}
