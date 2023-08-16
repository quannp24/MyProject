using BusinessObject;
using Gflower.Common;
using Gflower.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.ComponentModel.DataAnnotations;
using System.Net.Http.Headers;
using System.Text;
using IHostingEnvironment = Microsoft.AspNetCore.Hosting.IHostingEnvironment;

namespace Gflower.Pages
{
    public class ProductUpdateModel : PageModel
    {
        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly string productAPI = "http://localhost:5025/odata/Product";
        private readonly string productforAPI = "http://localhost:5025/api/Product";
        private readonly SessionHelper _sessionHelper;
        private IHostingEnvironment _environment;

        public Account account { get; set; }
        public Product product { get; set; }

        [BindProperty]
        public ProductUpdateDTO Input { get; set; }

        [BindProperty(SupportsGet = true)]
        public int productId { get; set; }

        private string Token { get; set; }
        private string Username { get; set; }

        public ProductUpdateModel(SessionHelper sessionHelper, IHostingEnvironment environment)
        {
            _sessionHelper = sessionHelper;
            _client = new HttpClient();
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
        public async Task SetProduct()
        {
            if (account != null)
            {
                var response = await _client.GetAsync($"{productAPI}?$filter=productId eq {productId}");
                string strData = await response.Content.ReadAsStringAsync();
                var temp = JObject.Parse(strData);
                var productValue = (JArray)temp["value"];
                var productsResponse = JsonConvert.DeserializeObject<Product>(productValue[0].ToString());
                if (productsResponse != null)
                    product = productsResponse;

            }
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
            
            await SetProduct();
            return Page();
        }

        private async Task<bool> UpdateProduct(ProductDTO product)
        {
            string content = System.Text.Json.JsonSerializer.Serialize(product);
            var data = new StringContent(content, Encoding.UTF8, "application/json");
            var response = await _client.PutAsync($"{productforAPI}", data);

            if (response.IsSuccessStatusCode)
            {
                return true;
            }
            return false;
        }

        public async Task<IActionResult> OnGetRemoveProduct(int productId)
        {
            var response = await _client.DeleteAsync($"{productAPI}/{productId}");
            if(response.IsSuccessStatusCode)
            {
                return new JsonResult(new { success = true });
            }
            else
            {
                return new JsonResult(new { success = false });
            }
        }


            public async Task<IActionResult> OnPostUpdateProduct()
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
                    ProductDTO product_New = new ProductDTO
                    {
                        ProductId = productId,
                        ProductName = Input.Name,
                        ProductDescription = Input.Description,
                        ProductPrice = Input.Price,
                        Status = Input.Status,
                        Discount= Input.Discount
                    };
                    //upload image
                    if (Input.FileUploads != null)
                    {
                        foreach (var FileUpload in Input.FileUploads)
                        {
                            var fileExtension = Path.GetExtension(FileUpload.FileName).ToLower();
                            string fileName = "bou" + productId + fileExtension.ToString();
                            product_New.ProductImage = fileName;
                            var filePath = Path.Combine(_environment.WebRootPath, "Image", "bouquet", fileName);
                            using (var fileStream = new FileStream(filePath, FileMode.Create))
                            {
                                await FileUpload.CopyToAsync(fileStream);
                            }
                        }

                    }
                    if(await UpdateProduct(product_New))
                    {
                        TempData["SuccessMessage"] = "Update success!";
                        return RedirectToPage("/ProductUpdate", new { productId = productId });
                    }
                    else
                    {
                        TempData["ErrorMessage"] = "Update fail some thing, try again!";
                        return RedirectToPage("/ProductUpdate", new { productId = productId });
                    }
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
