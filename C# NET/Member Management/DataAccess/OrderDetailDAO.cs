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
    public class OrderDetailDAO 
    {
        private static OrderDetailDAO instance = null;
        private static readonly object instanceLock = new object();
        private OrderDetailDAO() { }
        public static OrderDetailDAO Instance
        {
            get
            {
                lock (instanceLock)
                {
                    if (instance == null)
                    {
                        instance = new OrderDetailDAO();
                    }
                    return instance;
                }
            }
        }

        public IEnumerable<OrderDetail> GetOrderDetailList()
        {
            var order = new List<OrderDetail>();
            try
            {
                using var context = new FStoreContext();
                order = context.OrderDetails.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return order;
        }

        public IEnumerable<OrderDetail> GetOrderDetailByOrderID(int orderID)
        {
            var order = new List<OrderDetail>();
            try
            {
                using var context = new FStoreContext();
                order = context.OrderDetails.Where(c=>c.OrderId==orderID).Select(c=>c).ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return order;
        }

        public OrderDetail GetODByOrderAndProduct(int orderID, int productID)
        {
            OrderDetail or = null;
            try
            {
                using var context = new FStoreContext();
                or = context.OrderDetails.SingleOrDefault(c => c.OrderId == orderID && c.ProductId==productID);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return or;
        }

        public void AddNew(OrderDetail orderdetail)
        {
            try
            {
                OrderDetail or = GetODByOrderAndProduct(orderdetail.OrderId,orderdetail.ProductId);
                if (or == null)
                {
                    using var context = new FStoreContext();
                    context.OrderDetails.Add(orderdetail);
                    context.SaveChanges();
                }
                else // nếu add trùng thì cập nhật theo cái mới
                {
                    using var context = new FStoreContext();
                    context.OrderDetails.Update(or);
                    context.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Update(OrderDetail od)
        {
            try
            {
                OrderDetail or = GetODByOrderAndProduct(od.OrderId, od.ProductId);
                if (or != null)
                {
                    using var context = new FStoreContext();
                    context.OrderDetails.Update(od);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order detail does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void RemoveByOrderID(int orderID)
        {
            try
            {
                var order = new List<OrderDetail>();
                order = GetOrderDetailByOrderID(orderID).ToList();

                if (order != null)
                {
                    using var context = new FStoreContext();
                    context.OrderDetails.RemoveRange(context.OrderDetails.Where(x=>x.OrderId==orderID));
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order detail does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        public void RemoveByOrderAndProduct(int orderID, int productID)
        {
            try
            {
                OrderDetail od = GetODByOrderAndProduct(orderID, productID);
                if (od != null)
                {
                    using var context = new FStoreContext();
                    context.OrderDetails.RemoveRange(context.OrderDetails.Where(x => x.OrderId == orderID && x.ProductId==productID));
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order detail does not already exist.");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
