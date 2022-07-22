using BusinessObject.Models;
using DataAccess.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace eStore.Controllers
{
    public class eStoreController : Controller
    {
        IMemberRepository memRepository = null;
        IProductRepository proRepository = null;
        IOrderRepository orderRepository = null;
        IOrderDetailRepository odRepository = null;
        public eStoreController()
        {
            memRepository = new MemberRepository();
            proRepository = new ProductRepository();
            orderRepository = new OrderRepository();
            odRepository = new OrderDetailRepository();
        }
        public ActionResult login()
        {

            return View("login");
        }

        public ActionResult member()
        {
            var memList = memRepository.GetMembers();
            return View(memList);
        }
        public ActionResult product()
        {
            var proList = proRepository.GetProducts();
            return View(proList);
        }

        public ActionResult order()
        {
            var orList = orderRepository.GetOrders();
            return View(orList);
        }

        public ActionResult logout()
        {
            string a = HttpContext.Session.GetString("accountAdmin");
            HttpContext.Session.Remove("accountAdmin");
            HttpContext.Session.Remove("accountMember");
            
            return View("login");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login(string email, string pass)
        {
            Admin admin = ReadAccountAdmin();

            try
            {
                Member mem = memRepository.GetMemberByAccount(email, pass);
                if (email == admin.Email && pass == admin.Password)
                {
                    HttpContext.Session.SetString("accountAdmin", JsonConvert.SerializeObject(admin));
                    return RedirectToAction(nameof(member));
                }
                else
                {
                    if (mem != null)
                    {
                        HttpContext.Session.SetString("accountMember", JsonConvert.SerializeObject(admin));
                        return RedirectToAction(nameof(member));
                    }
                    else
                    {
                        ViewData["mess"] = "Password and email wrong.";
                        return View();
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.Message = ex.Message;
                return View();
            }

        }

        public Admin ReadAccountAdmin()  //đọc admin account từ json
        {
            string email;
            string password;
            IConfiguration config = new ConfigurationBuilder().
                SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true).Build();
            email = config["AdminAccount:Email"];
            password = config["AdminAccount:Password"];

            Admin admin = new Admin
            {
                Email = email,
                Password = password
            };
            return admin;
        }

        public class Admin
        {
            public string Email { get; set; }
            public string Password { get; set; }
        }

    }
}
