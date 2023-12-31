namespace QuizArenaBE.Entity.SRC003
{
    public class UserRecentActivity
    {
        public int UserId { get; set; }
        public string? Fullname { get; set; }
        public string? Email { get; set; }
        public DateTime DateAction { get; set; }
        public int TotalActivities { get; set; }
    }
}
