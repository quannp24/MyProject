namespace QuizArenaBE.Entity.SRC001
{
    public class Exam
    {
        public int ExamId { get; set; }
        public string ExamName { get; set; }
        public int QuizId { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public string Status { get; set; }
        public DateTime Date { get; set; }
    }
}
