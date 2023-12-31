namespace QuizArenaBE.Entity.SRC002
{
    public class ExamModel
    {
        public string? ExamId { get; set; }
        public string? ExamName { get; set; }
        public int QuizId { get; set; }
        public string? Description { get; set; }
        public string? Image { get; set; } = null;
        public int Status { get; set; }
        public DateTime Date { get; set; }
        public int ExamType { get; set; }
    }
}
