using System.ComponentModel.DataAnnotations;

namespace QuizArenaBE.Entity.SRC003
{
    public class UserManager
    {
        public int UserId { get; set; }

        [Required(ErrorMessage = "Full name is required.")]
        public string? Fullname { get; set; }

        [Required(ErrorMessage = "Email is required.")]
        [EmailAddress(ErrorMessage = "Invalid email format.")]
        public string? Email { get; set; }
        public DateTime? CreatedAt { get; set; }
        public int? Exp { get; set; }
        public int? Score { get; set; }
        public string? images { get; set; }
        public int? Role { get; set; }

        public string? ActivityType { get; set; }
        public int? QuizId { get; set; }
        public DateTime? DateAction { get; set; }
    }
}
