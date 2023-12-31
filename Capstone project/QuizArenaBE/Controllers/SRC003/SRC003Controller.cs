using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC003;
using QuizArenaBE.Entity.Validation;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Repository.SRC003;
using QuizArenaBE.Services.SRC001;
using QuizArenaBE.Services.SRC002;
using QuizArenaBE.Services.SRC003;
using System;
using System.Collections.Generic;
using System.Data;

namespace QuizArenaBE.Controllers.SRC003
{
    [Route("api/controller")]
    [ApiController]
    public class SRC003Controller : ControllerBase
    {

        private readonly IDashboardRepository _dashboardRepository;
        private readonly IDashboardService _dashboardService;

        public SRC003Controller(IDashboardRepository dashboardRepository, IDashboardService dashboardService)
        {
            _dashboardRepository = dashboardRepository;
            _dashboardService = dashboardService;
        }

        // Trong User manager Controller
        [Authorize]
        [HttpGet("user-manager")]
        public async Task<IActionResult> GetUserManager([FromQuery] string? searchTerm = null, [FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            try
            {
                IEnumerable<UserManager> users;

                if (string.IsNullOrEmpty(searchTerm))
                {
                    // Truy vấn toàn bộ người dùng nếu không có điều kiện tìm kiếm
                    users = await _dashboardService.GetUserManager(page: page, pageSize: pageSize);
                }
                else
                {
                    // Truy vấn với điều kiện tìm kiếm nếu có
                    users = await _dashboardService.GetUserManager(searchTerm, page, pageSize);
                }

                return Ok(users);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [HttpGet("get-category")]
        public async Task<IActionResult> Getcategory()
        {
            try
            {
                var data = await _dashboardService.GetCategory();
                return Ok(data);
            }
            catch (Exception)
            {
                return StatusCode(500, new ResponseCommon("Error while retrieving dashboard statistics", false));

            }

        }

        [Authorize]
        [HttpGet("dashboard-statistics")]
        public async Task<IActionResult> GetDashboardStatistics()
        {
            try
            {
                var totalUsers = await _dashboardService.GetTotalUsers();
                var totalQuizzes = await _dashboardService.GetTotalQuiz();
                var totalUsersVip = await _dashboardService.GetTotalUsersVip();
                var totalSalesThisMonth = await _dashboardService.TotalSalesThisMonth();
                var totalSales = await _dashboardService.GetTotalSales();
                var totalUsersNoVip = await _dashboardService.GetTotalUsersNoVip();
                var TotalQuizlevel1 = await _dashboardService.GetTotalQuizlevel1();
                var TotalQuizlevel2 = await _dashboardService.GetTotalQuizlevel2();
                var TotalQuizlevel3 = await _dashboardService.GetTotalQuizlevel3();
                var dailyMembers = await _dashboardService.GetDailyMembersForMonth();
                var dailySales = await _dashboardService.GetDailySalesForMonth();
                var numQuestion = await _dashboardService.GetNumberAllQuestion();

                var dashboardStatistics = new DashboardStatistics
                {
                    TotalUsers = totalUsers,
                    TotalQuizzes = totalQuizzes,
                    TotalUsersVip = totalUsersVip,
                    TotalSalesThisMonth = totalSalesThisMonth,
                    TotalSales = totalSales,
                    TotalUsersNoVip = totalUsersNoVip,
                    TotalQuizlevel1 = TotalQuizlevel1,
                    TotalQuizlevel2 = TotalQuizlevel2,
                    TotalQuizlevel3 = TotalQuizlevel3,
                    DailyMembers = dailyMembers,
                    DailySales = dailySales,
                    numQuestion = numQuestion
                };

                return Ok(dashboardStatistics);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon<string>("", "Error while retrieving dashboard statistics", false));
            }
        }

        //quiz manager

        [Authorize]
        [HttpGet("quiz-manager")]
        public async Task<IActionResult> GetQuizManager([FromQuery] string? searchTerm = null, [FromQuery] int? difficultyLevel = null, [FromQuery] int? status = null, [FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            try
            {
                IEnumerable<QuizManager> quizzes;

                // Truy vấn quizzes với các điều kiện tìm kiếm
                quizzes = await _dashboardService.GetQuizzesWithInfo(
                    searchTerm,
                    difficultyLevel,
                    status,
                    page,
                    pageSize);

                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [Authorize]
        [HttpPut("update-user/{userId}")]
        public async Task<IActionResult> UpdateUser([FromRoute] int userId, [FromBody] UserUpdateRequest userUpdateRequest)
        {
            try
            {
                // Kiểm tra và thực hiện cập nhật điểm kinh nghiệm nếu được chỉ định
                if (userUpdateRequest.ExpToAdd.HasValue)
                {
                    await _dashboardService.UpdateUserExp(userId, userUpdateRequest.ExpToAdd.Value);
                }

                // Kiểm tra và thực hiện cập nhật vai trò người dùng nếu được chỉ định
                if (userUpdateRequest.NewRoleId.HasValue)
                {
                    await _dashboardService.UpdateUserRole(userId, userUpdateRequest.NewRoleId.Value);
                }

                return Ok(new ResponseCommon("User updated successfully", true));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpGet("user-manager/{userId}")]
        public async Task<IActionResult> GetUserDetails(int userId)
        {
            try
            {
                var result = await _dashboardService.GetUserDetails(userId);

                return result;
            }
            catch (Exception ex)
            {
                return new StatusCodeResult(500);
            }
        }

        [Authorize]
        [HttpGet("user-manager/recent-activity")]
        public async Task<IActionResult> GetUsersRecentActivity([FromQuery] string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {
                // Gọi phương thức từ DashboardService để lấy danh sách người dùng có hoạt động trong 14 ngày gần đây
                var recentActivity = await _dashboardService.GetUsersRecentActivity(searchTerm, page, pageSize);

                return Ok(recentActivity);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [Authorize]
        [HttpGet("user-manager/infrequent-activity")]
        public async Task<IActionResult> GetUsersInfrequentActivity([FromQuery] string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {
                // Gọi phương thức từ DashboardService để lấy danh sách người dùng có hoạt động trong 14 ngày gần đây
                var infrequentActivity = await _dashboardService.GetUsersInfrequentActivity(searchTerm, page, pageSize);

                return Ok(infrequentActivity);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

        [Authorize]
        [HttpPost("send-activity-reminder-email")]
        public async Task<IActionResult> SendActivityReminderEmail()
        {
            try
            {
                var response = await _dashboardService.SendActivityReminderEmail();
                if (response.Status)
                {
                    return Ok(response);
                }

                return BadRequest(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("send-inactive-user-invitation-email")]
        public async Task<IActionResult> SendInactiveUserInvitationEmail()
        {
            try
            {
                var response = await _dashboardService.SendInactiveUserInvitationEmail();
                if (response.Status)
                {
                    return Ok(response);
                }

                return BadRequest(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("vip-members")]
        public async Task<IActionResult> GetVIPMembers([FromQuery] string? searchTerm = null, [FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            try
            {
                // Gọi phương thức từ DashboardService để lấy danh sách thành viên mua gói VIP
                var vipMembers = await _dashboardService.GetVIPMembers(searchTerm, page, pageSize);

                return Ok(vipMembers);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }


        // Trong DashboardController class
        [Authorize]
        [HttpPost("send-custom-email")]
        public async Task<IActionResult> SendCustomEmail([FromBody] CustomEmailRequest request)
        {
            try
            {
                var response = await _dashboardService.SendCustomEmail(request.UserEmail, request.Subject, request.Content);
                if (response.Status)
                {
                    return Ok(response);
                }

                return BadRequest(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("user-history")]
        public async Task<IActionResult> GetUserHistory(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {
                var userHistory = await _dashboardService.GetUserHistory(searchTerm, page, pageSize);
                return Ok(userHistory);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("List-payments")]
        public async Task<IActionResult> GetPaymentsWithUsername([FromQuery] string? searchTerm = null, [FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            try
            {
                var payments = await _dashboardService.GetPaymentsWithUsername(searchTerm, page, pageSize);
                return Ok(payments);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("AddCategory")]
        public async Task<IActionResult> AddCategory([FromBody] CreateCategory createCategory)
        {
            try
            {
                var callService = await _dashboardService.AddCategory(createCategory);

                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("UpdateCategory")]
        public async Task<IActionResult> UpdateCategory([FromBody] CreateCategory createCategory)
        {
            try
            {
                var callService = await _dashboardService.UpdateCategory(createCategory);

                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("categories-by-status")]
        public async Task<IActionResult> GetCategoriesByQuestionStatus([FromQuery] int status,int? userId)
        {
            try
            {

                var categories = await _dashboardService.GetCategoriesByQuestionStatus(userId, status);

                return Ok(categories);
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo ý bạn và trả về lỗi hoặc log lại
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("DeleteQuestion")]
        public async Task<IActionResult> DeleteQuestion([FromQuery] int questionId)
        {
            try
            {
                // Gọi phương thức từ _dashboardService để xóa câu hỏi
                var deleteResult = await _dashboardService.DeleteQuestion(questionId);

                if (!deleteResult.Status)
                {
                    return BadRequest(deleteResult);
                }

                return Ok(deleteResult);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("InsertPayment")]
        public async Task<IActionResult> InsertPayment([FromBody] PaymentModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var callService = await _dashboardService.InsertPayment(userId.Value, request);

                if (!callService.Status)
                {
                    return BadRequest(callService);
                }

                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


    }
}
