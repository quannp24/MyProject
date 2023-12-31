using QuizAndFriends.Services.Common;
using QuizArenaBE.Services.Common;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;
using System.Security.Cryptography;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC002;
using static QuizArenaBE.Entity.SRC002.QuizModel;
using System.Data;
using System.Data.SqlClient;
using Dapper;
using QuizArenaBE.Repository.SRC002;
using static QuizArenaBE.Entity.SRC002.InsertQuizReq;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Repository.Hub;
using System;

namespace QuizArenaBE.Services.SRC002
{
    public class QuizService : IQuizService
    {
        private readonly IQuizRepository _quizrRepository;
        private readonly IUserRepository _userRepository;
        private readonly IHubRepostiory _hubRepostiory;

        public QuizService(IQuizRepository quizrRepository, IUserRepository userRepository, IHubRepostiory hubRepostiory)
        {
            _quizrRepository = quizrRepository;
            _userRepository = userRepository;
            _hubRepostiory = hubRepostiory;
        }

        #region method public


        public async Task<ResponseCommon<QuizModel>> GetQuiz(int quizId, int userId)
        {
            try
            {
                var quizzes = await _quizrRepository.GetDataQuiz(quizId, userId);
                if (quizzes == null || quizzes.quizz == null || quizzes.questions == null || quizzes.questions.Count == 0)
                {
                    return new ResponseCommon<QuizModel>(quizzes, "Not found", false);
                }

                foreach (var item in quizzes.questions)
                {
                    var SplitOptions = item.Options.Split("|");
                    item.OptionsSRC002 = SplitOptions;
                }

                var historyUser = await _userRepository.GetHistoryUser(quizId, userId);
                if (historyUser != null)
                {
                    var checkUpdateExpUser = historyUser.Any(x => x.DateAction.Day == DateTime.Now.Day);
                    quizzes.CheckUpEXP = checkUpdateExpUser ? false : true;
                }

                if (quizzes.quizz.CreatorId == userId)
                {
                    quizzes.quizz.isFriendCreator = 1;
                }

                return new ResponseCommon<QuizModel>(quizzes);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> AddQuiz(int userId, InsertQuizReq request)
        {
            try
            {

                var statusInsert = _quizrRepository.InsertDataQuiz(userId, request);

                if (!statusInsert.Result)
                {
                    return new ResponseCommon("add quiz fail", false);
                }

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<List<object>>> GetQuestionsRandom(GetQuestionsRandomReq req)
        {
            try
            {

                var dataQuizs = await _quizrRepository.GetRandomQuestions(req.Lvl1, req.category, 1);
                dataQuizs.AddRange(await _quizrRepository.GetRandomQuestions(req.Lvl2, req.category, 2));
                dataQuizs.AddRange(await _quizrRepository.GetRandomQuestions(req.Lvl3, req.category, 3));
                if (dataQuizs.Count == 0)
                {
                    return new ResponseCommon<List<object>>(dataQuizs, "not found", false);
                }

                return new ResponseCommon<List<object>>(dataQuizs);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetQuizRecentPopular(int userId)
        {
            try
            {
                var dataRecent = await _quizrRepository.GetDataQuizRecent(userId);

                var dataPopular = await _quizrRepository.GetDataQuizPopular();

                var dataExamRecent = await _quizrRepository.GetDataExamRecent();

                if (dataRecent == null && dataPopular == null)
                {
                    return new ResponseCommon<object>(null, "not found", false);
                }
                var result = new
                {
                    QuizRecentOfUser = dataRecent,
                    DataPopular = dataPopular,
                    ExamRecent = dataExamRecent
                };
                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetInforRoomQuiz(int userId, string roomId)
        {

            try
            {
                var data = await _quizrRepository.GetUserDoQuiz(userId, roomId);
                var data1 = await _quizrRepository.GetUsersInRoom(roomId, userId);

                if (data == null || data1 == null)
                {
                    return new ResponseCommon<object>(null, "not found", false);
                }

                var result = new
                {
                    UserDoQuiz = data,
                    UsersInRoom = data1,
                };
                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<object> GetListQuiz(int userId)
        {
            try
            {
                var data = await _quizrRepository.GetListQuiz(userId);
                if (data == null)
                {
                    return new ResponseCommon<object>(null, "Not found", true);
                }
                return new ResponseCommon<object>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> AddRoomQuiz(int quizId, int userId)
        {

            try
            {
                var roomId = await GenerateRoomId();
                if (roomId == null || roomId.Length < 1)
                {
                    return new ResponseCommon<object>(null, "Generate room id fail.", false);
                }

                await _hubRepostiory.CreateRoom(userId, roomId, quizId); // tạo phòng cho user đó với role là 1

                return new ResponseCommon<object>(roomId, "Create room success.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public async Task<ResponseCommon<object>> FriendJoinRoomQuiz(string roomId, int userId, int quizId)
        {

            try
            {
                var data = await _quizrRepository.CheckFriendInBossRoom(userId, roomId, quizId);
                if (data == 1) //nếu là bạn bè vào phòng cho vào phòng và thêm bạn bè vào UserRoomQuiz với role là 0
                {
                    var result = await _quizrRepository.InsertUserRoomQuiz(userId, roomId);
                    if (result == 0)
                    {
                        return new ResponseCommon<object>(null, "Can't insert Database.", false);
                    }
                    return new ResponseCommon<object>(true, "Check is friend and insert success.", true);

                }
                if (data == 2) //nếu là chủ phòng thì cho vào phòng
                {
                    return new ResponseCommon<object>(true, "Check success.", true);
                }
                return new ResponseCommon<object>(false, "Not permission join room.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> DeleteRoomQuizUser(string roomId)
        {

            try
            {
                var data = await _quizrRepository.DeleteRoomQuizUser(roomId);
                if (data == 0)
                {
                    return new ResponseCommon("Can't delete", false);
                }
                return new ResponseCommon("deleted.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetAchievementsUser(int userId)
        {
            try
            {
                ExamInfoUserModel? data1 = await _quizrRepository.GetExamInfoUser(userId);

                if (data1 == null)
                {
                    return new ResponseCommon<object>(null, "not found data", true);

                }
                return new ResponseCommon<object>(data1, "", true);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetExamInfo(int? userId)
        {

            try
            {
                var data = await _quizrRepository.GetExamListTop();
                var data2 = await _quizrRepository.GetExamToWeek();
                var data3 = await _quizrRepository.GetExamTop3User();
                ExamInfoUserModel? data1 = null;
                var data4 = false;
                if (userId is not null)
                {
                    data1 = await _quizrRepository.GetExamInfoUser(userId.Value);
                    data4 = await _quizrRepository.CheckUserInExamUser(data2 != null ? data2.examId : null, userId.Value);
                }



                var output = new
                {
                    ExamToWeek = data2,
                    ExamInfoUser = data1,
                    ExamTop3User = data3,
                    ExamListTop = data,
                    userCanJoin = data4
                };
                return new ResponseCommon<object>(output, "", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> UpdateQuiz(UpdateQuizModel request, int userId)
        {
            try
            {
                var count = await _quizrRepository.UpdateQuiz(request, userId);
                if (count == 0)
                {
                    return new ResponseCommon<object>(count, "not update", false);
                }
                return new ResponseCommon<object>(count, "update success", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> UpdateQuizPrivate(UpdateQuizModel request, int userId)
        {
            try
            {
                var count = await _quizrRepository.UpdateQuizPrivate(request, userId);
                if (count == 0)
                {
                    return new ResponseCommon<object>(count, "not update", false);
                }
                return new ResponseCommon<object>(count, "update success", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetQuizForMod()
        {
            try
            {
                var count = await _quizrRepository.GetQuizForMod();
                if (count == null)
                {
                    return new ResponseCommon<object>(count, "not find", false);
                }
                return new ResponseCommon<object>(count);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<List<ActiveQuiz>>> GetActiveQuizzes()
        {
            try
            {
                var quizzes = await _quizrRepository.GetActiveQuizzes();
                return new ResponseCommon<List<ActiveQuiz>>(quizzes);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> DeleteQuiz(int quizId, int quiz_type)
        {
            try
            {
                // Call the method from QuizRepository to check and delete the Quiz if possible
                var deleted = await _quizrRepository.DeleteQuiz(quizId, quiz_type);

                if (deleted > 0)
                {
                    return new ResponseCommon("Quiz has been deleted successfully.", true);
                }
                else
                {
                    return new ResponseCommon("Unable to delete approved Quiz or Quiz not found.", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> ChangeQuizStatus(UpdateStatusQuiz request)
        {
            try
            {
                // Lấy thông tin quiz hiện tại
                var quizInfo = await _quizrRepository.GetActiveQuizById(request.quizId);

                if (quizInfo == null)
                {
                    return new ResponseCommon("Not found Quizz", false);
                }


                // Gọi repository để cập nhật trạng thái quiz
                var result = await _quizrRepository.UpdateQuizStatus(request);
                if (request.status == 1)
                {
                    await _userRepository.InsertNotification(quizInfo.CreatorId.Value, "Your quiz is approved", $"/edit-quiz-staff/{quizInfo.QuizId}");
                }

                if (result)
                {
                    return new ResponseCommon($"Status changed.", true);
                }
                else
                {
                    return new ResponseCommon("Update failed quiz status.", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> InsertExamUser(InsertExamUserModel req, int userId)
        {
            try
            {
                // Call the method from QuizRepository to check and delete the Quiz if possible
                var count = await _quizrRepository.InsertExamUser(req, userId);

                if (count == 0)
                {
                    return new ResponseCommon("Not insert", false);
                }
                return new ResponseCommon("Insert done");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizA>> GetQuizzesByStatus(List<int> status, int page = 1, int pageSize = 10, string? searchTerm = null)
        {
            try
            {
                var quizzes = await _quizrRepository.GetQuizzesByStatus(status, page, pageSize, searchTerm);
                return quizzes;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizCategory>> GetQuizzesByCategoryAndStatus(int categoryId)
        {
            try
            {
                // Gọi repository để lấy danh sách quiz theo category và status
                var quizzes = await _quizrRepository.GetQuizzesByCategoryAndStatus(categoryId);
                return quizzes;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<ExamModel>> GetExamList()
        {
            try
            {
                // Gọi repository để lấy danh sách quiz theo category và status
                var exam = await _quizrRepository.GetExamList();
                return exam;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> CreateExam(string examName, int quizId, string description, string image, int examType, DateTime date)
        {
            try
            {
                string examId;
                bool isUnique = false;

                // Lặp để tạo mã đề thi duy nhất
                do
                {
                    // Tạo mã đề thi tự động với chiều dài tối đa là 10 ký tự
                    examId = _quizrRepository.GenerateUniqueExamId();

                    // Kiểm tra xem đề thi với ID đã tồn tại chưa
                    var existingExam = await _quizrRepository.GetExamById(examId);
                    isUnique = existingExam == null;

                } while (!isUnique);

                // Gọi phương thức từ QuizRepository để tạo đề thi
                await _quizrRepository.CreateExam(examName, quizId, description, image, examType, date);

                return new ResponseCommon($"The exam has been successfully created with the question code: {examId}.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<ResponseCommon> EditExam(string examId, string examName, int quizId, string description, string? image, int examType, DateTime date)
        {
            try
            {
                var existingExam = await _quizrRepository.GetExamById(examId);
                if (existingExam == null)
                {
                    return new ResponseCommon($"Exam with the ID {examId} does not exist.", false);
                }

                var existingQuiz = await _quizrRepository.GetQuizById(quizId);
                if (existingQuiz == null)
                {
                    return new ResponseCommon($"Quiz with the ID {quizId} does not exist.", false);
                }

                // Kiểm tra trạng thái của đề thi
                if (existingExam.Status != 0)
                {
                    return new ResponseCommon($"Exam with the ID {examId} cannot be edited because its status is not 0.", false);
                }
                // Gọi phương thức từ QuizRepository để chỉnh sửa thông tin đề thi
                var result = await _quizrRepository.EditExam(examId, examName, quizId, description, examType, date, image);

                if (result)
                {
                    return new ResponseCommon($"Exam information with the question code: {examId} has been successfully updated.", true);
                }
                else
                {
                    return new ResponseCommon($"Exam information with the question code: {examId} has failed to be update.", false);
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<ResponseCommon> DeleteExam(string examId)
        {
            try
            {
                // Kiểm tra xem examId có tồn tại không
                var existingExam = await _quizrRepository.GetExamById(examId);
                if (existingExam == null)
                {
                    return new ResponseCommon($"Exam with the ID {examId} does not exist.", false);
                }

                // Gọi phương thức từ QuizRepository để xóa đề thi
                await _quizrRepository.DeleteExam(examId);

                return new ResponseCommon($"Exam with the ID {examId} has been successfully deleted.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> ChangeExamStatus(string examId, int newStatus)
        {
            try
            {
                // Kiểm tra xem examId có tồn tại không
                var existingExam = await _quizrRepository.GetExamById(examId);
                if (existingExam == null)
                {
                    return new ResponseCommon($"Exam with the ID {examId} does not exist.", false);
                }

                // Gọi phương thức từ QuizRepository để thay đổi trạng thái của đề thi
                await _quizrRepository.ChangeExamStatus(examId, newStatus);

                return new ResponseCommon($"Status of the exam with the ID {examId} has been successfully changed.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<QuizzesSRC002>> GetQuizzesByTypeAndStatus(int quizType, int status)
        {
            try
            {
                // Thực hiện bất kỳ xử lý logic nào cần thiết

                // Gọi phương thức từ QuizrRepository để lấy danh sách câu hỏi từ database
                return await _quizrRepository.GetQuizzesByTypeAndStatus(quizType, status);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }
        public async Task<ResponseCommon<object>> GetQuizzesByStaffAndStatus(int userId)
        {
            try
            {
                var quizzesStatus0 = await _quizrRepository.GetQuizzesStaff0(userId);
                var quizzesStatus1 = await _quizrRepository.GetQuizzesStaff1(userId);
                var quizzesStatus2 = await _quizrRepository.GetQuizzesStaff2(userId);
                var quizzesStatus4 = await _quizrRepository.GetQuizzesStaff4(userId);

                var result = new
                {
                    QuizzesStatus0 = quizzesStatus0,
                    QuizzesStatus1 = quizzesStatus1,
                    QuizzesStatus2 = quizzesStatus2,
                    QuizzesStatus4 = quizzesStatus4
                };

                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ theo nhu cầu của bạn, ví dụ: ghi log, trả về mã lỗi cụ thể, v.v.
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetInforLobby(string examId, int userId)
        {
            try
            {
                var result = await _quizrRepository.GetInforLobby(examId, userId);
                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon<bool>> UpdateUserExam(string examId, int userId, int? score)
        {
            try
            {
                var result = await _quizrRepository.UpdateUserExam(examId, userId, score);
                return new ResponseCommon<bool>(result);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ExamModel> GetListExamById(string examId)
        {
            try
            {
                // Thực hiện bất kỳ xử lý logic nào cần thiết

                // Gọi phương thức từ QuizrRepository để lấy thông tin đề thi từ database
                return await _quizrRepository.GetListExamById(examId);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<object> GetInforChallengeDetail(string examId, int? userId)
        {
            try
            {
                return await _quizrRepository.GetInforChallenge(examId, userId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<object> UpdateFinishChallenge(string examId, int userId)
        {
            try
            {
                await _quizrRepository.UpdateFinishChallenge(examId, userId);
                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<object> CountUserDoQuiz(int quizId)
        {
            try
            {
                var data = (await _quizrRepository.GetAllHistoryUser()).Where(x => x.QuizId == quizId).ToList();
                var Today = data.Where(x => x.ActionType == 1 && x.DateAction.Date.Day == DateTime.Now.Date.Day).ToList();
                var Month = data.Where(x => x.ActionType == 1 && x.DateAction.Date.Month == DateTime.Now.Date.Month).ToList();
                var result = new
                {
                    NumDay = Today.Select(x => x.UserId).Distinct().Count(),
                    NumMonth = Month.Select(x => x.UserId).Distinct().Count(),
                };
                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> AddQuestions(int userId, QuestionModel request)
        {
            try
            {
                // Gọi phương thức từ QuizRepository để thêm câu hỏi
                var status = await _quizrRepository.AddQuestions(userId, request);

                if (status)
                {
                    return new ResponseCommon("Questions have been successfully added.", true);
                }
                else
                {
                    return new ResponseCommon("Failed to add questions.", false);
                }
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<ResponseCommon> EditQuestions(int userId, QuestionModel request)
        {
            try
            {
                var statusEdit = await _quizrRepository.EditQuestions(userId, request);

                if (!statusEdit)
                {
                    return new ResponseCommon("Failed to Edit questions.", false);
                }

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> ChangeQuestionStatus(ChangeQuestionStatusRequest request)
        {
            try
            {
                // Gọi phương thức từ QuizRepository để thực hiện thay đổi trạng thái câu hỏi
                await _quizrRepository.ChangeQuestionStatus(request.QuestionId, request.NewStatus);

                return new ResponseCommon("Question status has been successfully updated.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<dynamic>> GetQuestionsByCategory(int categoryId, int status, int? userId)
        {
            try
            {
                // Gọi phương thức từ QuizRepository để lấy danh sách câu hỏi theo danh mục
                var questions = await _quizrRepository.GetQuestionsByCategory(categoryId, status, userId);



                return questions;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<QuestionModel.ListQuestion>> GetQuestionsByCategoryAndSearchPage(int categoryId, int status, string? searchTerm, int page, int pageSize)
        {
            try
            {
                // Gọi phương thức từ QuizRepository để lấy danh sách câu hỏi theo danh mục
                var questions = await _quizrRepository.GetQuestionsByCategoryAndSearchPage(categoryId, status, searchTerm, page, pageSize);

                // Chuyển đổi danh sách câu hỏi từ mô hình dữ liệu của Repository sang mô hình dữ liệu của Service
                var questionModels = questions.Select(q => new QuestionModel.ListQuestion
                {
                    QuestionId = q.QuestionId,
                    QuestionText = q.QuestionText,
                    DifficultyLevel = q.DifficultyLevel,
                    CorrectAnswer = q.CorrectAnswer,
                    Options = q.Options,
                    Status = q.Status,
                    UserId = q.UserId
                });

                return questionModels;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        #endregion method public

        #region method private

        /*
         * Hàm tạo mã roomId không trùng lặp với roomId ở db
         */
        private async Task<string> GenerateRoomId()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();

            string roomId;
            do
            {
                char[] roomIdArray = new char[10];
                for (int i = 0; i < 10; i++)
                {
                    roomIdArray[i] = chars[random.Next(chars.Length)];
                }

                roomId = new string(roomIdArray);
            } while (await _hubRepostiory.CheckRoomIdExists(roomId));

            return roomId;
        }

        #endregion method private
    }
}
