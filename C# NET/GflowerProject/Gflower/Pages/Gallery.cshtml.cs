using BusinessObject;
using Gflower.Common;
using Gflower.DTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Net.Http.Headers;
using System.Text;

namespace Gflower.Pages
{
    public class GalleryModel : PageModel
    {
		private readonly SessionHelper _sessionHelper;
		private HttpClient _client;
		private readonly string AccountAPI = "http://localhost:5025/api/Account";
		private readonly string CartAPI = "http://localhost:5025/odata/Cart";
		private readonly string productAPI = "http://localhost:5025/odata/Product";
		private readonly string productForAPI = "http://localhost:5025/api/Product";

		public Account account { get; set; }

        public int carts { get; set; }
        public List<ProductDTO> products { get; set; }
        public ProductDTO productSale { get; set; }

		private string Token { get; set; }
		private string Username { get; set; }

		public GalleryModel(SessionHelper sessionHelper)
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

        private async Task SetUpCart()
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

		private async Task SetUpProducts()
		{
			List<ProductDTO> items = new();

			var respone = await _client.GetAsync($"{productAPI}?$filter=status eq 1");
			string strData = await respone.Content.ReadAsStringAsync();

			dynamic temp = JObject.Parse(strData);
			if ((JArray)temp.value != null)
			{
				items = ((JArray)temp.value).Select(x => new ProductDTO
				{
					Discount = (int)x["Discount"],
					ProductName = (string)x["ProductName"],
					ProductId = (int)x["ProductId"],
					ProductImage = (string)x["ProductImage"],
					ProductDescription = (string)x["ProductDescription"],
					Status = (int)x["Status"],
					ProductPrice = (decimal)x["ProductPrice"]
				}).ToList();
			}
			products = items;
		}

		private async Task<Product> GetProductById(int Id)
		{
			if (Id != null)
			{
				var respone = await _client.GetAsync($"{productAPI}/{Id}");
				string strData = await respone.Content.ReadAsStringAsync();
				var productResponse = JsonConvert.DeserializeObject<Product>(strData);
				return productResponse;
			}
			return null;
		}

		private async Task<bool> AddProductToCart(Cart cart)
		{
			if (cart != null)
			{
				string content = System.Text.Json.JsonSerializer.Serialize(cart);
				var data = new StringContent(content, Encoding.UTF8, "application/json");
				var response = await _client.PostAsync($"{CartAPI}", data);
				string strData = await response.Content.ReadAsStringAsync();
				var temp = JObject.Parse(strData);
				bool productExist = (bool)temp["value"];
				if (response.IsSuccessStatusCode)
					return productExist;
			}
			return false;
		}


        private async Task SetUpProductBestSale()
        {

            var respone = await _client.GetAsync($"{productForAPI}/product-best-sale");
            string strData = await respone.Content.ReadAsStringAsync();
            var productResponse = JsonConvert.DeserializeObject<ProductDTO>(strData);
			productSale = productResponse;
     
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
                    await SetUpCart();
            }

			// set list product
			await SetUpProducts();
			await SetUpProductBestSale();

            return Page();
        }

		public async Task<IActionResult> OnGetAddCart(int productId)
		{
			if (await CheckLogin())
			{
				await SetUpHttpClient(Token);
				await SetUpAccount();
			}
			bool productExist = true; //neu product co trong cart thi la true, ko thi la false
			var product = await GetProductById(productId);
			// neu da login thi add cart vao db
			if (product != null)
			{
				decimal totalPrice = product.ProductPrice - (product.ProductPrice * ((decimal)product.Discount / 100));
				product.ProductPrice = totalPrice;
				Cart newcart = new Cart
				{
					ProductId = productId,
					Quantity = 1,
					TotalPrice = totalPrice
				};
				if (account != null)
				{
					newcart.AccountId = account.AccountId;
					productExist = await AddProductToCart(newcart);
				}
				else // neu chua login thi add vao session
				{
					//lay list cart tu session
					var sessionCartItems = _sessionHelper.GetSessionData<List<Cart>>("cart");
					if (sessionCartItems != null)
					{
						newcart.Product = product;
						productExist = AddOrUpdateProductToCart(sessionCartItems, newcart);
					}
					else//neu chua co product trong cart session
					{
						newcart.Product = product;
						sessionCartItems = new List<Cart> { newcart };
						productExist = false;
					}
					//set lai list cart session
					_sessionHelper.SaveSessionData("cart", sessionCartItems);
				}
			}
			else
			{
				//neu product khong ton tai
				return new JsonResult(new { success = false });
			}
			return new JsonResult(new { success = true, status = productExist });
		}

		public bool AddOrUpdateProductToCart(List<Cart> cart, Cart productToAdd)
        {
            Cart existingProduct = cart.FirstOrDefault(p => p.ProductId == productToAdd.ProductId);

            if (existingProduct != null)
            {
                existingProduct.Quantity += productToAdd.Quantity;
                existingProduct.TotalPrice+= productToAdd.TotalPrice;
                return true;
            }
            else
            {
                cart.Add(productToAdd);
                return false;
            }
        }

    }
}
