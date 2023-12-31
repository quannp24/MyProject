
namespace QuizArenaBE.Entity.SRC002
{
    public class InsertQuizReq
    {

        public QuizzesSRC002Req? quizz { get; set; }

        public List<QuestionsSRC002Req>? questions { get; set; }

        public class QuizzesSRC002Req
        {
            public string Title { get; set; }

            public int? CategoryId { get; set; }

            public string? Image { get; set; }

            public int? Status { get; set; } = 0;

            public string? Description { get; set; }

            public int? QuizType { get; set; }

            public int? DifficultyLevel { get; set; }

            public int TimeLimit { get; set; }

        }

        public class QuestionsSRC002Req
        {         
            public int? QuestionId { get; set; }

            public string QuestionText { get; set; }

            public int DifficultyLevel { get; set; }

            public string CorrectAnswer { get; set; }

            public string Options { get; set; }

        }
    }
}
