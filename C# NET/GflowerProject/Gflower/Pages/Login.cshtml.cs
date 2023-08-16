using Gflower.Common;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Gflower.DTO;
using Newtonsoft.Json;
using System.Text;
using BusinessObject;
using Newtonsoft.Json.Linq;

namespace Gflower.Pages
{
    public class Login : PageModel
    {
        private HttpClient _client;
        private readonly string AuthenticationApiUrl = "http://localhost:5025/api/Auth/signin";
        private readonly SessionHelper _sessionHelper;

        public Login(SessionHelper sessionHelper)
        {
            _client = new HttpClient();
            _sessionHelper = sessionHelper;
        }

        public async Task<IActionResult> OnGetAsync()
        {
            //check login 
            var username = _sessionHelper.GetSessionData<string>("username");
            //check login in session
            if (username != null)
            {
                return RedirectToPage("/Home");
            }
            //check login in cookie
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToPage("/Home");
            }

            var result = await HttpContext.AuthenticateAsync(
                CookieAuthenticationDefaults.AuthenticationScheme);

            if (result.Succeeded)
            {
                await HttpContext.SignInAsync(
                    CookieAuthenticationDefaults.AuthenticationScheme,
                    result.Principal,
                    result.Properties);

                return RedirectToPage("/Home");
            }

            return Page();
        }

        [BindProperty]
        public LoginRequestDTO Input { get; set; }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError(string.Empty, "Incorrect account.");
                return Page();
            }
            string content = System.Text.Json.JsonSerializer.Serialize(Input);
            var data = new StringContent(content, Encoding.UTF8, "application/json");
            var response = await _client.PostAsync($"{AuthenticationApiUrl}", data);
            string strData = await response.Content.ReadAsStringAsync();
            if (!response.IsSuccessStatusCode)
            {
                ViewData["Error"] = "Email or password wrong!";
            }
            else
            {
                var authenticationResponse = JsonConvert.DeserializeObject<LoginResponseDTO>(strData);
                if (authenticationResponse != null)
                {
                    var returnUrl = _sessionHelper.GetSessionData<string>("ReturnUrl");
                    HttpContext.Session.Clear();
                    // Lưu thông tin người dùng vào session
                    _sessionHelper.SaveSessionData("username", authenticationResponse.Username);
                    _sessionHelper.SaveSessionData("token",  authenticationResponse.Token);
                    _sessionHelper.SaveSessionData("role", authenticationResponse.Role);
                    if (Input.RememberMe)
                    {
                        var claims = new List<Claim>
                                    {
                                        new Claim("Token", authenticationResponse.Token),
                                        new Claim(ClaimTypes.Name, authenticationResponse.Username)
                                    };
                        var claimsIdentity = new ClaimsIdentity(
                            claims, CookieAuthenticationDefaults.AuthenticationScheme);
                        var authProperties = new AuthenticationProperties
                        {
                            IsPersistent = true, // để cookie tồn tại sau khi đóng trình duyệt
                            ExpiresUtc = DateTimeOffset.UtcNow.AddDays(7) // thiết lập thời gian hết hạn của cookie
                        };
                        await HttpContext.SignInAsync(
                            CookieAuthenticationDefaults.AuthenticationScheme,
                            new ClaimsPrincipal(claimsIdentity),
                            authProperties);

                    }
                    if (returnUrl != null)
                    {
                        return RedirectToPage(returnUrl);
                    }
                    else
                    {
                        return RedirectToPage("./Home");
                    }
                }
            }
            return Page();
        }




    }
}
