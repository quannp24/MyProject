using QuizArenaBE.Entity.Validation;
using System.ComponentModel.DataAnnotations;

namespace QuizArenaBE.Entity.SRC001
{
    public class ChangePasswordRequest
    {
        [Required(ErrorMessage = ValidationMessages.PasswordRequired)]
        public string OldPass { get; set; }

        [Required(ErrorMessage = ValidationMessages.PasswordRequired)]
        [RegularExpression(ValidationMessages.PasswordComplexityRegex, ErrorMessage = ValidationMessages.PasswordComplexity)]
        [StringLength(100, MinimumLength = 6, ErrorMessage = ValidationMessages.PasswordMinLength)]
        public string NewPass { get; set; }
    }
}
