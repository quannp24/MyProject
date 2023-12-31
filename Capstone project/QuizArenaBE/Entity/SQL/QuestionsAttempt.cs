using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL
{
    public partial class QuestionsAttempt
    {
        public int AttemptId { get; set; }

        public int? QuizId { get; set; }

        public int? QuestionId { get; set; }

    }
}
