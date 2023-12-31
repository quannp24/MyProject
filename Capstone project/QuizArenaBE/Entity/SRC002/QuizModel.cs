using QuizArenaBE.Entity.SQL;

namespace QuizArenaBE.Entity.SRC002
{
    public class QuizModel
    {
        public bool CheckUpEXP { get; set; } = true;
        public QuizzesSRC002? quizz { get; set; }

        public List<QuestionsSRC002>? questions { get; set; }

       

        public class QuizzesSRC002
        {
            public int? QuizId { get; set; }

            public string? Title { get; set; }

            public int? isFriendCreator { get; set; }

            public int? CategoryId { get; set; }

            public string? Description { get; set; }

            public int? CreatorId { get; set; }

            public int? QuizType { get; set; }

            public string? Image { get; set; }

            public int? Status { get; set; }

            public int? DifficultyLevel { get; set; }

            public int? TimeLimit { get; set; }

            public DateTime? CreateDate { get; set; }

            public DateTime? UpdatedAt { get; set; }

            public string? Comment { get; set; }
            
        }

        public class QuestionsSRC002
        {
            public int? QuestionId { get; set; }

            public string? QuestionText { get; set; }

            public int? DifficultyLevel { get; set; }

            public string? CorrectAnswer { get; set; }

            public string? Options { get; set; }
            public string[]? OptionsSRC002 { get; set; }

            public int? UserId { get; set; }

            public int? Status { get; set; }

            public int? CreatorId { get; set; }

        }
    }
}
