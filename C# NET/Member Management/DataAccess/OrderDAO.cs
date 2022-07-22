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
    public class OrderDAO
    {
        private static OrderDAO instance = null;
        private static readonly object instanceLock = new object();
        private OrderDAO() { }
        public static OrderDAO Instance
        {
            get
            {
                lock (instanceLock)
                {
                    if (instance == null)
                    {
                        instance = new OrderDAO();
                    }
                    return instance;
                }
            }
        }

        public IEnumerable<Order> GetOrderList()
        {
            var order = new List<Order>();
            try
            {
                using var context = new FStoreContext();
                order = context.Orders.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return order;
        }

        public Order GetOrderByID(int orderID)
        {
            Order or = null;
            try
            {
                using var context = new FStoreContext();
                or = context.Orders.SingleOrDefault(c => c.OrderId == orderID);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return or;
        }

        public Order GetOrderByMemberID(int memID)
        {
            Order or = null;
            try
            {
                using var context = new FStoreContext();
                or = context.Orders.SingleOrDefault(c => c.MemberId == memID);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return or;
        }

        public void AddNew(Order order)
        {
            try
            {
                Order or = GetOrderByID(order.OrderId);
                if (or == null)
                {
                    using var context = new FStoreContext();
                    context.Orders.Add(order);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order is already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Update(Order order)
        {
            try
            {
                Order or = GetOrderByID(order.OrderId);
                if (or != null)
                {
                    using var context = new FStoreContext();
                    context.Orders.Update(or);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public void Remove(int orderID)
        {
            try
            {
                Order or = GetOrderByID(orderID);
                if (or != null)
                {
                    using var context = new FStoreContext();
                    context.Orders.Remove(or);
                    context.SaveChanges();
                }
                else
                {
                    throw new Exception("The order does not already exist");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
