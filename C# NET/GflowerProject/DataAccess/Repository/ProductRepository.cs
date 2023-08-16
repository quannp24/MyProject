using BusinessObject;
using DataAccess.DAO;
using DataAccess.IRepository;

namespace DataAccess.Repository
{
    public class ProductRepository : IProductRepository
    {
        public Task<Product> AddProduct(Product product) =>ProductManagement.Instance.AddNew(product);

        public Task<Product> GetProduct(int productId) =>ProductManagement.Instance.GetProductByID(productId);
        public Task<Product> GetProductBestSale() =>ProductManagement.Instance.GetProductBestSale();

        public Task<List<Product>> GetProducts() => ProductManagement.Instance.GetListProducts();

        public Task<List<Product>> GetProductsAdmin()=>ProductManagement.Instance.GetListProductsAdmin();

        public Task RemoveProduct(int Id) => ProductManagement.Instance.RemoveProduct(Id);

        public Task UpdateProduct(Product product) =>ProductManagement.Instance.Update(product);
    }
}
