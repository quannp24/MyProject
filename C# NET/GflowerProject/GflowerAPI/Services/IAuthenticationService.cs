
using GflowerAPI.DTO;

namespace GflowerAPI.Services
{
    public interface IAuthenticationService
    {
        LoginResponseDTO Authenticate(LoginRequestDTO model);
    }
}
