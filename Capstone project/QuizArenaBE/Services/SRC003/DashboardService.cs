using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC003;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Repository.SRC003;
using QuizArenaBE.Services.Common;

namespace QuizArenaBE.Services.SRC003
{
    public class DashboardService : IDashboardService
    {
        private readonly IDashboardRepository _dashboardRepository;
        private readonly ICRUDcommon _crudCommon;
        private readonly ICommon _common;
        private readonly IConfiguration _configuration;
        private readonly IUserRepository _userRepository;

        public DashboardService(IDashboardRepository dashboardRepository, IConfiguration configuration, ICommon common, ICRUDcommon crudCommon, IUserRepository userRepository)
        {
            _dashboardRepository = dashboardRepository;
            _configuration = configuration;
            _common = common;
            _crudCommon = crudCommon;
            _userRepository = userRepository;
        }

        public async Task<IEnumerable<UserManager>> GetUserManager(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {
                IEnumerable<UserManager> users;

                if (string.IsNullOrEmpty(searchTerm))
                {
                    // Truy vấn toàn bộ người dùng nếu không có điều kiện tìm kiếm
                    users = await _dashboardRepository.GetUsersWithInfo(page: page, pageSize: pageSize);
                }
                else
                {
                    // Truy vấn với điều kiện tìm kiếm nếu có
                    users = await _dashboardRepository.GetUsersWithInfo(searchTerm, page, pageSize);
                }

                return users;
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn
                throw;
            }
        }

        public async Task<IActionResult> UpdateUserExp(int userId, int expToAdd)
        {
            try
            {
                var result = await _dashboardRepository.UpdateUserExp(userId, expToAdd);

                if (result)
                {
                    return new OkObjectResult(new ResponseCommon("User's exp has been updated successfully!", true));
                }
                else
                {
                    return new BadRequestObjectResult(new ResponseCommon("Unable to update user's exp. Please check the information and try again.", false));
                }
            }
            catch (Exception ex)
            {
                return new StatusCodeResult(500);
            }
        }

        public async Task<IActionResult> UpdateUserRole(int userId, int newRoleId)
        {
            try
            {
                var result = await _dashboardRepository.UpdateUserRole(userId, newRoleId);

                if (result)
                {
                    return new OkObjectResult(new ResponseCommon("User's role has been updated successfully!", true));
                }
                else
                {
                    return new BadRequestObjectResult(new ResponseCommon("Unable to update user's role. Please check the information and try again.", false));
                }
            }
            catch (Exception ex)
            {
                return new StatusCodeResult(500);
            }
        }

        public async Task<IActionResult> GetUserDetails(int userId)
        {
            try
            {
                // Gọi phương thức từ repository để lấy thông tin chi tiết của người dùng
                var userDetails = await _dashboardRepository.GetUserDetails(userId);

                if (userDetails != null)
                {
                    return new OkObjectResult(userDetails);
                }
                else
                {
                    return new NotFoundObjectResult(new ResponseCommon("User details not found.", false));
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc thông báo lỗi nếu cần
                return new StatusCodeResult(500);
            }
        }

        public async Task<IEnumerable<UserRecentActivity>> GetUsersRecentActivity(string searchTerm, int page, int pageSize)
        {
            try
            {
                var recentActivity = await _dashboardRepository.GetUsersRecentActivity(searchTerm, page, pageSize);

                return recentActivity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<UserRecentActivity>> GetUsersInfrequentActivity(string searchTerm, int page, int pageSize)
        {
            try
            {
                var recentActivity = await _dashboardRepository.GetUsersInfrequentActivity(searchTerm, page, pageSize);

                return recentActivity;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<VIPMember>> GetVIPMembers(string searchTerm, int page, int pageSize)
        {
            try
            {
                // Gọi phương thức từ DashboardRepository để lấy danh sách thành viên mua gói VIP
                var vipMembers = await _dashboardRepository.GetVIPMembers(searchTerm, page, pageSize);

                return vipMembers;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<PaymentInfo>> GetPaymentsWithUsername(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {
                // Gọi phương thức từ DashboardRepository để lấy danh sách thành viên mua gói VIP
                var getPayment = await _dashboardRepository.GetPaymentsWithUsername(searchTerm, page, pageSize);

                return getPayment;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> SendActivityReminderEmail()
        {
            try
            {
                // Call the UserRepository method to get a list of users who have been active in the last 14 days
                var activeUsers = await _dashboardRepository.GetUsersRecentActivity();

                // Loop through the list and send emails
                foreach (var user in activeUsers)
                {
                    // Create the email content according to your needs
                    string emailSubject = "Thank You for Your Active Participation";
                    string emailBody = $"Dear {user.Fullname}," +
                        $"\n\nWe sincerely appreciate your active participation on our platform. Your contributions make QuizArena a vibrant community!" +
                        $"\n\nAs a friendly reminder, maintaining activity helps you fully enjoy the QuizArena experience. Keep up the great work!" +
                        $"\n\nThank you for being a valuable member of QuizArena." +
                        $"\n\nBest regards," +
                        $"\nThe QuizArena Team" +
                        $"\n\nP.S. Explore more on QuizArena: [QuizArena Home](http://quizarena.asia/home)";

                    // Send the email
                    await _common.SendMail(user.Email, emailSubject, emailBody);
                }

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }




        public async Task<ResponseCommon> SendInactiveUserInvitationEmail()
        {
            try
            {
                // Call the UserRepository method to get a list of users who haven't been online in the last 14 days
                var inactiveUsers = await _dashboardRepository.GetUsersInfrequentActivity();

                // Loop through the list and send emails
                foreach (var user in inactiveUsers)
                {
                    // Create the email content to invite users back
                    string emailSubject = "We Missed You on QuizArena!";
                    string emailBody = $"Dear {user.Fullname}," +
                        $"\n\nIt's been a while since we've seen you on QuizArena, and we miss having you with us!" +
                        $"\n\nOur platform has grown, and exciting new quizzes are waiting for you. We invite you to come back, participate, and explore the world of knowledge and fun quizzes." +
                        $"\n\nYour contributions make QuizArena special, and we'd love to have you engaged once again." +
                        $"\n\nClick here to return to QuizArena: [QuizArena Home](http://quizarena.asia/home)" +
                        $"\n\nWe look forward to seeing you back!" +
                        $"\n\nSincerely," +
                        $"\nThe QuizArena Team";

                    // Send the email
                    await _common.SendMail(user.Email, emailSubject, emailBody);
                }

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        // Thêm tham số content vào hàm SendCustomEmail
        public async Task<ResponseCommon> SendCustomEmail(string userEmail, string subject, string content)
        {
            try
            {
                // Tạo nội dung email bằng cách kết hợp phần cố định và phần nội dung do người dùng nhập
                string emailBody = $"Dear {userEmail},\n\n{content}\n\nSincerely,\n\nThe QuizArena Team";

                // Gửi email
                await _common.SendMail(userEmail, subject, emailBody);

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> InsertPayment(int userId, PaymentModel request)
        {
            try
            {
                // Gọi phương thức từ QuizRepository để chèn thanh toán mới
                var status = await _dashboardRepository.InsertPayment(userId, request);

                if (!status)
                {
                    return new ResponseCommon("Insert payment failed.", false);
                }

                return new ResponseCommon("Payment has been successfully inserted.", true);
            }
            catch (Exception ex)
            {
                return new ResponseCommon(ex.Message, false);
            }
        }



        public async Task<IEnumerable<QuizManager>> GetQuizzesWithInfo(string? searchTerm = null, int? difficultyLevel = null, int? status = null, int page = 1, int pageSize = 10)
        {
            try
            {
                // Gọi hàm từ _dashboardRepository để lấy danh sách quizzes với thông tin của người tạo quiz
                var quizzes = await _dashboardRepository.GetQuizzesWithInfo(searchTerm, difficultyLevel, status, page, pageSize);

                return quizzes;
            }
            catch (Exception ex)
            {
                // Xử lý nếu có lỗi và thông báo lỗi hoặc log lại lỗi
                throw ex;
            }
        }

        public async Task<IEnumerable<UserHistoryInfo>> GetUserHistory(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            return await _dashboardRepository.GetUserHistory(searchTerm, page, pageSize);
        }


        public async Task<decimal> TotalSalesThisMonth()
        {
            try
            {
                // Logic tính tổng doanh số bán trong tháng hiện tại
                decimal totalSales = await _dashboardRepository.TotalSalesThisMonth();

                return totalSales;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<decimal> GetTotalSales()
        {
            try
            {
                // Logic tính tổng doanh số bán
                decimal totalSales = await _dashboardRepository.GetTotalSales();

                return totalSales;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int[]> GetDailyMembersForMonth()
        {
            // Gọi phương thức từ DashboardRepository
            return await _dashboardRepository.GetDailyMembersForMonth();
        }

        public async Task<decimal[]> GetDailySalesForMonth()
        {
            // Gọi phương thức từ DashboardRepository
            return await _dashboardRepository.GetDailySalesForMonth();
        }


        public async Task<int> GetTotalUsersNoVip()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int totalUsersNoVip = await _dashboardRepository.GetTotalUsersNoVip();

                return totalUsersNoVip;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int> GetTotalQuizlevel1()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int TotalQuizlevel1 = await _dashboardRepository.GetTotalQuizlevel1();

                return TotalQuizlevel1;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int> GetTotalQuizlevel2()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int TotalQuizlevel2 = await _dashboardRepository.GetTotalQuizlevel2();

                return TotalQuizlevel2;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int> GetTotalQuizlevel3()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int TotalQuizlevel3 = await _dashboardRepository.GetTotalQuizlevel3();

                return TotalQuizlevel3;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int> GetTotalUsers()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int totalUsers = await _dashboardRepository.GetTotalUsers();

                return totalUsers;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<int> GetTotalQuiz()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int totalQuizzes = await _dashboardRepository.GetTotalQuiz();

                return totalQuizzes;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }
        public async Task<int> GetTotalUsersVip()
        {
            try
            {
                // Logic tính tổng doanh số bán
                int totalUsersVip = await _dashboardRepository.GetTotalUsersVip();

                return totalUsersVip;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }


        public async Task<object> GetCategory()
        {
            try
            {
                // Gọi phương thức từ DashboardRepository để lấy danh sách thành viên mua gói VIP
                var data = await _dashboardRepository.GetCategory();
                if (data.Count == 0)
                {
                    return new ResponseCommon("can't get category", false);
                }
                return new ResponseCommon<object>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> AddCategory(CreateCategory createCategory)
        {
            try
            {
                // Kiểm tra xem danh mục có tồn tại chưa
                var existingCategory = await _dashboardRepository.GetCategoryByName(createCategory.CategoryName);
                if (existingCategory != null)
                {
                    // Trả về lỗi nếu danh mục đã tồn tại
                    return new ResponseCommon($"Category '{createCategory.CategoryName}' already exists.", false);
                }

                // Thực hiện thêm danh mục mới
                var result = await _dashboardRepository.AddCategory(createCategory);

                if (result)
                {
                    return new ResponseCommon($"Category '{createCategory.CategoryName}' has been added successfully!", true);
                }
                else
                {
                    return new ResponseCommon("Unable to add category. Please check the information and try again.", false);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn và trả về lỗi hoặc log lại
                return new ResponseCommon(ex.Message, false);
            }
        }

        public async Task<ResponseCommon> UpdateCategory(CreateCategory createCategory)
        {
            try
            {
                // Thực hiện thêm danh mục mới
                var result = await _dashboardRepository.UpdateCategory(createCategory);

                if (result)
                {
                    return new ResponseCommon($"Update '{createCategory.CategoryName}' has been updated successfully!", true);
                }
                else
                {
                    return new ResponseCommon("Unable to add category. Please check the information and try again.", false);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn và trả về lỗi hoặc log lại
                throw ex;
            }
        }

        public async Task<IEnumerable<CategoryWithQuestionCount>> GetCategoriesByQuestionStatus(int? userId, int status)
        {
            try
            {
                var categories = await _dashboardRepository.GetCategoriesByQuestionStatus(userId, status);

                return categories;
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn và trả về lỗi hoặc log lại
                throw ex;
            }
        }


        public async Task<dynamic> GetNumberAllQuestion()
        {
            try
            {
                var result = await _dashboardRepository.GetNumberAllQuestion();

                return result;
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn và trả về lỗi hoặc log lại
                throw ex;
            }
        }

        public async Task<ResponseCommon> DeleteQuestion(int questionId)
        {
            try
            {
                // Kiểm tra xem câu hỏi có tồn tại không và trạng thái có phải là 4 không
                var existingQuestion = await _dashboardRepository.GetQuestionById(questionId);

                if (existingQuestion != null && existingQuestion.Status == 4)
                {
                    // Kiểm tra xem có liên kết từ bảng QuestionsAttempts không
                    var hasReferences = await _dashboardRepository.CheckQuestionReferences(questionId);

                    if (hasReferences)
                    {
                        return new ResponseCommon("Unable to delete question. There are references from the QuestionsAttempts table.", false);
                    }

                    // Gọi phương thức từ QuizRepository để xóa câu hỏi
                    var result = await _dashboardRepository.DeleteQuestion(questionId);

                    if (result)
                    {
                        return new ResponseCommon("Question has been deleted successfully!", true);
                    }
                    else
                    {
                        return new ResponseCommon("Unable to delete question. Please check the information and try again.", false);
                    }
                }
                else
                {
                    return new ResponseCommon("Question not found or the status is not 4.", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
