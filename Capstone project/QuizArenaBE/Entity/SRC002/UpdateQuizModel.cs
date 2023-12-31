using QuizArenaBE.Entity.SQL;

namespace QuizArenaBE.Entity.SRC002
{
    public class UpdateQuizModel
    {

        public UpdateQuizzesSRC002? quizz { get; set; }

        public List<UpdateQuestionsSRC002>? questions { get; set; }

       

        public class UpdateQuizzesSRC002
        {
            public int QuizId { get; set; }

            public string? Title { get; set; }

            public int? CategoryId { get; set; }

            public string? Description { get; set; }

            public int? QuizType { get; set; }

            public string? Image { get; set; }

            public int? Status { get; set; }

            public int? DifficultyLevel { get; set; }

            public int? TimeLimit { get; set; }

        }

        public class UpdateQuestionsSRC002
        {
            public int QuestionId { get; set; }

            public string? QuestionText { get; set; }

            public int? DifficultyLevel { get; set; }

            public string? CorrectAnswer { get; set; }

            public string? Options { get; set; }

        }
    }
}
