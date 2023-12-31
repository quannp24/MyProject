using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SRC003;

namespace QuizArenaBE.Services.SRC003
{
    public interface IDashboardService
    {
        public Task<IEnumerable<UserManager>> GetUserManager(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<IActionResult> UpdateUserExp(int userId, int expToAdd);
        public Task<IActionResult> UpdateUserRole(int userId, int newRoleId);
        public Task<IActionResult> GetUserDetails(int userId);
        public Task<IEnumerable<UserRecentActivity>> GetUsersRecentActivity(string searchTerm, int page, int pageSize);
        public Task<IEnumerable<UserRecentActivity>> GetUsersInfrequentActivity(string searchTerm, int page, int pageSize);
        public Task<IEnumerable<VIPMember>> GetVIPMembers(string searchTerm, int page, int pageSize);
        public Task<ResponseCommon> SendActivityReminderEmail();
        public Task<dynamic> GetNumberAllQuestion();
        public Task<ResponseCommon> SendInactiveUserInvitationEmail();
        public Task<ResponseCommon> SendCustomEmail(string userEmail, string subject, string content);
        public Task<IEnumerable<QuizManager>> GetQuizzesWithInfo(string? searchTerm = null, int? difficultyLevel = null, int? status = null, int page = 1, int pageSize = 10);
        public Task<IEnumerable<UserHistoryInfo>> GetUserHistory(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<IEnumerable<PaymentInfo>> GetPaymentsWithUsername(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<decimal> TotalSalesThisMonth();
        public Task<decimal> GetTotalSales();
        public Task<int> GetTotalUsersNoVip();
        public Task<int> GetTotalQuizlevel1();
        public Task<int> GetTotalQuizlevel2();
        public Task<int> GetTotalQuizlevel3();
        public Task<int> GetTotalUsers();
        public Task<int> GetTotalQuiz();
        public Task<int> GetTotalUsersVip();
        public Task<int[]> GetDailyMembersForMonth();
        public Task<decimal[]> GetDailySalesForMonth();

        public Task<object> GetCategory();
        public Task<ResponseCommon> AddCategory(CreateCategory createCategory);
        public Task<ResponseCommon> UpdateCategory(CreateCategory createCategory);
        public Task<IEnumerable<CategoryWithQuestionCount>> GetCategoriesByQuestionStatus(int? userId,int status);
        public Task<ResponseCommon> DeleteQuestion(int questionId);
        public Task<ResponseCommon> InsertPayment(int userId, PaymentModel request);
    }
}
