using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;

namespace Gflower.Pages
{
    public class Home : PageModel
    {
        private readonly SessionHelper _sessionHelper;
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string CartAPI = "http://localhost:5025/odata/Cart";


        public Account account { get; set; }
        public int carts { get; set; }
        private string Token { get; set; }
        private string Username { get; set; }

        public Home(SessionHelper sessionHelper)
        {
            _sessionHelper = sessionHelper;
            _client = new HttpClient();
        }

        private bool CheckLogin()
        {
            var token = _sessionHelper.GetSessionData<string>("token");
            var username  = _sessionHelper.GetSessionData<string>("username");
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

        private void SetUpHttpClient(string token)
        {
            _client = new HttpClient();
            var contentType = new MediaTypeWithQualityHeaderValue("application/json");
            _client.DefaultRequestHeaders.Accept.Add(contentType);
            _client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

        }

        public async Task<IActionResult> OnGetAsync()
        {
            if (CheckLogin())
            {
                SetUpHttpClient(Token);
                var response = await _client.GetAsync($"{AccountAPI}/{Username}");
                string strData = await response.Content.ReadAsStringAsync();
				var authenticationResponse = JsonConvert.DeserializeObject<Account>(strData);
                if(authenticationResponse !=null )
                    account = authenticationResponse;
                
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
                    List<Cart> items = new();

                    var respone = await _client.GetAsync($"{CartAPI}?$count=true&$filter=AccountID eq {account.AccountId}");
                    string strData = await respone.Content.ReadAsStringAsync();

					dynamic temp = JObject.Parse(strData);
                    if ((JArray)temp.value != null)
                    {
                        items = ((JArray)temp.value).Select(x => new Cart
                        {
                            CartId = (int)x["CartId"],
                            ProductId = (int)x["ProductId"],
                            Quantity = (int)x["Quantity"],
                            TotalPrice = (decimal)x["TotalPrice"],
                            Status = (int)x["Status"]
                        }).ToList();
                    }
                    carts = items.Count;

                }
            }
            return Page();
        }
    }
}
