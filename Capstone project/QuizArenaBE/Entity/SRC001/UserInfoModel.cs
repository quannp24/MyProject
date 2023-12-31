using System.ComponentModel.DataAnnotations;

namespace QuizArenaBE.Entity.SRC001
{
    public class UserInfoModel
    {
        public int UserId { get; set; }

        [Required(ErrorMessage = "Full name is required.")]
        public string? Fullname { get; set; }
        public string? Username { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid email format.")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Password is required.")]
        [MinLength(6, ErrorMessage = "Password must be at least 6 characters.")]
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$",
        ErrorMessage = "Password must contain at least one uppercase letter and one digit.")]
        public string? Password { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? Exp { get; set; }
        public int? Score { get; set; }
        public string? images { get; set; }
        public string? Description { get; set; }
    }
}
