using Gflower.Common;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;
using Gflower.DTO;
using BusinessObject;
using Newtonsoft.Json.Linq;
using System.Text;
using Newtonsoft.Json;

namespace Gflower.Pages
{
	public class SignupModel : PageModel
	{

        private HttpClient _client;
        private readonly string AccountAPI = "http://localhost:5025/api/Account";
        private readonly SessionHelper _sessionHelper;

        public SignupModel(SessionHelper sessionHelper)
		{
            _client = new HttpClient();
            _sessionHelper = sessionHelper;
        } 

		[BindProperty]
		public SignupRequestDTO Input { get; set; }
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

		public async Task<IActionResult> OnPostAsync()
		{
			if (!ModelState.IsValid)
			{
				return Page();
			}
			// check username exists
			if ( await CheckUsername(Input.Username))
			{
                string content = System.Text.Json.JsonSerializer.Serialize(Input);
                var data = new StringContent(content, Encoding.UTF8, "application/json");
                var response = await _client.PostAsync($"{AccountAPI}", data);
                string strData = await response.Content.ReadAsStringAsync();
                if (!response.IsSuccessStatusCode)
                {
                    ModelState.AddModelError(string.Empty, "Something wrong!.");
                    return Page();
                }
				else
				{
                    return RedirectToPage("/Login");

                }
            }
			else
			{
                ModelState.AddModelError(string.Empty, "Username exists.");
                return Page();
            }
		}

		private async Task<bool> CheckUsername(string username)
		{
			var response = await _client.GetAsync($"{AccountAPI}/checkUsername/{username}");

			if (!response.IsSuccessStatusCode)
			{
				return true;
			}
			return false;
        }
	}
}
