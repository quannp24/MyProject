using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC002;
using QuizArenaBE.Entity.Validation;
using System.ComponentModel.DataAnnotations;
using static QuizArenaBE.Entity.SRC002.InsertQuizReq;

namespace QuizArenaBE.Controllers.SRC002
{
    [Route("api/[controller]")]
    [ApiController]
    public class SRC002Controller : ControllerBase // Đã chỉnh sửa tên của controller thành "LoginController"
    {
        private readonly IQuizService _quizService;

        public SRC002Controller(IQuizService quizService)
        {
            _quizService = quizService;
        }

        [Authorize]
        [HttpGet("GetQuiz")]
        public async Task<IActionResult> GetDataQuiz([FromQuery] int quizId)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.GetQuiz(quizId, userId.Value);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("AddQuiz")]
        public async Task<IActionResult> InsertDataQuiz([FromBody] InsertQuizReq request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.AddQuiz(userId.Value, request);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("GetQuestionsRandom")]
        public async Task<IActionResult> GetQuestionsRandom([FromQuery] GetQuestionsRandomReq req)
        {
            try
            {

                var callService = await _quizService.GetQuestionsRandom(req);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("GetQuizRecentPopular")]
        public async Task<IActionResult> GetQuizRecentPopular()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.GetQuizRecentPopular(userId.Value);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("get-infor-do-quiz")]
        public async Task<IActionResult> GetInforDoQuiz([FromQuery] string roomId)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.GetInforRoomQuiz(userId.Value, roomId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpPost("create-room-quiz-friends")]
        public async Task<IActionResult> CreateRoomQuiz([FromBody] CreateRoomReq quiz)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.AddRoomQuiz(quiz.quizId, userId.Value);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpPost("Friend-Join-Room-Quiz")]
        public async Task<IActionResult> FriendJoinRoomQuiz([FromBody] RoomUserQuiz room)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var callService = await _quizService.FriendJoinRoomQuiz(room.roomId, userId.Value, room.quizId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("Delete-Room-Quiz-User")]
        public async Task<IActionResult> DeleteRoomQuizUser([FromBody] RoomUserQuiz room)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.DeleteRoomQuizUser(room.roomId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("get-achievements-user")]
        public async Task<IActionResult> GetAchievementsUser([FromQuery] int userId)
        {
            try
            {

                // Gọi phương thức từ QuizService để lấy thông tin đề thi
                var callService = await _quizService.GetAchievementsUser(userId);

                if (callService == null)
                {
                    return NotFound(new ResponseCommon("false", false));
                }

                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("Get-Exam-Info")]
        public async Task<IActionResult> GetExamInfo()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                var callService = await _quizService.GetExamInfo(userId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("Update-Quiz")]
        public async Task<IActionResult> UpdateQuiz([FromBody] UpdateQuizModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.UpdateQuiz(request, (int)userId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("Update-Quiz-Private")]
        public async Task<IActionResult> UpdateQuizPrivate([FromBody] UpdateQuizModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.UpdateQuizPrivate(request, (int)userId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("Get-Quiz-For-Mod")]
        public async Task<IActionResult> GetQuizForMod()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.GetQuizForMod();
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [HttpGet("GetActiveQuizzes")]
        public async Task<IActionResult> GetActiveQuizzes()
        {
            try
            {
                var quizzes = await _quizService.GetActiveQuizzes();
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpDelete("delete-quiz")]
        public async Task<IActionResult> DeleteQuiz([FromQuery] int quizId, int quiz_type)
        {
            try
            {
                // Gọi phương thức từ QuizService để xóa Quiz
                var response = await _quizService.DeleteQuiz(quizId, quiz_type);

                if (!response.Status)
                {

                    return BadRequest(response);
                }
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPut("change-quiz-status")]
        public async Task<IActionResult> ChangeQuizStatus([FromBody] UpdateStatusQuiz quizStatus)
        {
            try
            {
                var response = await _quizService.ChangeQuizStatus(quizStatus);

                if (response.Status)
                {
                    return Ok(response);
                }
                else
                {
                    return BadRequest(response);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("Insert-Exam-User")]
        public async Task<IActionResult> InsertExamUser([FromBody] InsertExamUserModel req)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.InsertExamUser(req, (int)userId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("unapproved-quizzes")]
        public async Task<IActionResult> GetUnapprovedQuizzes(int page = 1, int pageSize = 10, string? searchTerm = null)
        {
            try
            {
                var quizzes = await _quizService.GetQuizzesByStatus(new List<int> { 2 }, page, pageSize, searchTerm);
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("approved-quizzes")]
        public async Task<IActionResult> GetApprovedQuizzes(int page = 1, int pageSize = 10, string? searchTerm = null)
        {
            try
            {
                var quizzes = await _quizService.GetQuizzesByStatus(new List<int> { 1, 3 }, page, pageSize, searchTerm);
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("quizzes-by-category/{categoryId}")]
        public async Task<IActionResult> GetQuizzesByCategoryAndStatus(int categoryId)
        {
            try
            {
                var quizzes = await _quizService.GetQuizzesByCategoryAndStatus(categoryId);
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("quizzes-by-staff-and-status")]
        public async Task<IActionResult> GetQuizzesByStaffAndStatus()
        {
            try
            {
                var userId = (int)HttpContext.Items["userId"];
                var response = await _quizService.GetQuizzesByStaffAndStatus(userId);

                if (response != null)
                {
                    return Ok(response);
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("list-exam")]
        public async Task<IActionResult> GetExamList()
        {
            try
            {
                var exams = await _quizService.GetExamList();
                return Ok(exams);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("CreateExam")]
        public async Task<IActionResult> CreateExam([FromBody] ExamModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var callService = await _quizService.CreateExam(
                    request.ExamName,
                    request.QuizId,
                    request.Description,
                    request.Image,
                    request.ExamType,
                    request.Date
                    );

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

        [Authorize]
        [HttpPost("EditExam")]
        public async Task<IActionResult> EditExam([FromBody] ExamModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var callService = await _quizService.EditExam(
                    request.ExamId,
                    request.ExamName,
                    request.QuizId,
                    request.Description,
                    request.Image,
                    request.ExamType,
                    request.Date
                    );

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

        [Authorize]
        [HttpDelete("delete-exam/{examId}")]
        public async Task<IActionResult> DeleteExam([FromRoute] string examId)
        {
            try
            {
                // Gọi phương thức từ QuizService để xóa đề thi
                var response = await _quizService.DeleteExam(examId);

                if (!response.Status)
                {
                    return BadRequest(response);
                }
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPut("change-exam-status/{examId}/{newStatus}")]
        public async Task<IActionResult> ChangeExamStatus([FromRoute] string examId, [FromRoute] int newStatus)
        {
            try
            {
                // Gọi phương thức từ QuizService để thay đổi trạng thái của đề thi
                var response = await _quizService.ChangeExamStatus(examId, newStatus);

                if (!response.Status)
                {
                    return BadRequest(response);
                }
                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("get-infor-lobby")]
        public async Task<IActionResult> GetInforLobby([FromQuery] string examid)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.GetInforLobby(examid, (int)userId);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPost("update-status-score-user-exam")]
        public async Task<IActionResult> UpdateUserExam([FromBody] UpdateUserExam request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.UpdateUserExam(request.examId, (int)userId, request.score);
                if (!callService.Status)
                    return BadRequest(callService);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("GetQuizzesByTypeAndStatus")]
        public async Task<IActionResult> GetQuizzesByTypeAndStatus()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var quizzes = await _quizService.GetQuizzesByTypeAndStatus(2, 1);

                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("GetExamById")]
        public async Task<IActionResult> GetExamById(string examId)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                // Gọi phương thức từ QuizService để lấy thông tin đề thi
                var exam = await _quizService.GetListExamById(examId);

                if (exam == null)
                {
                    return NotFound(new ResponseCommon($"Exam with the ID {examId} does not exist.", false));
                }

                return Ok(exam);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [HttpGet("get-infor-challenge-detail")]
        public async Task<IActionResult> GetInforChallengeDetail([FromQuery] string examId)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];

                // Gọi phương thức từ QuizService để lấy thông tin đề thi
                var callService = await _quizService.GetInforChallengeDetail(examId, userId);

                if (callService == null)
                {
                    return NotFound(new ResponseCommon("false", false));
                }

                return Ok(new ResponseCommon<object>(callService));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("user-do-today")]
        public async Task<IActionResult> CountUserDoQuiz([FromQuery] int quizId)
        {
            try
            {
                var callService = await _quizService.CountUserDoQuiz(quizId);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPut("update-finish-challenge")]
        public async Task<IActionResult> UpdateFinishChallenge([FromQuery] string examId)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _quizService.UpdateFinishChallenge(examId, userId.Value);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpPost("AddQuestions")]
        public async Task<IActionResult> AddQuestions([FromBody] QuestionModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                // Gọi phương thức từ QuizService để thêm câu hỏi
                var callService = await _quizService.AddQuestions(userId.Value, request);

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

        [HttpGet("get-list-quiz-user")]
        public async Task<IActionResult> GetListQuiz([FromQuery] int userId)
        {
            try
            {
                var callService = await _quizService.GetListQuiz(userId);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPut("EditQuestions")]
        public async Task<IActionResult> EditQuestions([FromBody] QuestionModel request)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }

                var callService = await _quizService.EditQuestions(userId.Value, request);

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

        [Authorize]
        [HttpPut("ChangeQuestionStatus")]
        public async Task<IActionResult> ChangeQuestionStatus([FromBody] ChangeQuestionStatusRequest request)
        {
            try
            {
                var callService = await _quizService.ChangeQuestionStatus(request);

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

        [Authorize]
        [HttpGet("GetQuestionsByCategory")]
        public async Task<IActionResult> GetQuestionsByCategory([FromQuery] int categoryId, int status, int? userId)
        {
            try
            {
                var questions = await _quizService.GetQuestionsByCategory(categoryId, status,userId);

                if (questions == null || questions.Count() == 0)
                {
                    return Ok(new ResponseCommon<object>(null, "No data.", true));
                }

                return Ok(new ResponseCommon<object>(questions, "Get list success.", true));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("GetQuestionsByCategoryAndSearchPage")]
        public async Task<IActionResult> GetQuestionsByCategoryAndSearchPage([FromHeader] int categoryId, [FromHeader] int status, [FromHeader] string? searchTerm = null, [FromHeader] int page = 1, [FromHeader] int pageSize = 10)
        {
            try
            {
                var questions = await _quizService.GetQuestionsByCategoryAndSearchPage(categoryId, status, searchTerm, page, pageSize);

                if (questions == null || questions.Count() == 0)
                {
                    return Ok(new ResponseCommon<object>(null, "No data.", true));
                }

                return Ok(new ResponseCommon<object>(questions, "Get list success.", true));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


    }
}
