namespace QuizArenaBE.Entity.SRC002
{
    public class UpdateStatusQuiz
    {
        public int quizId { get; set; }
        public int status { get; set; }

        public string? comment { get; set; } = null;

    }
}
