namespace QuizArenaBE.Entity.SRC003
{
    public class DashboardStatistics
    {
        public int TotalUsers { get; set; }
        public int TotalQuizzes { get; set; }
        public int TotalUsersVip { get; set; }
        public decimal TotalSalesThisMonth { get; set; }
        public decimal TotalSales { get; set; }
        public int TotalUsersNoVip { get; set; }
        public int TotalQuizlevel1 { get; set; }
        public int TotalQuizlevel2 { get; set; }
        public int TotalQuizlevel3 { get; set; }
        public int[] DailyMembers { get; set; }
        public decimal[] DailySales { get; set; }
        public dynamic numQuestion { get; set; }
    }
}
