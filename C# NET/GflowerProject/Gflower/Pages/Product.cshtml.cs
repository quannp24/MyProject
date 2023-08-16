using BusinessObject;
using Gflower.Common;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;
using System.Net.Http.Headers;
using IHostingEnvironment = Microsoft.AspNetCore.Hosting.IHostingEnvironment;
using Gflower.DTO;
using System.Text;

namespace Gflower.Pages
{
    public class ProductModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
		private readonly string productAPI = "http://localhost:5025/odata/Product";
		private readonly string productforAPI = "http://localhost:5025/api/Product";
        private readonly SessionHelper _sessionHelper;
        private IHostingEnvironment _environment;

        public Account account { get; set; }
        public List<Product> products { get; set; }

        [BindProperty]
        public ProductInputDTO Input { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public ProductModel(SessionHelper sessionHelper, IHostingEnvironment environment)
        {
            _client = new HttpClient();
            _sessionHelper = sessionHelper;
            _environment = environment;
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
                _sessionHelper.SaveSessionData("ReturnUrl", "/Product");
                return RedirectToPage("/Login");
            }
            else
            {
                if (account.Role != 1)
                {
                    return RedirectToPage("/Error403");
                }
            }
            await SetProducts();
            return Page();
        }

        public async Task SetProducts()
        {
            if(account != null)
            {
                var response = await _client.GetAsync($"{productforAPI}/products-admin");
                string strData = await response.Content.ReadAsStringAsync();

                var productsResponse = JsonConvert.DeserializeObject<List<Product>>(strData);
                if (productsResponse != null)
                    products = productsResponse;
            }
        }

        private async Task<Product> AddProduct(AddProductDTO product)
        {
            string content = System.Text.Json.JsonSerializer.Serialize(product);
            var data = new StringContent(content, Encoding.UTF8, "application/json");
            var response = await _client.PostAsync($"{productAPI}", data);
            string strData = await response.Content.ReadAsStringAsync();
            var productsResponse = JsonConvert.DeserializeObject<Product>(strData);
            return productsResponse;
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (await CheckLogin())
            {
                await SetUpHttpClient(Token);
                await SetUpAccount();
            }
            if (account != null)
            {
                if (Input != null)
                {
                    AddProductDTO product = new AddProductDTO
                    {
                        ProductName = Input.Name,
                        ProductDescription = string.IsNullOrEmpty(Input.Description)?"": Input.Description,
                        ProductPrice = Input.Price,
                        Status = 1,
                        Discount= Input.Discount

                    };
                    //upload image
                    if (Input.FileUploads != null)
                    {
                        foreach (var FileUpload in Input.FileUploads)
                        {
                            var fileExtension = Path.GetExtension(FileUpload.FileName).ToLower();
                            product.ProductImage = fileExtension;
                            var productNew = await AddProduct(product);
                            if(productNew!= null)
                            {
                                var filePath = Path.Combine(_environment.WebRootPath, "Image", "bouquet", productNew.ProductImage);

                                using (var fileStream = new FileStream(filePath, FileMode.Create))
                                {
                                    await FileUpload.CopyToAsync(fileStream);
                                }
                            }
                        }

                    }
                    TempData["SuccessMessage"] = "Add success!";
                    return RedirectToPage("/Product");
                }
                else
                {
                    return RedirectToPage("/Product");
                }
            }
            else
            {
                _sessionHelper.SaveSessionData("ReturnUrl", "/Product");
                return RedirectToPage("/Login");
            }

        }

    }
}
