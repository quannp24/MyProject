namespace QuizArenaBE.Entity.SRC003
{
    public class DeleQuestion
    {
        public int QuestionId { get; set; }
        public string? QuestionText { get; set; }
        public int DifficultyLevel { get; set; }
        public string? CorrectAnswer { get; set; }
        public string? Options { get; set; }
        public int Status { get; set; }
        public int UserId { get; set; }
    }
}
