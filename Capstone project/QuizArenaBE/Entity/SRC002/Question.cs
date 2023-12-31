namespace QuizArenaBE.Entity.SRC002
{

    public class QuestionModel
    {
        public int CategoryId { get; set; }
        public List<ListQuestion> listquestions { get; set; }
        public class ListQuestion
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

}
