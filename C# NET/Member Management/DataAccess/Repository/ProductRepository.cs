using BusinessObject;
using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public class ProductRepository : IProductRepository
    {
        public void DeleteProduct(int productID) => ProductDAO.Instance.Remove(productID);

        public Product GetProductByID(int productID) => ProductDAO.Instance.GetProductByID(productID);

        public IEnumerable<Product> GetProductByName(string name) => ProductDAO.Instance.GetProductByName(name);

        public IEnumerable<Product> GetProducts() => ProductDAO.Instance.GetProductList();

        public void InsertProduct(Product product) => ProductDAO.Instance.AddNew(product);

        public void UpdateProduct(Product product) => ProductDAO.Instance.Update(product);
    }
}
