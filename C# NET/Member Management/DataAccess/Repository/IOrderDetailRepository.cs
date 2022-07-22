using BusinessObject;
using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public interface IOrderDetailRepository
    {
        IEnumerable<OrderDetail> GetOrderDetails();
        IEnumerable<OrderDetail > GetOrderDetailByOrderID(int OrderID);
        OrderDetail  GetODByProductAndOrderID(int productID, int orderID);
        void InsertOrderDetail(OrderDetail  orderDetail);
        void UpdateOrderDetail(OrderDetail  orderDetail);
        void DeleteOrderDetailByOrderID(int OrderID);
        void DeleteODByProductAndOrder(int OrderID,int productID);

    }
}
