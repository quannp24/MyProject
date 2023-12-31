using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC003;
using Quiz = QuizArenaBE.Entity.SRC001.Quiz;

namespace QuizArenaBE.Repository.SRC001
{
    public interface IUserRepository
    {
        public Task InsertNewUser(RegisterReq request);

        public Task<Users?> GetUser(string username = "", string password = "", string mail = "", int? userId = null);

        public Task<int> UpdatePassword(int id, string pass);

        public Task UpdateTokenUser(int id, string token);
        public Task<bool> IsEmailInUse(int userId, string email);

        public Task<bool> IsEmailInRegister(string email);

        public Task<Users?> GetUserById(int userId);

        public Task<int> UpdateUserInfo(int userId, UserUpdateModel user, Users oldUser);

        public Task<bool> CheckOldPassword(int userId, string oldPassword);

        public Task InsertHistoryUser(int userId, int? quizId = null);

        public Task<List<HistoryUser>?> GetHistoryUser(int quizid, int userId);

        public Task<FriendInfo> GetFriendRequest(int userId, int friendId);

        public Task<bool> AddFriendRequest(int userId, int friendId, int status);

        public Task<bool> ConfirmFriendRequest(int userId, int friendId);

        public Task<IEnumerable<FriendInfo>> GetFriends(int userId, string? searchTerm = null, int page = 1, int pageSize = 10);

        public Task<bool> SendFriendRequest(int userId, int friendId);
        public Task<IEnumerable<SearchModel>> SearchUser();
        public Task<IEnumerable<SearchModel>> SearchQuiz();
        public Task<IEnumerable<SearchModel>> SearchExam();
        public Task<IEnumerable<FriendNotification>> GetFriendNotifications(int userId);
        public Task<bool> DeclineFriendRequest(int userId, int friendId);
        public Task<List<FriendsOnOrOffModel>?> GetFriendsOnOrOff(int userId, string roomId);
        public Task<bool> AreFriends(int userId, int friendId);
        public Task<FriendInfo> GetFriend(int userId, int friendId);

        public Task<IEnumerable<Notification>> GetNotification(int UserId);

        public Task InsertNotification(int userId, string? content = "", string? value = "");

        public Task<int> ResetSession();

        public Task InsertPayment(PaymentInfo request);
    }
}
