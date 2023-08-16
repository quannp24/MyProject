using System.ComponentModel.DataAnnotations;

namespace Gflower.DTO
{
    public class SignupRequestDTO
    {
        [Required]
        public string Username { get; set; }

        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required]
        public string LastName { get; set; }
        [Required]
        public string FirstName { get; set; }
    }
}
