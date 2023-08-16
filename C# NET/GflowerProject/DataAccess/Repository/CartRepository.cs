using BusinessObject;
using DataAccess.DAO;
using DataAccess.IRepository;


namespace DataAccess.Repository
{
    public class CartRepository : ICartRepository
    {
        public Task<bool> AddProductToCart(Cart cart) => CartManagement.Instance.Update(cart);

        public Task DeleteAll(List<Cart> carts) => CartManagement.Instance.DeleteAllCart(carts);

        public Task DeleteCart(int carId) => CartManagement.Instance.Delete(carId);

        public Task<Cart> GetCartById(int Id) => CartManagement.Instance.FindCartById(Id);

        public Task<Cart> GetCartByProduct(int productId, int accountId) => 
            CartManagement.Instance.GetCartByProID(productId, accountId);

        public Task<List<Cart>> GetCarts() => CartManagement.Instance.GetCarts();

        public Task<List<Cart>> GetListCart(int accID) => CartManagement.Instance.GetCartsByAccID(accID);

        public Task UpdateQuantity(Cart cart, bool IsPlus) => CartManagement.Instance.UpdateQuantity(cart, IsPlus);
    }
}
