
using BusinessObject;
using DataAccess.IRepository;
using GflowerAPI.DTO;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace GflowerAPI.Services
{
    public class AuthenticationService : IAuthenticationService
    {
        private readonly IAccountRepository _accountRepository;
        private readonly AppSettings _appSettings;

        public AuthenticationService(
            IAccountRepository accRepository,
            IOptions<AppSettings> appSettings)
        {
            _accountRepository = accRepository;
            _appSettings = appSettings.Value;
        }

        public LoginResponseDTO Authenticate(LoginRequestDTO model)
        {
            Account acc = _accountRepository.Login(model.Username, model.Password);

            if (acc == null)
            {
                return null;
            }

            string token = GenerateJwtToken(acc);

            return new LoginResponseDTO(acc, token);
        }

        private string GenerateJwtToken(Account user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            byte[] key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", user.AccountId.ToString()),
                    new Claim("role", user.Role + ""),
                    new Claim("username", user.Username) }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
