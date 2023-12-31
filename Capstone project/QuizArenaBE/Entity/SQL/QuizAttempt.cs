using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL;

public partial class QuizAttempt
{
    public int AttemptId { get; set; }

    public int? QuizId { get; set; }

    public int? UserId { get; set; }
}
