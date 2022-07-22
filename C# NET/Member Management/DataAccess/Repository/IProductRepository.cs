using BusinessObject;
using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public interface IProductRepository
    {
        IEnumerable<Product > GetProducts();
        IEnumerable<Product > GetProductByName(string name);
        Product  GetProductByID(int productID);
        void InsertProduct(Product  product);
        void UpdateProduct(Product  product);
        void DeleteProduct(int productID);
    }
}
