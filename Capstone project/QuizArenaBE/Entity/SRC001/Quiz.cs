namespace QuizArenaBE.Entity.SRC001
{
    public class Quiz
    {
        public int QuizId { get; set; }
        public string Title { get; set; }
        public int CategoryId { get; set; }
        public string Description { get; set; }
        public string QuizType { get; set; }
        public string Status { get; set; }
        public string Image { get; set; }
        public string DifficultyLevel { get; set; }
        public int TimeLimit { get; set; }
        public int CreatorId { get; set; }
        public DateTime CreateDate { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}
