namespace QuizArenaBE.Entity.SRC003
{
    public class UserHistoryInfo
    {
        public int HistoryId { get; set; }
        public int UserId { get; set; }
        public int ActionType { get; set; }
        public int QuizId { get; set; }
        public DateTime DateAction { get; set; }
        public string? UserName { get; set; }
        public string? QuizTitle { get; set;}
    }
}
