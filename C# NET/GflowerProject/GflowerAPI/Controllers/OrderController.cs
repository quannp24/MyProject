using AutoMapper;
using BusinessObject;
using DataAccess.IRepository;
using DataAccess.Repository;
using GflowerAPI.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Formatter;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;
using Microsoft.EntityFrameworkCore;
using System.Security.Principal;

namespace GflowerAPI.Controllers
{
    [Route("api/[controller]")]
    public class OrderController : ODataController
    {
        private readonly IOrderRepositoy _orderRepository;

        public OrderController(IOrderRepositoy orderRepository, GFlowersContext dbContext)
        {
            _orderRepository = orderRepository;
            dbContext.ChangeTracker.QueryTrackingBehavior = Microsoft.EntityFrameworkCore.QueryTrackingBehavior.NoTracking;
        }

        [Authorize]
        [HttpGet]
        [EnableQuery]
        public async Task<IActionResult> Get()
        {
            var orders = await _orderRepository.GetListOrders();
            return Ok(orders);
        }

        [HttpGet("get-count-orders/{key}")]
        [EnableQuery]
        public async Task<IActionResult> GetCount(int key)
        {
            var orders = await _orderRepository.GetListOrders();
            if (key == 1)
            {
                DateTime today = DateTime.Today;
                var ordersDay = orders.Where(o => o.OrderDate >= today && o.OrderDate < today.AddDays(1))
                .ToList();
                return Ok(ordersDay.Count);
            }
            else
            {
                if (key == 2)
                {
                    DateTime startOfMonth = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                    DateTime endOfMonth = startOfMonth.AddMonths(1);
                    var ordersMonth = orders.Where(o => o.OrderDate >= startOfMonth && o.OrderDate < endOfMonth)
                                .ToList();
                    return Ok(ordersMonth.Count);
                }
                DateTime startOfYear = new DateTime(DateTime.Today.Year, 1, 1);
                DateTime endOfYear = new DateTime(DateTime.Today.Year, 12, 31).AddDays(1);
                var ordersYear = orders.Where(o => o.OrderDate >= startOfYear && o.OrderDate < endOfYear).ToList();
                return Ok(ordersYear.Count);
            }
        }

        [HttpGet("get-total-money/{key}")]
        [EnableQuery]
        public async Task<IActionResult> GetMoney(int key)
        {
            var orders = await _orderRepository.GetListOrders();
            decimal total;
            if (key == 1)
            {
                DateTime today = DateTime.Today;
                var totalAmount = orders.Where(o => o.OrderDate >= today && o.OrderDate < today.AddDays(1))
                                     .Sum(o => o.TotalPrice);
                total = decimal.Parse(totalAmount!=null? totalAmount.ToString() :"0");
                return Ok(total);
            }
            else
            {
                if (key == 2)
                {
                    DateTime startOfMonth = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                    DateTime endOfMonth = startOfMonth.AddMonths(1);
                    var ordersMonth = orders.Where(o => o.OrderDate >= startOfMonth && o.OrderDate < endOfMonth)
                                .Sum(o => o.TotalPrice);
                    total = decimal.Parse(ordersMonth != null ? ordersMonth.ToString() : "0");

                    return Ok(total);
                }
                DateTime startOfYear = new DateTime(DateTime.Today.Year, 1, 1);
                DateTime endOfYear = new DateTime(DateTime.Today.Year, 12, 31).AddDays(1);
                var ordersYear = orders.Where(o => o.OrderDate >= startOfYear && o.OrderDate < endOfYear).Sum(o => o.TotalPrice);
                total = decimal.Parse(ordersYear != null ? ordersYear.ToString() : "0");
                return Ok(total);
            }
        }

        [HttpPost]
        [EnableQuery]
        public async Task<IActionResult> Post([FromBody] CreateOrderRequestDTO order)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            try
            {
                Order raw_order = new Order
                {
                    AccountId = order.AccountId>0? order.AccountId :null,
                    OrderDate = order.OrderDate,
                    OrderStatus = order.OrderStatus,
                    ShippingInfo = order.ShippingInfo,
                    TotalPrice = order.TotalPrice
                };
                Order orderResponse = await _orderRepository.AddOrder(raw_order);
                return Ok(orderResponse);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

        }

        [Authorize]
        [HttpPut]
        [EnableQuery]
        public async Task<IActionResult> Put([FromBody] UpdateStatusOrderDTO orderStatus)
        {
            try
            {
                if (orderStatus.OrderId != 0)
                {
                    await _orderRepository.UpdateStatus(orderStatus.OrderId, orderStatus.StatusOrder);
                }
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
            return Ok();
        }
    }
}
