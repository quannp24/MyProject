namespace QuizArenaBE.Entity.SRC003
{
    public class PaymentInfo
    {
        public int PaymentId { get; set; }
        public int UserId { get; set; }
        public decimal Amount { get; set; }
        public DateTime PaymentDate { get; set; }
        public string? PaymentMethod { get; set; }
        public string? Username { get; set; }
    }
}
