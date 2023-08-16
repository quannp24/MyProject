using BusinessObject;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.DAO
{
    public class ProductManagement
    {
        private static ProductManagement instance = null;
        private static readonly object instanceLock = new object();
        private ProductManagement() { }
        public static ProductManagement Instance
        {
            get
            {
                lock (instanceLock)
                {
                    if (instance == null)
                    {
                        instance = new ProductManagement();
                    }
                    return instance;
                }
            }
        }

        public async Task<Product> GetProductBestSale()
        {
            try
            {
                var flowerDB = new GFlowersContext();
                DateTime startOfMonth = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                DateTime endOfMonth = startOfMonth.AddMonths(1);
                var productOccurrences = await flowerDB.OrderDetails.Where(od => od.Product.Status != 0 &&  od.Order.OrderDate >= startOfMonth && od.Order.OrderDate < endOfMonth)
                    .GroupBy(od => od.ProductId)
                    .Select(group => new {
                    ProductId = group.Key,
                    Frequency = group.Count()
                }).ToListAsync();

                // Find the product with the highest frequency greater than minimumFrequency
                var mostFrequentProduct = productOccurrences
                    .Where(po => po.Frequency > 0 )
                    .OrderByDescending(po => po.Frequency)
                    .FirstOrDefault();

                if (mostFrequentProduct != null)
                {
                    int mostFrequentProductId = mostFrequentProduct.ProductId;
                    // Query and return the product with the most frequent ProductId
                    var product = await flowerDB.Products.FirstOrDefaultAsync(p => p.ProductId == mostFrequentProductId);
                    return product;
                }
                return null;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<List<Product>> GetListProducts()
        {
            List<Product> products = new List<Product>();
            try
            {
                var flowerDB = new GFlowersContext();
                products = await flowerDB.Products.ToListAsync();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return products;
        }

        public async Task<List<Product>> GetListProductsAdmin()
        {
            List<Product> products = new List<Product>();
            try
            {
                var flowerDB = new GFlowersContext();
                products = await flowerDB.Products.Where(p=>p.Status != 3).ToListAsync();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return products;
        }

        public async Task<Product> GetProductByID(int proId)
        {
            Product pro = null;
            try
            {
                var flowerDB = new GFlowersContext();
                pro = await flowerDB.Products.FirstOrDefaultAsync(p => p.ProductId == proId);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return pro;
        }

        public async Task<Product> AddNew(Product product)
        {
            try
            {
                var flowerDB = new GFlowersContext();
                var productLast = await flowerDB.Products.OrderByDescending(p=>p.ProductId).FirstOrDefaultAsync();
                if (product != null && productLast !=null)
                {
                    string img = "bou"+(productLast.ProductId + 1)+product.ProductImage;
                    product.ProductImage = img;
                    await flowerDB.Products.AddAsync(product);
                    await flowerDB.SaveChangesAsync();
                }
                else
                {
                    throw new Exception("The product is null.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return product;
        }

        public async Task Update(Product _product)
        {
            try
            {
                var flowerDB = new GFlowersContext();
                var product = await flowerDB.Products.FindAsync(_product.ProductId);
                if (product != null)
                {
                    product.ProductName=_product.ProductName;
                    product.ProductDescription=_product.ProductDescription;
                    product.ProductPrice=_product.ProductPrice;
                    product.Status=_product.Status;
                    product.Discount=_product.Discount;
                    if(_product.ProductImage!=null)
                        product.ProductImage = _product.ProductImage;
                    else
                        flowerDB.Entry(product).Property(p => p.ProductImage).IsModified = false;
                    await flowerDB.SaveChangesAsync();
                }
                else
                {
                    throw new Exception("The product not exists.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task RemoveProduct(int id)
        {
            try
            {
                var flowerDB = new GFlowersContext();
                var product = await flowerDB.Products.FindAsync(id);
                if (product != null)
                {
                    product.Status = 3;
                    await flowerDB.SaveChangesAsync();
                }
                else
                {
                    throw new Exception("The product not exists.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

    }
}
