using System;
using System.Collections.Generic;

namespace QuizArenaBE.Entity.SQL;

public partial class UserRoomQuizRoomQuiz
{
    public string RoomId { get; set; } = null!;

    public int UserId { get; set; }

    public int role { get; set; }
}
