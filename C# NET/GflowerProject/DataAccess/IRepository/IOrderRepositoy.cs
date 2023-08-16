using BusinessObject;

namespace DataAccess.IRepository
{
    public interface IOrderRepositoy
    {
        Task<Order> AddOrder(Order order);

        Task<List<Order>> GetOrders(int accId);
        Task<List<Order>> GetListOrders();
        Task<Order> GetOrderById(int orderId);
        Task<List<Order>> GetOrdersUsers();
        Task<List<Order>> GetOrdersUnknown();

        Task UpdateStatus(int orderId,int status);
    }
}
