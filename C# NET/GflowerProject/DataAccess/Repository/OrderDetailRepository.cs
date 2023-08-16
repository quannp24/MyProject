using BusinessObject;
using DataAccess.DAO;
using DataAccess.IRepository;

namespace DataAccess.Repository
{
    public class OrderDetailRepository : IOrderDetailRepository
    {
        public Task AddListOrder(List<OrderDetail> orders) => OrderDetailManagement.Instance.AddListOrder(orders);
    }
}
