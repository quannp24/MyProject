using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC003;
using System.Threading.Tasks;
using static QuizArenaBE.Controllers.SRC001.SRC001Controller;

public interface IUserService
{
    Task<ResponseCommon<string>> Login(string username, string password);

    Task<ResponseCommon> SendMailRestPass(string mailAddress);

    Task<ResponseCommon> ChangePass(int userId, string oldPass, string newPass);

    Task<ResponseCommon> RegisterUser(RegisterReq request);

    Task<Users?> GetUserInfoById(int userId);

    Task<ResponseCommon> UpdateUserInfo(int userId, UserUpdateModel user);

    Task<ResponseCommon> UploadHistoryUser(int userId, int? quizId = null);

    Task<bool> SendFriendRequest(int userId, int friendId);

    Task<bool> ConfirmFriendRequest(int userId, int friendId);

    Task<FriendInfo> GetFriendRequest(int userId, int friendId);

    Task<IEnumerable<FriendInfo>> GetFriends(int userId, string? searchTerm = null, int page = 1, int pageSize = 10);

    Task<ResponseCommon<object>> Search();

    Task<IEnumerable<FriendNotification>> GetFriendNotifications(int userId);

    Task<bool> DeclineFriendRequest(int userId, int friendId);

    Task<ResponseCommon<object>> GetListFriend(int userId, string roomId);

    Task<string> GetFriendRequestMessage(int userId, int friendId);

    Task<string> AreFriendsMessage(int userId, int friendId);

    public Task<ResponseCommon<object>> GetNotification(int userId);

    public Task<ResponseCommon> InsertPayment(PaymentInfo request);

    public Task<ResponseCommon> ResetSession();
}
