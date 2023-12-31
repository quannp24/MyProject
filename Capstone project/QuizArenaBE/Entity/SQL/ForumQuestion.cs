using System;
using System.Collections.Generic;
using QuizArenaBE.Entity.SQL;

namespace QuizArenaBE.Entity.SQL
{
    public partial class ForumQuestion
    {
        public int ForumQuestionId { get; set; }

        public int? UserId { get; set; }

        public string? QuestionText { get; set; }

        public DateTime? CreateDate { get; set; }

    }

}

