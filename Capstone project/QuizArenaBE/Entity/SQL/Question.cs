namespace QuizArenaBE.Entity.SQL
{
    public partial class Question
    {
        public int QuestionId { get; set; }

        public string? QuestionText { get; set; }

        public int? DifficultyLevel { get; set; }

        public string? CorrectAnswer { get; set; }

        public string? Options { get; set; }
    }

}

