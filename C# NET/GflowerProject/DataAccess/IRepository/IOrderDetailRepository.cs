using BusinessObject;

namespace DataAccess.IRepository
{
    public interface IOrderDetailRepository
    {
        Task AddListOrder(List<OrderDetail> orders);
    }
}
