using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using Gflower.DTO;
using System.Text;

namespace Gflower.Pages
{
    public class CartModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string CartAPI = "http://localhost:5025/odata/Cart";
        private readonly string CartforAPI = "http://localhost:5025/api/Cart";
        private readonly string productAPI = "http://localhost:5025/odata/Product";
        private readonly SessionHelper _sessionHelper;

        public Account account { get; set; }

        public List<Cart> carts { get; set; }
        public List<Product> products { get; set; }
        private string Token { get; set; }
        private string Username { get; set; }

        public CartModel(SessionHelper sessionHelper)
        {
            
            _sessionHelper = sessionHelper;
            _client = new HttpClient();
        }
        public async Task<IActionResult> OnGetAsync()
        {
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
            return Page();
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

        public async Task<IActionResult> OnGetPlusQuantity(int productId)
        {
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


            if (account != null) //da dang nhap
            {
                if (carts != null)
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        CartUpdateQuantityDTO raw_cart = new CartUpdateQuantityDTO
                        {
                            IsPlus = true,
                            CartUpdate = cartItem
                        };
                        string content = System.Text.Json.JsonSerializer.Serialize(raw_cart);
                        var data = new StringContent(content, Encoding.UTF8, "application/json");
                        var response = await _client.PutAsync($"{CartforAPI}", data);
                        string strData = await response.Content.ReadAsStringAsync();
                        if (!response.IsSuccessStatusCode)
                        {
                            return new JsonResult(new { success = false });
                        }
                        return new JsonResult(new { success = true });
                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }

                }
                else
                {
                    return new JsonResult(new { success = false });
                }

            }
            else //chua dang nhap
            {
                if (carts != null) // neu cart co san pham
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        cartItem.Quantity += 1;
                        cartItem.TotalPrice += cartItem.Product.ProductPrice;
                        //set lai list cart session
                        _sessionHelper.SaveSessionData("cart", carts);

                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }
                    return new JsonResult(new { success = true });

                } // cart chua co san pham, in ra loi
                else
                {
                    return new JsonResult(new { success = false });
                }
            }
        }

        public async Task<IActionResult> OnGetRemoveCart(int productId)
        {
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


            if (account != null) //da dang nhap
            {
                if (carts != null)
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        var response = await _client.DeleteAsync($"{CartAPI}/{cartItem.CartId}");

                        if (!response.IsSuccessStatusCode)
                        {
                            return new JsonResult(new { success = false });
                        }
                        return new JsonResult(new { success = true });
                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }
                }
                else
                {
                    return new JsonResult(new { success = false });
                }

            }
            else //chua dang nhap
            {
                if (carts != null) // neu cart co san pham
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        carts.Remove(cartItem);
                        //set lai list cart session
                        _sessionHelper.SaveSessionData("cart", carts);

                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }
                    return new JsonResult(new { success = true });

                } // cart chua co san pham, in ra loi
                else
                {
                    return new JsonResult(new { success = false });
                }
            }
        }

        public async Task<IActionResult> OnGetMinusQuantity(int productId)
        {
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


            if (account != null) //da dang nhap
            {
                if (carts != null)
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        CartUpdateQuantityDTO raw_cart = new CartUpdateQuantityDTO
                        {
                            IsPlus = false,
                            CartUpdate = cartItem
                        };
                        string content = System.Text.Json.JsonSerializer.Serialize(raw_cart);
                        var data = new StringContent(content, Encoding.UTF8, "application/json");
                        var response = await _client.PutAsync($"{CartforAPI}", data);
                        string strData = await response.Content.ReadAsStringAsync();
                        if (!response.IsSuccessStatusCode)
                        {
                            return new JsonResult(new { success = false });
                        }
                        return new JsonResult(new { success = true });
                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }

                }
                else
                {
                    return new JsonResult(new { success = false });
                }

            }
            else //chua dang nhap
            {
                if (carts != null) // neu cart co san pham
                {
                    var cartItem = carts.FirstOrDefault(ci => ci.ProductId == productId);
                    if (cartItem != null)
                    {
                        cartItem.Quantity -= 1;
                        cartItem.TotalPrice -= cartItem.Product.ProductPrice;
                        //set lai list cart session
                        _sessionHelper.SaveSessionData("cart", carts);

                    }
                    else
                    {
                        return new JsonResult(new { success = false });
                    }
                    return new JsonResult(new { success = true });

                } // cart chua co san pham, in ra loi
                else
                {
                    return new JsonResult(new { success = false });
                }
            }
        }

        public async Task<IActionResult> OnGetCheckout()
        {
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

            return new JsonResult(new { carts });

        }
    }
}
