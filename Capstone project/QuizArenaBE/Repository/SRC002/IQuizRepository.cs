using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC002;
using static QuizArenaBE.Entity.SRC002.InsertQuizReq;
using static QuizArenaBE.Entity.SRC002.QuizModel;

namespace QuizArenaBE.Repository.SRC002
{
    public interface IQuizRepository
    {
        public Task<QuizModel> GetDataQuiz(int id, int userId);

        public Task<object> GetListQuiz(int userId);

        public Task<List<HistoryUser>> GetAllHistoryUser();

        public Task<bool> InsertDataQuiz(int userId, InsertQuizReq request);

        public Task<List<dynamic>> GetRandomQuestions(int count, int category, int level);

        public Task<List<QuizRecentPopular>> GetDataQuizPopular();

        public Task<List<ExamModel>> GetDataExamRecent();

        public Task<List<QuizRecentPopular>?> GetDataQuizRecent(int userid);

        public Task<RoomDoUser?> GetUserDoQuiz(int userId, string roomId);

        public Task<List<UserInQuiz>?> GetUsersInRoom(string roomId, int userId);

        public Task<int> InsertUserRoomQuiz(int userId, string roomId);

        public Task<int> CheckFriendInBossRoom(int userId, string roomId, int quizId);

        public Task<int> DeleteRoomQuizUser(string roomId);

        public Task<IEnumerable<ExamListTopModel>?> GetExamListTop();

        public Task<ExamInfoUserModel?> GetExamInfoUser(int userId);

        public Task<ExamToWeekModel?> GetExamToWeek();

        public Task<IEnumerable<ExamTop3UserModel>?> GetExamTop3User();

        public Task<int> UpdateQuiz(UpdateQuizModel request, int userId);

        public Task<int> UpdateQuizPrivate(UpdateQuizModel request, int userId);

        public Task<object> GetQuizForMod();

        public Task<List<ActiveQuiz>> GetActiveQuizzes();

        public Task<int> DeleteQuiz(int quizId, int quiz_type);

        public Task<bool> UpdateQuizStatus(UpdateStatusQuiz request);

        public Task<ActiveQuiz> GetActiveQuizById(int quizId);

        public Task<List<QuizA>> GetQuizzesByStatus(List<int> status, int page = 1, int pageSize = 10, string? searchTerm = null);

        public Task<int> InsertExamUser(InsertExamUserModel req, int userId);
        public Task<List<QuizCategory>> GetQuizzesByCategoryAndStatus(int categoryId);
        public Task<List<QuizStaff>> GetQuizzesStaff0(int userId);
        public Task<List<QuizStaff>> GetQuizzesStaff1(int userId);
        public Task<List<QuizStaff>> GetQuizzesStaff2(int userId);
        public Task<List<QuizStaff>> GetQuizzesStaff4(int userId);
        public Task<bool> CheckUserInExamUser(string? examId, int userId);
        public Task<List<ExamModel>> GetExamList();
        public Task<string> CreateExam(string examName, int quizId, string description, string image, int examType, DateTime date);
        public Task<bool> EditExam(string examId, string examName, int quizId, string description, int examType, DateTime date, string? image = null);
        public Task<ExamModel?> GetExamById(string examId);
        public Task<QuizModel> GetQuizById(int quizId);
        public Task DeleteExam(string examId);
        public Task ChangeExamStatus(string examId, int newStatus);

        public Task<object> GetInforLobby(string examId, int userId);

        public Task<bool> UpdateUserExam(string examId, int userId, int? score);
        public Task<IEnumerable<QuizzesSRC002>> GetQuizzesByTypeAndStatus(int quizType, int status);
        public Task<ExamModel> GetListExamById(string examId);

        public Task<GetInforChallengeModel> GetInforChallenge(string examId, int? userId);

        public Task UpdateFinishChallenge(string examId, int userId);
        public string GenerateUniqueExamId();
        public Task<bool> AddQuestions(int userId, QuestionModel request);
        public Task<bool> EditQuestions(int userId, QuestionModel request);

        public Task ChangeQuestionStatus(int questionId, int newStatus);

        public Task<IEnumerable<dynamic>> GetQuestionsByCategory(int categoryId, int status, int? userId);

        public Task<IEnumerable<QuestionModel.ListQuestion>> GetQuestionsByCategoryAndSearchPage(int categoryId, int status, string? searchTerm, int page, int pageSize);

    }
}
