using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL
{
    public partial class Users
    {
        public int UserId { get; set; }

        public string? Username { get; set; }

        public string? Fullname { get; set; }

        public string? Email { get; set; }

        public string? Description { get; set; }

        public string? Password { get; set; }

        public int? Role { get; set; }

        public int? Exp { get; set; }

        public int? Score { get; set; }

        public string? Token { get; set; }

        public int? Status { get; set; }

        public string? Images { get; set; }

        public string? VerificationCode { get; set; }

        public DateTime? CreatedAt { get; set; }

        public DateTime? UpdatedAt { get; set; }

    }
}


