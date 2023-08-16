using Gflower.Common;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Security.Claims;
using BusinessObject;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using System.Text;
using Gflower.DTO;

namespace Gflower.Pages
{
    public class UpdateOrderModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string OrderAPI = "http://localhost:5025/odata/Order";
        private readonly string OrderforAPI = "http://localhost:5025/api/Order";
        private readonly SessionHelper _sessionHelper;

        public Account account { get; set; }
        public Order order { get; set; }

        [BindProperty(SupportsGet = true, Name = "orderId")]
        public int orderId { get; set; }

        [BindProperty(Name = "status")]
        public int status { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public UpdateOrderModel(SessionHelper sessionHelper)
        {
            _client = new HttpClient();
            _sessionHelper = sessionHelper;

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

        public async Task<IActionResult> OnGetAsync()
        {
            if (await CheckLogin())
            {
                await SetUpHttpClient(Token);
                await SetUpAccount();
            }

            if (account == null)
            {
                _sessionHelper.SaveSessionData("ReturnUrl", "/Management");
                return RedirectToPage("/Login");
            }
            else
            {
                if (account.Role != 1)
                {
                    return RedirectToPage("/Error403");
                }
            }

            if (TempData.TryGetValue("Message", out var Mess))
            {
                if (!string.IsNullOrEmpty(Mess?.ToString()))
                {
                    ViewData["Message"] = Mess;
                }
            }
            if (TempData.TryGetValue("MessageError", out var messError))
            {
                if (!string.IsNullOrEmpty(messError?.ToString()))
                {
                    ViewData["MessageError"] = messError;
                }
            }

            await SetUpOrder();
            return Page();
        }

        private async Task SetUpOrder()
        {

            var respone = await _client.GetAsync($"{OrderAPI}?$expand=OrderDetails($expand=Product),Account&$filter=OrderId eq {orderId}");
            string strData = await respone.Content.ReadAsStringAsync();

            var temp = JObject.Parse(strData);
            var orderValue = (JArray)temp["value"];
            var apiOrder = JsonConvert.DeserializeObject<Order>(orderValue[0].ToString());
            order = apiOrder;
        }


        public async Task<IActionResult> OnPostUpdateStatus()
        {
            if (await CheckLogin())
            {
                await SetUpHttpClient(Token);
                await SetUpAccount();
            }
            if (account != null)
            {
                if (account.Role == 1)
                {
                    UpdateStatusOrderDTO raw_cart = new UpdateStatusOrderDTO
                    {
                        OrderId = orderId!=null?orderId:0,
                        StatusOrder = status != null ? status : 0
                    };
                    string content = System.Text.Json.JsonSerializer.Serialize(raw_cart);
                    var data = new StringContent(content, Encoding.UTF8, "application/json");
                    var response = await _client.PutAsync($"{OrderforAPI}", data);
                    if (response.IsSuccessStatusCode)
                    {
                        TempData["Message"] = "Update status order success.";
                        return RedirectToPage("/UpdateOrder", new { orderId = orderId });
                    }
                    else
                    {
                        TempData["MessageError"] = "Update status order fail something, try aigain!";
                        return RedirectToPage("/UpdateOrder", new { orderId = orderId });
                    }
                }
                else
                {
                    return RedirectToPage("/Error403");
                }
            }
            else
            {
                return RedirectToPage("/Login");
            }
        }

    }
}
