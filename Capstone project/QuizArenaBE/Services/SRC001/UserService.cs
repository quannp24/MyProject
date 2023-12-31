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
using QuizArenaBE.Repository.SRC001;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using static System.Net.Mime.MediaTypeNames;
using QuizArenaBE.Entity.SRC003;

namespace QuizArenaBE.Services.SRC001
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly ICRUDcommon _crudCommon;
        private readonly ICommon _common;
        private readonly IConfiguration _configuration;

        public UserService(IUserRepository userRepository, IConfiguration configuration, ICommon common, ICRUDcommon crudCommon)
        {
            _userRepository = userRepository;
            _configuration = configuration;
            _common = common;
            _crudCommon = crudCommon;
        }

        #region method public

        public async Task<ResponseCommon<string>> Login(string username, string password)
        {
            var user = await _userRepository.GetUser(username, password);
            if (user == null)
            {
                return new ResponseCommon<string>("", "Login failed", false);
            }
            var token = await GenerateJwtToken(user);
            await _userRepository.UpdateTokenUser(user.UserId, token).ConfigureAwait(false);

            return new ResponseCommon<string>(token);
        }

        public async Task<ResponseCommon> RegisterUser(RegisterReq request)
        {
            try
            {
                var isEmailInUse = await _userRepository.IsEmailInRegister(request.email);
                if (isEmailInUse)
                {
                    return new ResponseCommon("Email already exists.", false);
                }
                // Kiểm tra xem tài khoản có tồn tại trong cơ sở dữ liệu chưa
                var isExistingUser = await _userRepository.GetUser(request.username);
                if (isExistingUser != null)
                {
                    return new ResponseCommon("Username already exists.", false);
                }
                await _userRepository.InsertNewUser(request);
                return new ResponseCommon("Create Account Successfully");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> SendMailRestPass(string mailAddress)
        {
            try
            {
                var user = await _userRepository.GetUser(mail: mailAddress);
                if (user == null)
                {
                    return new ResponseCommon("No found mail", false);
                }

                string newPass = await GenerateRandomPassword();
                await _common.SendMail(mailAddress, "Password reset", $"This is your new password: {newPass}");

                await _userRepository.UpdatePassword(user.UserId, newPass);

                return new ResponseCommon();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> ChangePass(int userId, string oldPass, string newPass)
        {
            var user = await _userRepository.GetUserById(userId);
            if (user == null)
            {
                return new ResponseCommon("Wrong account or password", false);
            }
            await _userRepository.UpdatePassword(user.UserId, newPass);

            return new ResponseCommon(message: "Changed password successfully");
        }

        public async Task<Users?> GetUserInfoById(int userId)
        {
            var user = await _userRepository.GetUser(userId: userId);

            return user;
        }

        public async Task<ResponseCommon> UpdateUserInfo(int userId, UserUpdateModel user)
        {
            try
            {
                var userInfo = await GetUserInfoById(userId);
                if (userInfo == null)
                {
                    return new ResponseCommon("Not Found User.", false);
                }

                // Kiểm tra xem email đã được sử dụng bởi một người dùng khác hay không
                if (!string.IsNullOrEmpty(user.Email) && !user.Email.Equals(userInfo.Email))
                {
                    var isEmailInUse = await _userRepository.IsEmailInUse(userId, user.Email);
                    if (isEmailInUse)
                    {
                        return new ResponseCommon("Email already exists.", false);
                    }
                    // Kiểm tra xem email có đúng định dạng hay không
                    var emailRegex = new Regex(@"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$");
                    if (!emailRegex.IsMatch(user.Email))
                    {
                        return new ResponseCommon("Invalid email format.", false);
                    }
                }
                if (user.Exp > 0)
                {
                    user.Exp = userInfo.Exp + user.Exp;
                }


                // Thực hiện cập nhật thông tin người dùng trong cơ sở dữ liệu sử dụng Dapper
                var rowsAffected = await _userRepository.UpdateUserInfo(userId, user, userInfo);

                if (rowsAffected > 0)
                {
                    return new ResponseCommon("User information updated successfully");
                }
                else
                {
                    return new ResponseCommon("User information update failed", false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> UploadHistoryUser(int userId, int? quizId = null)
        {
            try
            {
                await _userRepository.InsertHistoryUser(userId, quizId);
                return new ResponseCommon();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public async Task<bool> SendFriendRequest(int userId, int friendId)
        {
            return await _userRepository.SendFriendRequest(userId, friendId);
        }
        public async Task<bool> ConfirmFriendRequest(int userId, int friendId)
        {
            // Xác nhận lời mời kết bạn
            return await _userRepository.ConfirmFriendRequest(userId, friendId);
        }
        public async Task<FriendInfo> GetFriendRequest(int userId, int friendId)
        {
            return await _userRepository.GetFriendRequest(userId, friendId);
        }
        public async Task<IEnumerable<FriendInfo>> GetFriends(int userId, string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            return await _userRepository.GetFriends(userId, searchTerm, page, pageSize);
        }
        public async Task<IEnumerable<FriendNotification>> GetFriendNotifications(int userId)
        {
            // Lấy danh sách thông báo với danh sách những người chưa xác nhận kết bạn từ cơ sở dữ liệu
            var friendNotifications = await _userRepository.GetFriendNotifications(userId);
            return friendNotifications;
        }
        // Trong UserService
        public async Task<bool> DeclineFriendRequest(int userId, int friendId)
        {
            // Xóa yêu cầu kết bạn từ cơ sở dữ liệu mà không quan tâm đến trạng thái
            return await _userRepository.DeclineFriendRequest(userId, friendId);
        }

        public async Task<string> AreFriendsMessage(int userId, int friendId)
        {
            bool areFriends = await _userRepository.AreFriends(userId, friendId);

            if (areFriends)
            {
                return "Users are friends";
            }
            else
            {
                return "Users are not friends";
            }
        }

        public async Task<string> GetFriendRequestMessage(int userId, int friendId)
        {
            var friendInfo = await _userRepository.GetFriendRequest(userId, friendId);
            var friendInfo1 = await _userRepository.GetFriend(userId, friendId);
            if (friendInfo1 is null && friendInfo is null)
            {
                return "There are no friend requests between these two";
            }

            if (friendInfo1 is not null)
            {
                return "You have sent a friend request " + friendInfo1.FriendId;
            }
            else
            {
                return friendInfo1.FriendId + " sent you a friend request";
            }
        }



        public async Task<ResponseCommon<object>> Search()
        {

            var userResult = await _userRepository.SearchUser();
            var examResults = await _userRepository.SearchExam();
            var quizResults = await _userRepository.SearchQuiz();
            var result = new
            {
                userResult = userResult,
                examResults = examResults,
                quizResults = quizResults
            };

            return new ResponseCommon<object>(result);
        }

        public async Task<ResponseCommon<object>> GetListFriend(int userId, string roomId)
        {
            try
            {
                var data = await _userRepository.GetFriendsOnOrOff(userId, roomId);
                if (data == null)
                {
                    return new ResponseCommon<object>(null, "not friend", false);

                }
                var listFriendON = data.Where(x => x.Status == 1)
                    .Select(x => new
                    {
                        userId = x.UserId,
                        username = x.Fullname,
                        fullname = x.Fullname,
                        images = x.Images,
                        statusInvite = x.StatusInvite
                    }).ToList();
                var listFriendOFF = data.Where(x => x.Status == 0)
                    .Select(x => new
                    {
                        userId = x.UserId,
                        username = x.Fullname,
                        fullname = x.Fullname,
                        images = x.Images
                    }).ToList();
                var result = new
                {
                    ListFriendON = listFriendON,
                    ListFriendOFF = listFriendOFF,
                };

                return new ResponseCommon<object>(result);
            }
            catch (Exception ex)
            {
                return new ResponseCommon<object>(null, ex.Message, false);
                throw ex;
            }
        }

        public async Task<ResponseCommon<object>> GetNotification(int userId)
        {
            try
            {

                var Result = await _userRepository.GetNotification(userId);
                if (Result == null || Result.Count() == 0)
                {
                    return new ResponseCommon<object>(null, "not find data", true);

                }
                return new ResponseCommon<object>(Result,"",true);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> InsertPayment(PaymentInfo request)
        {
            try
            {

                await _userRepository.InsertPayment(request);
                
                return new ResponseCommon("Insert done");

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<ResponseCommon> ResetSession()
        {
            try
            {
                var result = await _userRepository.ResetSession();
                if (result == 0)
                {
                    return new ResponseCommon("Can't reset", false);
                }
                return new ResponseCommon("Reset done.", true);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion method public

        #region method private

        private async Task<string> GenerateRandomPassword()
        {
            const string validChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=<>?";

            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                byte[] randomBytes = new byte[12];
                rng.GetBytes(randomBytes);

                char[] randomChars = new char[12];
                int validCharCount = validChars.Length;

                for (int i = 0; i < 12; i++)
                {
                    randomChars[i] = validChars[randomBytes[i] % validCharCount];
                }

                return new string(randomChars);
            }
        }

        private async Task<string> GenerateJwtToken(Users user)
        {
            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JwtSettings:Secret"]));
            var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim("userId", user.UserId.ToString()),
                new Claim("role", user.Role.ToString()),
            };

            var token = new JwtSecurityToken(
                issuer: _configuration["JwtSettings:Issuer"],
                audience: _configuration["JwtSettings:Audience"],
                claims: claims,
                expires: DateTime.UtcNow.AddDays(1),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }


        #endregion method private
    }
}
