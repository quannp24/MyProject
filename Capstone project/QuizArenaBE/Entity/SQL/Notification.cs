using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL;

public partial class Notification
{
    public int UserId { get; set; }

    public string ContentNotification { get; set; } = null!;

    public string? Value { get; set; }

    public DateTime DateNotification { get; set; }

}
