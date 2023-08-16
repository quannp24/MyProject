using BusinessObject;

namespace DataAccess.IRepository
{
    public interface ICartRepository
    {
        Task<List<Cart>> GetListCart(int accID);
        Task<List<Cart>> GetCarts();
        Task<Cart> GetCartByProduct(int productId, int accountId);
        Task<Cart> GetCartById(int Id);
        Task DeleteCart(int carId);
        Task<bool> AddProductToCart(Cart cart);
        Task UpdateQuantity(Cart cart, bool IsPlus);

        Task DeleteAll(List<Cart> carts);


    }
}
