using BusinessObject;
using DataAccess.DAO;
using DataAccess.IRepository;

namespace DataAccess.Repository
{
    public class OrderRepository : IOrderRepositoy
    {
        public Task<Order> AddOrder(Order order)=>OrderManagement.Instance.AddNew(order);

        public Task<List<Order>> GetListOrders() =>OrderManagement.Instance.GetOrders();


        public Task<Order> GetOrderById(int orderId) =>OrderManagement.Instance.GetOrderByID(orderId);

        public Task<List<Order>> GetOrders(int accId) => OrderManagement.Instance.GetOrdersByAccId(accId);

        public Task<List<Order>> GetOrdersUnknown() =>OrderManagement.Instance.GetOrdersUnknown();

        public Task<List<Order>> GetOrdersUsers() => OrderManagement.Instance.GetOrdersUsers();

        public Task UpdateStatus(int orderId, int status)=>OrderManagement.Instance.UpdateStatus(orderId, status);
    }
}
