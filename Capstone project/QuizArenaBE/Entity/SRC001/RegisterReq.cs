using System.ComponentModel.DataAnnotations;

namespace QuizArenaBE.Entity.SRC001
{
    public class RegisterReq
    {
        [Required(ErrorMessage = "Full name is required.")]
        public string fullname { get; set; }

        [Required(ErrorMessage = "Username is required..")]
        [MinLength(6, ErrorMessage = "Username must be at least 6 characters.")]
        public string username { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid email format.")]
        public string email { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        [MinLength(6, ErrorMessage = "Password must be at least 6 characters.")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$",
         ErrorMessage = "Password must contain at least one uppercase letter and one digit.")]
        public string password { get; set; }
    }


}
