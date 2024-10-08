﻿using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL
{
    public partial class Quiz
    {
        public int QuizId { get; set; }

        public string? Title { get; set; }

        public int? CategoryId { get; set; }

        public string? Description { get; set; }

        public int? QuizType { get; set; }

        public int? Status { get; set; }

        public string? Image { get; set; }

        public int? DifficultyLevel { get; set; }

        public int? TimeLimit { get; set; }

        public int? CreatorId { get; set; }

        public DateTime? CreateDate { get; set; }

        public DateTime? UpdatedAt { get; set; }

        public string? Comment { get; set; }

    }
}


