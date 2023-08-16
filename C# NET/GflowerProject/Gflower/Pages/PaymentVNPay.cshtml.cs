using BusinessObject;
using Gflower.Common;
using Gflower.DTO.VNPay;
using Gflower.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Net;
using System.Net.Http.Headers;
using System.Xml.Linq;

namespace Gflower.Pages
{
    public class PaymentVNPayModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string CartAPI = "http://localhost:5025/odata/Cart";
        private readonly SessionHelper _sessionHelper;
        private readonly IVnPayService _vnPayService;


        public Account account { get; set; }

        public List<Cart> carts { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public PaymentVNPayModel(SessionHelper sessionHelper, IVnPayService vnPayService)
        {
            _client = new HttpClient();
            _sessionHelper = sessionHelper;
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
        public async Task<IActionResult> OnGetAsync(string name, string phone, string address, double total, string order_name)
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

            string shipInfo = name + " - " + phone + " - " + address + " - " + order_name;

            _sessionHelper.SaveSessionData("infor-payment", shipInfo);
            _sessionHelper.SaveSessionData("totalPrice", total);
            double totalAmount = Convert.ToDouble(total * 23000);

            PaymentInformationModel infoPayment = new PaymentInformationModel
            {
                Amount = totalAmount,
                Name = account != null ? account.LastName + account.FirstName : order_name,
                OrderType = "other",
                OrderDescription = order_name + " thanh toan VNPay"
            };
            var url = _vnPayService.CreatePaymentUrl(infoPayment, HttpContext);
            if (!string.IsNullOrEmpty(url))
            {
                return Redirect(url);

            }
            return RedirectToPage("./Payment?id=1");
        }
    }
}
