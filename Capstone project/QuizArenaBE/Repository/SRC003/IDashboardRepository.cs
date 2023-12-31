using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC003;
using DeleQuestion = QuizArenaBE.Entity.SRC003.DeleQuestion;

namespace QuizArenaBE.Repository.SRC003
{
    public interface IDashboardRepository
    {
        public Task<IEnumerable<UserManager>> GetUsersWithInfo(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<int> GetTotalUsers();
        public Task<int> GetTotalQuiz();
        public Task<int> GetTotalUsersVip();
        public Task<decimal> TotalSalesThisMonth();
        public Task<decimal> GetTotalSales();
        public Task<int> GetTotalUsersNoVip();
        public Task<int[]> GetDailyMembersForMonth();
        public Task<decimal[]> GetDailySalesForMonth();
        public Task<dynamic> GetNumberAllQuestion();

        public Task<IEnumerable<QuizManager>> GetQuizzesWithInfo(string? searchTerm = null, int? difficultyLevel = null, int? status = null, int page = 1, int pageSize = 10);

        public Task<int> GetTotalQuizlevel1();
        public Task<int> GetTotalQuizlevel2();
        public Task<int> GetTotalQuizlevel3();

        public Task<bool> UpdateUserExp(int userId, int expToAdd);
        public Task<bool> UpdateUserRole(int userId, int newRoleId);
        public Task<UserManager> GetUserDetails(int userId);

        public Task<IEnumerable<UserRecentActivity>> GetUsersRecentActivity(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<IEnumerable<UserRecentActivity>> GetUsersInfrequentActivity(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<IEnumerable<VIPMember>> GetVIPMembers(string searchTerm, int page, int pageSize);
        public Task<IEnumerable<UserHistoryInfo>> GetUserHistory(string? searchTerm = null, int page = 1, int pageSize = 10);
        public Task<IEnumerable<PaymentInfo>> GetPaymentsWithUsername(string? searchTerm = null, int page = 1, int pageSize = 10);

        public Task<List<Category>> GetCategory();
        public Task<Category> GetCategoryByName(string categoryName);
        public Task<bool> AddCategory(CreateCategory createCategory);
        public Task<bool> UpdateCategory(CreateCategory request);
        public Task<IEnumerable<CategoryWithQuestionCount>> GetCategoriesByQuestionStatus(int? userId, int status);
        public Task<DeleQuestion> GetQuestionById(int questionId);
        public Task<bool> CheckQuestionReferences(int questionId);
        public Task<bool> DeleteQuestion(int questionId);
        public Task<bool> InsertPayment(int userId, PaymentModel request);
    }
}
