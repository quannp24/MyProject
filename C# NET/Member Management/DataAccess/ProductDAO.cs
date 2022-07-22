using BusinessObject;
using BusinessObject.Models;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class ProductDAO 
    {
        private static ProductDAO instance = null;
        private static readonly object instanceLock = new object();
        private ProductDAO() { }
        public static ProductDAO Instance
        {
            get
            {
                lock (instanceLock)
                {
                    if (instance == null)
                    {
                        instance = new ProductDAO();
                    }
                    return instance;
                }
            }
        }

        public IEnumerable<Product> GetProductList()
        {
            var product = new List<Product>();
            try
            {
                using var context = new FStoreContext();
                product = context.Products.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return product;
        }

        public Product GetProductByID(int productID)
        {
            Product pro = null;
            try
            {
                using var context = new FStoreContext();
                pro = context.Products.SingleOrDefault(c => c.ProductId == productID);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return pro;
        }

        public IEnumerable<Product> GetProductByName(string nameproduct)
        {
            var products = new List<Product>();
            try
            {
                using var context = new FStoreContext();
                products = context.Products.Where(c => c.ProductName.Contains(nameproduct)).Select(c => c).ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return products;
        }

        public void AddNew(Product pro)
        {
            try
            {
                Product product = GetProductByID(pro.ProductId);
                if (product == null)
                {
                    using var context = new FStoreContext();
                    context.Products.Add(pro);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The product is already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Update(Product pro)
        {
            try
            {
                Product product = GetProductByID(pro.ProductId);
                if (product != null)
                {
                    using var context = new FStoreContext();
                    context.Products.Update(pro);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The product does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Remove(int productID)
        {
            try
            {
                Product pro = GetProductByID(productID);
                if (pro != null)
                {
                    using var context = new FStoreContext();
                    context.Products.Remove(pro);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The product does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
