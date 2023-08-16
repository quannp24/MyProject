using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using Gflower.Services;
using System.Text;
using Gflower.DTO;

namespace Gflower.Pages
{
    public class PaymentResultModel : PageModel
    {

        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string CartAPI = "http://localhost:5025/odata/Cart";
        private readonly string CartforAPI = "http://localhost:5025/api/Cart";
        private readonly string OrderAPI = "http://localhost:5025/odata/Order";
        private readonly string OrderDetailAPI = "http://localhost:5025/odata/OrderDetail";
        private readonly SessionHelper _sessionHelper;
        private IMomoService _momoService;
        private readonly IVnPayService _vnPayService;


        public Account account { get; set; }

        public List<Cart> carts { get; set; }
        public bool IsSuccess { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public PaymentResultModel(SessionHelper sessionHelper, IMomoService momoService, IVnPayService vnPayService)
        {
            _client = new HttpClient();
            _sessionHelper = sessionHelper;
            _momoService = momoService;
            _vnPayService = vnPayService;
        }

        private async Task<bool> CheckLogin()
        {
            var token = _sessionHelper.GetSessionData<string>("token");
            var username = _sessionHelper.GetSessionData<string>("username");
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(token))
            {
                //truong hop token o session het han thi check o cookie
                var tokenClaim = User.Claims.FirstOrDefault(c => c.Type == "Token");
                Username = User.Identity.Name;
                if (tokenClaim != null) //token o cookie co thi luu lai len session
                {
                    token = tokenClaim.Value;
                    Token = token;
                    _sessionHelper.SaveSessionData("token", token);
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else // session con luu token va uername tra ve tru
            {
                Username = username;
                Token = token;
                return true;
            }
        }

        private async Task SetUpHttpClient(string token)
        {
            _client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            _client.DefaultRequestHeaders.Accept.Add(contentType);
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

        }

        private async Task SetUpAccount()
        {
            var response = await _client.GetAsync($"{AccountAPI}/{Username}");
            string strData = await response.Content.ReadAsStringAsync();

            var authenticationResponse = JsonConvert.DeserializeObject<Account>(strData);
            if (authenticationResponse != null)
                account = authenticationResponse;
        }

        private async Task SetUpCart()
        {
            List<Cart> items = new();

            var respone = await _client.GetAsync($"{CartAPI}?$expand=Product&$filter=AccountID eq {account.AccountId}");
            string strData = await respone.Content.ReadAsStringAsync();

            var temp = JObject.Parse(strData);
            var productExist = (JArray)temp["value"];
            var cartList = JsonConvert.DeserializeObject<List<Cart>>(productExist.ToString());
            carts = cartList;
        }


        public async Task<IActionResult> OnGetPaymentMomo()
        {
            var responsePayment = _momoService.PaymentExecuteAsync(HttpContext.Request.Query);
            var session = HttpContext.Session;

            if (await CheckLogin())
            {
                await SetUpHttpClient(Token);
                await SetUpAccount();
            }
            //get cart in session
            var sessionCartItems = _sessionHelper.GetSessionData<List<Cart>>("cart");
            if (sessionCartItems != null)
            {
                carts = sessionCartItems;
            }
            else
            {
                if (account != null)
                    await SetUpCart();
            }
            if (responsePayment.errorCode == "0")
            {
                var shipInfo = _sessionHelper.GetSessionData<string>("infor-payment");
                var total = _sessionHelper.GetSessionData<double>("totalPrice");
                session.Remove("infor-payment");
                session.Remove("totalPrice");
                decimal totalPrice = Convert.ToDecimal(total);
                List<OrderDetailRequestDTO> orderDetail = new List<OrderDetailRequestDTO>();
                if (account != null) //da dang nhap
                {
                    if (carts != null)
                    {
                        try
                        {
                            CreateOrderRequestDTO order = new CreateOrderRequestDTO
                            {
                                AccountId = account.AccountId,
                                OrderDate = DateTime.Now,
                                OrderStatus = 1,
                                ShippingInfo = shipInfo.ToString(),
                                TotalPrice = totalPrice
                            };
                            //tao order moi
                            string content = System.Text.Json.JsonSerializer.Serialize(order);
                            var data = new StringContent(content, Encoding.UTF8, "application/json");
                            var response = await _client.PostAsync($"{OrderAPI}", data);
                            string strData = await response.Content.ReadAsStringAsync();
                            if (!response.IsSuccessStatusCode)
                            {
                                IsSuccess = false;
                                return Page();
                            }
                            else
                            {
                                var orderResponse = JsonConvert.DeserializeObject<Order>(strData);
                                if (orderResponse != null)
                                {
                                    //tao 1 list order detail de add
                                    foreach (var item in carts)
                                    {
                                        OrderDetailRequestDTO od = new OrderDetailRequestDTO
                                        {
                                            OrderId = orderResponse.OrderId,
                                            ProductId = item.ProductId,
                                            Quantity = item.Quantity,
                                            Price = item.TotalPrice
                                        };
                                        orderDetail.Add(od);
                                    }
                                    //add list order detail voi
                                    string contentOD = System.Text.Json.JsonSerializer.Serialize(orderDetail);
                                    var dataOD = new StringContent(contentOD, Encoding.UTF8, "application/json");
                                    var responseOD = await _client.PostAsync($"{OrderDetailAPI}", dataOD);
                                    if (!response.IsSuccessStatusCode)
                                    {
                                        IsSuccess = false;
                                        return Page();
                                    }
                                    else
                                    {
                                        string contentCart = System.Text.Json.JsonSerializer.Serialize(carts);
                                        var dataCart = new StringContent(contentCart, Encoding.UTF8, "application/json");
                                        var responseCart = await _client.PostAsync($"{CartforAPI}/delete-all-cart", dataCart);
                                        if (!response.IsSuccessStatusCode)
                                        {
                                            IsSuccess = false;
                                            return Page();
                                        }
                                        else
                                        {
                                            IsSuccess = true;
                                            return Page();
                                        }
                                    }
                                }
                                else
                                {
                                    IsSuccess = false;
                                    return Page();
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            throw new Exception("Create order error.");
                        }
                    }
                    else
                    {
                        IsSuccess = false;
                        return Page();

                    }

                }
                else //chua dang nhap
                {
                    if (carts != null) // neu cart co san pham
                    {
                        CreateOrderRequestDTO order = new CreateOrderRequestDTO
                        {
                            OrderDate = DateTime.Now,
                            OrderStatus = 1,
                            ShippingInfo = shipInfo.ToString(),
                            TotalPrice = totalPrice
                        };
                        //tao order moi
                        string content = System.Text.Json.JsonSerializer.Serialize(order);
                        var data = new StringContent(content, Encoding.UTF8, "application/json");
                        var response = await _client.PostAsync($"{OrderAPI}", data);
                        string strData = await response.Content.ReadAsStringAsync();
                        if (!response.IsSuccessStatusCode)
                        {
                            IsSuccess = false;
                            return Page();
                        }
                        else
                        {
                            var orderResponse = JsonConvert.DeserializeObject<Order>(strData);
                            if (orderResponse != null)
                            {
                                //tao 1 list order detail de add
                                foreach (var item in carts)
                                {
                                    OrderDetailRequestDTO od = new OrderDetailRequestDTO
                                    {
                                        OrderId = orderResponse.OrderId,
                                        ProductId = item.ProductId,
                                        Quantity = item.Quantity,
                                        Price = item.TotalPrice
                                    };
                                    orderDetail.Add(od);
                                }
                                //add list order detail voi
                                string contentOD = System.Text.Json.JsonSerializer.Serialize(orderDetail);
                                var dataOD = new StringContent(contentOD, Encoding.UTF8, "application/json");
                                var responseOD = await _client.PostAsync($"{OrderDetailAPI}", dataOD);
                                if (!response.IsSuccessStatusCode)
                                {
                                    IsSuccess = false;
                                    return Page();
                                }
                                else
                                {
                                    session.Remove("cart");
                                    IsSuccess = true;
                                    return Page();
                                }
                            }
                            else
                            {
                                IsSuccess = false;
                                return Page();
                            }
                        }

                    } // cart chua co san pham, in ra loi
                    else
                    {
                        IsSuccess = false;
                        return Page();
                    }
                }
            }
            else
            {
                IsSuccess = false;
                return Page();
            }
        }

        public async Task<IActionResult> OnGetPaymentVNPay()
        {
            var session = HttpContext.Session;

            var responsePayment = _vnPayService.PaymentExecute(Request.Query);

            if (await CheckLogin())
            {
                await SetUpHttpClient(Token);
                await SetUpAccount();
            }
            //get cart in session
            var sessionCartItems = _sessionHelper.GetSessionData<List<Cart>>("cart");
            if (sessionCartItems != null)
            {
                carts = sessionCartItems;
            }
            else
            {
                if (account != null)
                    await SetUpCart();
            }

            if (responsePayment.Success)
            {
                if(responsePayment.VnPayResponseCode == "00")
                {
                    var shipInfo = _sessionHelper.GetSessionData<string>("infor-payment");
                    var total = _sessionHelper.GetSessionData<double>("totalPrice");
                    session.Remove("infor-payment");
                    session.Remove("totalPrice");
                    decimal totalPrice = Convert.ToDecimal(total);
                    List<OrderDetailRequestDTO> orderDetail = new List<OrderDetailRequestDTO>();
                    if (account != null) //da dang nhap
                    {
                        if (carts != null)
                        {
                            try
                            {
                                CreateOrderRequestDTO order = new CreateOrderRequestDTO
                                {
                                    AccountId = account.AccountId,
                                    OrderDate = DateTime.Now,
                                    OrderStatus = 1,
                                    ShippingInfo = shipInfo.ToString(),
                                    TotalPrice = totalPrice
                                };
                                //tao order moi
                                string content = System.Text.Json.JsonSerializer.Serialize(order);
                                var data = new StringContent(content, Encoding.UTF8, "application/json");
                                var response = await _client.PostAsync($"{OrderAPI}", data);
                                string strData = await response.Content.ReadAsStringAsync();
                                if (!response.IsSuccessStatusCode)
                                {
                                    IsSuccess= false;
                                    return Page();
                                }
                                else
                                {
                                    var orderResponse = JsonConvert.DeserializeObject<Order>(strData);
                                    if (orderResponse != null)
                                    {
                                        //tao 1 list order detail de add
                                        foreach (var item in carts)
                                        {
                                            OrderDetailRequestDTO od = new OrderDetailRequestDTO
                                            {
                                                OrderId = orderResponse.OrderId,
                                                ProductId = item.ProductId,
                                                Quantity = item.Quantity,
                                                Price = item.TotalPrice
                                            };
                                            orderDetail.Add(od);
                                        }
                                        //add list order detail voi
                                        string contentOD = System.Text.Json.JsonSerializer.Serialize(orderDetail);
                                        var dataOD = new StringContent(contentOD, Encoding.UTF8, "application/json");
                                        var responseOD = await _client.PostAsync($"{OrderDetailAPI}", dataOD);
                                        if (!response.IsSuccessStatusCode)
                                        {
                                            IsSuccess = false;
                                            return Page();
                                        }
                                        else
                                        {
                                            string contentCart = System.Text.Json.JsonSerializer.Serialize(carts);
                                            var dataCart = new StringContent(contentCart, Encoding.UTF8, "application/json");
                                            var responseCart = await _client.PostAsync($"{CartforAPI}/delete-all-cart", dataCart);
                                            if (!response.IsSuccessStatusCode)
                                            {
                                                IsSuccess = false;
                                                return Page();
                                            }
                                            else
                                            {
                                                IsSuccess = true;
                                                return Page();
                                            }
                                        }
                                    }
                                    else
                                    {
                                        IsSuccess = false;
                                        return Page();
                                    }
                                }
                                
                            }
                            catch (Exception ex)
                            {
                                throw new Exception("Create order error.");
                            }
                        }
                        else
                        {
                            IsSuccess = false;
                            return Page();

                        }

                    }
                    else //chua dang nhap
                    {
                        if (carts != null) // neu cart co san pham
                        {
                            CreateOrderRequestDTO order = new CreateOrderRequestDTO
                            {
                                OrderDate = DateTime.Now,
                                OrderStatus = 1,
                                ShippingInfo = shipInfo.ToString(),
                                TotalPrice = totalPrice
                            };
                            //tao order moi
                            string content = System.Text.Json.JsonSerializer.Serialize(order);
                            var data = new StringContent(content, Encoding.UTF8, "application/json");
                            var response = await _client.PostAsync($"{OrderAPI}", data);
                            string strData = await response.Content.ReadAsStringAsync();
                            if (!response.IsSuccessStatusCode)
                            {
                                IsSuccess = false;
                                return Page();
                            }
                            else
                            {
                                var orderResponse = JsonConvert.DeserializeObject<Order>(strData);
                                if (orderResponse != null)
                                {
                                    //tao 1 list order detail de add
                                    foreach (var item in carts)
                                    {
                                        OrderDetailRequestDTO od = new OrderDetailRequestDTO
                                        {
                                            OrderId = orderResponse.OrderId,
                                            ProductId = item.ProductId,
                                            Quantity = item.Quantity,
                                            Price = item.TotalPrice
                                        };
                                        orderDetail.Add(od);
                                    }
                                    //add list order detail voi
                                    string contentOD = System.Text.Json.JsonSerializer.Serialize(orderDetail);
                                    var dataOD = new StringContent(contentOD, Encoding.UTF8, "application/json");
                                    var responseOD = await _client.PostAsync($"{OrderDetailAPI}", dataOD);
                                    if (!response.IsSuccessStatusCode)
                                    {
                                        IsSuccess = false;
                                        return Page();
                                    }
                                    else
                                    {
                                        session.Remove("cart");
                                        IsSuccess = true;
                                        return Page();
                                    }
                                }
                                else
                                {
                                    IsSuccess = false;
                                    return Page();
                                }
                            }

                        } // cart chua co san pham, in ra loi
                        else
                        {
                            IsSuccess = false;
                            return Page();
                        }
                    }

                }
                else
                {
                    IsSuccess = false;
                    return Page();
                }
            }
            else
            {
                IsSuccess = false;
                return Page();
            }

        }


    }
}
