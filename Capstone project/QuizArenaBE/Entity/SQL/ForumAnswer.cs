using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL
{
    public partial class ForumAnswer
    {
        public int ForumAnswerId { get; set; }

        public int? ForumQuestionId { get; set; }

        public int? UserId { get; set; }

        public string? AnswerText { get; set; }

        public int? Correct { get; set; }

        public DateTime? CreateDate { get; set; }
    }

}