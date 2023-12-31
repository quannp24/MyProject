using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL;

public partial class RoomQuiz
{
    public string RoomId { get; set; } = null!;

    public int? CurrentQuestion { get; set; }

    public int? QuizId { get; set; }

    public int? TotalExp { get; set; }
}
