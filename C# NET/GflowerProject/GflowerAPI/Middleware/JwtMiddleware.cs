using BusinessObject;
using DataAccess;
using DataAccess.IRepository;
using GflowerAPI.DTO;
using GflowerAPI.Services;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Text;

namespace EBookStoreWebAPI.Middleware
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly AppSettings _appSettings;

        public JwtMiddleware(RequestDelegate next, IOptionsMonitor<AppSettings> appSettings)
        {
            _next = next;
            _appSettings = appSettings.CurrentValue;
        }

        public async Task Invoke(HttpContext context, IAuthenticationService authenticationService, IAccountRepository userRepository)
        {
            string token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

            if (token != null)
            {
                AttachUserToContext(context, authenticationService, userRepository, token);
            }

            await _next(context);
        }

        private void AttachUserToContext(HttpContext context, IAuthenticationService userService, IAccountRepository accRepository, string token)
        {
            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                byte[] key = Encoding.ASCII.GetBytes(_appSettings.Secret);
                tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    // set clockskew to zero so tokens expire exactly at token expiration time (instead of 5 minutes later)
                    ClockSkew = TimeSpan.Zero
                }, out var validatedToken);

                var jwtToken = (JwtSecurityToken)validatedToken;
                int userId = int.Parse(jwtToken.Claims.First(x => x.Type == "id").Value);
                string username = jwtToken.Claims.First(x => x.Type == "username").Value;
                // attach user to context on successful jwt validation
                if (userId > 0)
                {
                    context.Items["Account"] = accRepository.GetAccByID(userId);
                    return;
                }
            }
            catch
            {

            }
        }
    }
}
