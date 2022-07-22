using BusinessObject;
using BusinessObject.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Repository
{
    public class OrderDetailRepository : IOrderDetailRepository
    {
        public void DeleteODByProductAndOrder(int OrderID, int productID) => OrderDetailDAO.Instance.RemoveByOrderAndProduct(OrderID, productID);

        public void DeleteOrderDetailByOrderID(int OrderID) => OrderDetailDAO.Instance.RemoveByOrderID(OrderID);

        public OrderDetail GetODByProductAndOrderID(int productID, int orderID) => OrderDetailDAO.Instance.GetODByOrderAndProduct(productID, orderID);

        public IEnumerable<OrderDetail> GetOrderDetailByOrderID(int OrderID) => OrderDetailDAO.Instance.GetOrderDetailByOrderID(OrderID);

        public IEnumerable<OrderDetail> GetOrderDetails() => OrderDetailDAO.Instance.GetOrderDetailList();

        public void InsertOrderDetail(OrderDetail orderDetail) => OrderDetailDAO.Instance.AddNew(orderDetail);

        public void UpdateOrderDetail(OrderDetail orderDetail) => OrderDetailDAO.Instance.Update(orderDetail);
    }
}
