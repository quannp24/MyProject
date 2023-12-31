using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL;

public partial class HistoryUser
{
    public int HistoryId { get; set; }

    public int UserId { get; set; }

    public int ActionType { get; set; }

    public int? QuizId { get; set; }

    public DateTime DateAction { get; set; }

}
