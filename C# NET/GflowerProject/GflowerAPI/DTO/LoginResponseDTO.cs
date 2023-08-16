using BusinessObject;
using System.ComponentModel.DataAnnotations;

namespace GflowerAPI.DTO
{
    public class LoginResponseDTO
    {
        public int AccId { get; set; }
        public string Username { get; set; }

        public int Role { get; set; }
        public string Token { get; set; }

        public LoginResponseDTO() {
        
        }

        public LoginResponseDTO(Account acc, string token)
        {
            AccId = acc.AccountId;
            Username = acc.Username;
            Token = token;
            Role = acc.Role;
        }
    }
}
