using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json.Linq;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Services.Common;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace QuizArenaBE.Services.JWT
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;
        //private readonly JwtSettings _jwtSettings;
        private readonly IConfiguration _configuration;
        private readonly ICRUDcommon _crudCommon;

        public JwtMiddleware(RequestDelegate next, IConfiguration configuration, ICRUDcommon crudCommon)
        {
            _next = next;
            _configuration = configuration;
            _crudCommon = crudCommon;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                var token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

                if (token != null)
                {
                    var status = await AttachUserToContext(context, token);
                    if (status)
                    {
                        await _next(context);
                    }
                    return;
                }
                await _next(context);
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                await context.Response.WriteAsync(ex.Message);
                return;
            }
        }

        private async Task<bool> AttachUserToContext(HttpContext context, string token)
        {
            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.ASCII.GetBytes(_configuration.GetSection("JwtSettings").Get<JwtSettings>().Secret);

                tokenHandler.ValidateToken(token, new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    ClockSkew = TimeSpan.Zero
                }, out SecurityToken validatedToken);
                var jwtToken = (JwtSecurityToken)validatedToken;

                //Check time token
                long numberTime = long.Parse(jwtToken.Claims.First(x => x.Type == "exp").Value);
                DateTime unixEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc); // Thời điểm Unix Epoch
                DateTime expirationDateTime = unixEpoch.AddSeconds(numberTime);
                if (expirationDateTime < DateTime.UtcNow)
                {
                    context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    await context.Response.WriteAsync("Token expired");
                    return false;
                }

                //Check userId exits token
                var userId = int.Parse(jwtToken.Claims.First(x => x.Type == "userId").Value);
                var statusToken = CheckToken(userId, token);
                if (!statusToken.Result)
                {
                    context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    await context.Response.WriteAsync("Not Found UserId or Token");
                    return false;
                }
                var userRole = int.Parse(jwtToken.Claims.First(x => x.Type == "role").Value);

                context.Items["userId"] = userId;
                context.Items["role"] = userRole;
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private async Task<bool> CheckToken(int id, string token)
        {
            StringBuilder query = new StringBuilder();
            query.AppendLine("SELECT top (1) token FROM Users WHERE user_id = @Userid and token = @Token");

            var param = new
            {
                userid = id,
                Token = token
            };
            var user = await _crudCommon.QuerySingleOrDefaultAsync<Users>(query.ToString(), param);
            if (user == null)
            {
                return false;
            }
            return true;
        }
    }
}
