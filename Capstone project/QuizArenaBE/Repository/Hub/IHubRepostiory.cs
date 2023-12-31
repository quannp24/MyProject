using QuizArenaBE.Entity.Hub;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC002;

namespace QuizArenaBE.Repository.Hub
{
    public interface IHubRepostiory
    {
        public Task UpdateStatusUser(int userid, int status);

        public Task<IEnumerable<string>> GetFriendOnline(int userid);

        public Task<Entity.SRC001.Quiz?> GetTitleQuizByRoomID(string roomId);

        public Task<Users?> GetUserInforById(int userId);

        public Task<bool> CheckRoomIdExists(string roomId);

        public Task<bool> CheckUserOnlyDoChallenge(int userId, string examId);

        public Task<ExamListTopModel> GetInfoChallenge(string examId);

        public Task CreateRoom(int UserId, string RoomId, int QuizId, int? CurrentQuestion = null, int? TotalExp = null);

        public Task<int> GetUserOutQuiz(int userId, string roomId);

        public Task<int> UpdateFinishChallenge(string examId);

        public Task UpdateRoomQuiz(string roomId, int currentQuestion, int totalExp);

        public Task UpdateRoleUserRoomQuiz(int userid, int role, string roomId);

        public Task RemoveHelperUserRoomQuiz(string roomId);

        public Task<GetUserInRoomModle> GetUserInRoom(string roomId, int userId);

        public Task<bool> CheckStatusExamUser(int userid, string examid);
    }
}
