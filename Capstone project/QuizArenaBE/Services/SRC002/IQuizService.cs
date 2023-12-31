
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC002;
using static QuizArenaBE.Entity.SRC002.InsertQuizReq;
using static QuizArenaBE.Entity.SRC002.QuizModel;

public interface IQuizService
{
    public Task<ResponseCommon<QuizModel>> GetQuiz(int quizId, int userId);
    public Task<ResponseCommon> AddQuestions(int userId, QuestionModel request);

    public Task<object> GetListQuiz(int userId);

    public Task<ResponseCommon> AddQuiz(int userId, InsertQuizReq request);

    public Task<ResponseCommon<List<object>>> GetQuestionsRandom(GetQuestionsRandomReq req);

    public Task<ResponseCommon<object>> GetQuizRecentPopular(int userId);

    public Task<ResponseCommon<object>> GetInforRoomQuiz(int userId, string roomId);

    public Task<ResponseCommon<object>> AddRoomQuiz(int quizId, int userId);

    public Task<ResponseCommon<object>> FriendJoinRoomQuiz(string roomId, int userId, int quizId);

    public Task<ResponseCommon> DeleteRoomQuizUser(string roomId);

    public Task<ResponseCommon<object>> GetExamInfo(int? userId);

    public Task<ResponseCommon<object>> UpdateQuiz(UpdateQuizModel request, int userId);

    public Task<ResponseCommon<object>> UpdateQuizPrivate(UpdateQuizModel request, int userId);

    public Task<ResponseCommon<object>> GetQuizForMod();

    public Task<ResponseCommon<object>> GetAchievementsUser(int userId);

    public Task<ResponseCommon<List<ActiveQuiz>>> GetActiveQuizzes();

    public Task<ResponseCommon> DeleteQuiz(int quizId, int quiz_type);

    public Task<ResponseCommon> ChangeQuizStatus(UpdateStatusQuiz request);

    public Task<ResponseCommon> InsertExamUser(InsertExamUserModel req, int userId);

    public Task<List<QuizA>> GetQuizzesByStatus(List<int> status, int page = 1, int pageSize = 10, string? searchTerm = null);

    public Task<List<QuizCategory>> GetQuizzesByCategoryAndStatus(int categoryId);

    public Task<ResponseCommon<object>> GetQuizzesByStaffAndStatus(int userId);
    public Task<List<ExamModel>> GetExamList();
    public Task<ResponseCommon> CreateExam(string examName, int quizId, string description, string image, int examType, DateTime date);
    public Task<ResponseCommon> EditExam(string examId, string examName, int quizId, string description, string image, int examType, DateTime date);
    public Task<ResponseCommon> DeleteExam(string examId);
    public Task<ResponseCommon> ChangeExamStatus(string examId, int newStatus);

    public Task<ResponseCommon<object>> GetInforLobby(string examId, int userId);

    public Task<ResponseCommon<bool>> UpdateUserExam(string examId, int userId, int? score);
    public Task<IEnumerable<QuizzesSRC002>> GetQuizzesByTypeAndStatus(int quizType, int status);
    public Task<ExamModel> GetListExamById(string examId);

    public Task<object> GetInforChallengeDetail(string examId, int? userId);

    public Task<object> UpdateFinishChallenge(string examId, int userId);

    public Task<object> CountUserDoQuiz(int quizId);
    public Task<ResponseCommon> EditQuestions(int userId, QuestionModel request);
    public Task<ResponseCommon> ChangeQuestionStatus(ChangeQuestionStatusRequest request);

    public Task<IEnumerable<dynamic>> GetQuestionsByCategory(int categoryId, int status, int? userId);

    public Task<IEnumerable<QuestionModel.ListQuestion>> GetQuestionsByCategoryAndSearchPage(int categoryId, int status, string? searchTerm, int page, int pageSize);

}

