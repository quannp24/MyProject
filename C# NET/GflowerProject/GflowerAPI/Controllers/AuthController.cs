using BusinessObject;
using DataAccess.IRepository;
using GflowerAPI.DTO;
using GflowerAPI.Services;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Mime;
using System.Security.Claims;

namespace GflowerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : Controller
    {
        private readonly Services.IAuthenticationService _authenticationService;


        public AuthController(Services.IAuthenticationService authenticationService)
        {
            _authenticationService = authenticationService;

        }

        [AllowAnonymous]
        [HttpPost("signin")]
        [Consumes(MediaTypeNames.Application.Json)]
        public async Task<ActionResult<LoginResponseDTO>> Authentication(LoginRequestDTO loginInformation)
        {
            
            LoginResponseDTO loginResponse = _authenticationService.Authenticate(loginInformation);

            if (loginResponse == null)
            {
                return Unauthorized();
            }
            
            return Ok(loginResponse);
        }
    }
}
