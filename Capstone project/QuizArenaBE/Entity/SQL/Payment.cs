using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL
{
    public partial class Payment
    {
        public int PaymentId { get; set; }

        public int? UserId { get; set; }

        public decimal? Amount { get; set; }

        public DateTime? PaymentDate { get; set; }

        public string? PaymentMethod { get; set; }
    }
}


