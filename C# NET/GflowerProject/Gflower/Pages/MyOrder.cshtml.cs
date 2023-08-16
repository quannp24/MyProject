using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace Gflower.Pages
{
    public class MyOrderModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string CartAPI = "http://localhost:5025/odata/Cart";
        private readonly string OrderAPI = "http://localhost:5025/odata/Order";
        private readonly SessionHelper _sessionHelper;

        public Account account { get; set; }

        public int carts { get; set; }
        public List<Order> orders { get; set; }

        [BindProperty(SupportsGet = true)]
        public int CurrentPage { get; set; } = 1;

        public int PageSize { get; set; } = 5;
        public int totalPage { get; set; }
        public int totalList { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public MyOrderModel(SessionHelper sessionHelper)
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

        private async Task SetUpCart()
        {
            List<Cart> items = new();

            var respone = await _client.GetAsync($"{CartAPI}?$expand=Product&$filter=AccountID eq {account.AccountId}");
            string strData = await respone.Content.ReadAsStringAsync();

            var temp = JObject.Parse(strData);
            var productExist = (JArray)temp["value"];
            var cartList = JsonConvert.DeserializeObject<List<Cart>>(productExist.ToString());
            carts = cartList.Count;
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
                carts = sessionCartItems.Count;
            }
            else
            {
                if (account != null)
                {
                    await SetUpCart();
                    await SetOrders();
                }

            }
            return Page();
        }


        private async Task SetOrders()
        {
            var respone = await _client.GetAsync($"{OrderAPI}?$filter=AccountId eq {account.AccountId}");
            string strData = await respone.Content.ReadAsStringAsync();
            if (respone.IsSuccessStatusCode)
            {
                var temp = JObject.Parse(strData);
                var raw_list = (JArray)temp["value"];
                var items = JsonConvert.DeserializeObject<List<Order>>(raw_list.ToString());
                if(items != null)
                {
                    totalList = items.Count();
                    var paginatedItems = items.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToList();
                    totalPage = (int)Math.Ceiling(totalList / (double)PageSize);
                    orders = paginatedItems;
                }
                else
                {
                    return;
                }
            }
        }

        

    }
}
