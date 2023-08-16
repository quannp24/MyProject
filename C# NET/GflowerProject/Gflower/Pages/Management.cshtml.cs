using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net.Http.Headers;

namespace Gflower.Pages
{
    public class ManagementModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string OrderAPI = "http://localhost:5025/odata/Order";
        private readonly string OrderforAPI = "http://localhost:5025/api/Order";
        private readonly SessionHelper _sessionHelper;

        public Account account { get; set; }
        public List<Order> ordersUsers { get; set; }
        public List<Order> ordersUnknown { get; set; }
        public int TotalOrder { get; set; }
        public decimal TotalMoney { get; set; }
        private string Token { get; set; }
        private string Username { get; set; }

        //pagtion order user
        [BindProperty(SupportsGet = true)]
        public int CurrentPage { get; set; } = 1;

        public int PageSize { get; set; } = 5;
        public int totalPage { get; set; }

        //pagtion order user
        [BindProperty(SupportsGet = true)]
        public int CurrentPageUnknown { get; set; } = 1;

        public int PageSizeUnknown { get; set; } = 5;
        public int totalPageUnknown { get; set; }

        public ManagementModel(SessionHelper sessionHelper)
        {
            _sessionHelper = sessionHelper;
            _client = new HttpClient();

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
                return RedirectToPage("/Login") ;
            }
            else
            {
                if(account.Role != 1)
                {
                    return RedirectToPage("/Error403");
                }
            }
            await SetOrdersUsers();
            await SetOrdersUnknown();
            await SetTotalOrders();
            await SetTotalMoney();
            return Page();
        }


        private async Task SetOrdersUsers()
        {
            var respone = await _client.GetAsync($"{OrderAPI}?$expand=Account&$filter=AccountId ne null");
            string strData = await respone.Content.ReadAsStringAsync();
            if (respone.IsSuccessStatusCode)
            {
                var temp = JObject.Parse(strData);
                var raw_list = (JArray)temp["value"];
                var items = JsonConvert.DeserializeObject<List<Order>>(raw_list.ToString());

                var paginatedItems = items.Skip((CurrentPage - 1) * PageSize).Take(PageSize).ToList();
                totalPage = (int)Math.Ceiling(items.Count() / (double)PageSize);
                ordersUsers = paginatedItems;

            }
        }

        private async Task SetOrdersUnknown()
        {
            var respone = await _client.GetAsync($"{OrderAPI}?$expand=Account&$filter=AccountId eq null");
            string strData = await respone.Content.ReadAsStringAsync();
            if (respone.IsSuccessStatusCode)
            {
                var temp = JObject.Parse(strData);
                var raw_list = (JArray)temp["value"];
                var items = JsonConvert.DeserializeObject<List<Order>>(raw_list.ToString());

                var paginatedItems = items.Skip((CurrentPageUnknown - 1) * PageSizeUnknown).Take(PageSizeUnknown).ToList();
                totalPageUnknown = (int)Math.Ceiling(items.Count() / (double)PageSizeUnknown);
                ordersUnknown = paginatedItems;
            }
        }

        private async Task SetTotalOrders()
        {
            var respone = await _client.GetAsync($"{OrderforAPI}/get-count-orders/1");
            string strData = await respone.Content.ReadAsStringAsync();
            if (respone.IsSuccessStatusCode)
            {
                int total;
                bool temp = int.TryParse(strData, out total);
                if(temp)
                {
                    TotalOrder = total;
                }
            }
        }

        private async Task SetTotalMoney()
        {
            var respone = await _client.GetAsync($"{OrderforAPI}/get-total-money/1");
            string strData = await respone.Content.ReadAsStringAsync();
            if (respone.IsSuccessStatusCode)
            {
                decimal total;
                bool temp = decimal.TryParse(strData, out total);
                if (temp)
                {
                    TotalMoney = total;
                }
            }
        }
    }
}
