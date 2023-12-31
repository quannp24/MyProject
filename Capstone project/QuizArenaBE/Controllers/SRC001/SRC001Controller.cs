using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.Validation;
using QuizArenaBE.Repository.SRC001;
using System.ComponentModel.DataAnnotations;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace QuizArenaBE.Controllers.SRC001
{
    [Route("api/[controller]")]
    [ApiController]
    public class SRC001Controller : ControllerBase // Đã chỉnh sửa tên của controller thành "LoginController"
    {
        private readonly IUserService _userService;
        private readonly IUserRepository _userRepository;

        public SRC001Controller(IUserService userService, IUserRepository userRepository)
        {
            _userService = userService;
            _userRepository = userRepository;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {
            // Truy cập vào loginModel.Username và loginModel.Password ở đây
            try
            {
                var callService = await _userService.Login(loginModel.username, loginModel.password);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon<string>("", ex.Message, false));
            }
        }

        [HttpPost("send-mail-rest-password")]
        public async Task<IActionResult> SendMailRestPass([FromBody] string toMail)
        {
            try
            {
                var callService = await _userService.SendMailRestPass(toMail);
                if (callService.Status == true)
                {
                    return Ok(callService);
                }
                return BadRequest(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpPost("change-password")]
        [Authorize]
        public async Task<IActionResult> ChangePass([FromBody] ChangePasswordRequest changePasswordRequest)
        {
            try
            {
                // Lấy userId từ HttpContext.Items và chuyển đổi sang kiểu int
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                // Kiểm tra mật khẩu cũ
                var isOldPasswordCorrect = await _userRepository.CheckOldPassword(userId.Value, changePasswordRequest.OldPass);

                if (!isOldPasswordCorrect)
                {
                    return BadRequest(new ResponseCommon("Old password is incorrect.", false));
                }

                var callService = await _userService.ChangePass(
                    userId.Value,
                    changePasswordRequest.OldPass,
                    changePasswordRequest.NewPass
                    );

                if (callService.Status)
                {
                    return Ok(callService);
                }

                return BadRequest(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterReq request)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }              
                var existingUser = await _userService.RegisterUser(request);
                
                if (existingUser.Status != true)
                {
                    // Sử dụng thông báo từ ValidationMessages
                    var errorMessage = ValidationMessages.UsernameRequired;
                    return BadRequest(new ResponseCommon(errorMessage, false));
                }
                return Ok(existingUser);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpGet("get-user-info")]
        public async Task<IActionResult> GetUserInfoById()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var userInfo = await _userService.GetUserInfoById(userId.Value);

                if (userInfo == null)
                {
                    return NotFound(new ResponseCommon("User information not found."));
                }

                return Ok(new ResponseCommon<Users>(userInfo));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("info-user")]
        public async Task<IActionResult> infouser([FromQuery] int userId)
        {
            try
            {
                var userInfo = await _userService.GetUserInfoById(userId);

                if (userInfo == null)
                {
                    return NotFound(new ResponseCommon("User information not found !"));
                }

                // Kiểm tra nếu vai trò của người dùng là 4 hoặc 5
                if (userInfo.Role != 4 && userInfo.Role != 5)
                {
                    return Forbid();
                }

                return Ok(new ResponseCommon<Users>(userInfo));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }


        [Authorize]
        [HttpGet("get-user-public")]
        public async Task<IActionResult> GetUserPublic([FromQuery] int userId)
        {
            try
            {
                var userInfo = await _userService.GetUserInfoById(userId);

                if (userInfo == null)
                {
                    return NotFound(new ResponseCommon("User information not found."));
                }

                return Ok(new ResponseCommon<Users>(userInfo));
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpPut("update-user")]
        public async Task<IActionResult> UpdateUser([FromBody] UserUpdateModel updatedUser)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _userService.UpdateUserInfo(userId.Value, updatedUser);

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
        [HttpPut("upload-history-user")]
        public async Task<IActionResult> UploadHistoryUser([FromBody] UploadHistoryUserReq req)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _userService.UploadHistoryUser(userId.Value, req.quizId);

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
        [HttpGet("get-list-friend")]
        public async Task<IActionResult> GetListFriends([FromQuery] string roomId)
        {
            try
            {
                var userId = (int)HttpContext.Items["userId"];
                var callService = await _userService.GetListFriend(userId, roomId);
                if (callService.Status == true)
                {
                    return Ok(callService);
                }
                return BadRequest(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [HttpGet("list-friends/{userId}")]
        public async Task<IActionResult> GetFriends(int userId, string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            // Gọi phương thức GetFriends thay vì GetFriendRequest
            var friends = await _userService.GetFriends(userId, searchTerm, page, pageSize);
            return Ok(friends);
        }

        [HttpGet("friend-status")]
        [Authorize]
        public async Task<IActionResult> GetFriendStatus([FromQuery] int friendId)
        {
            try
            {
                var userId = (int)HttpContext.Items["userId"];

                // Kiểm tra xem có lời mời kết bạn từ người dùng hiện tại đến người dùng được chỉ định không
                var existingRequest = await _userService.GetFriendRequest(userId, friendId);
                var reverseRequest = await _userService.GetFriendRequest(friendId, userId);

                if (existingRequest != null && existingRequest.Status == 0)
                {
                    // Người dùng hiện tại đã gửi lời mời tới friendId, đang chờ accept
                    return Ok(new ResponseCommon<object>(2,"Friend request status", true));
                }
                else if (reverseRequest != null && reverseRequest.Status == 0)
                {
                    // Người dùng hiện tại có lời mời add từ friendId, trả về 3
                    return Ok(new ResponseCommon<object>(3, "Friend request status", true));
                }
                else if ((existingRequest != null && existingRequest.Status == 1) && (reverseRequest != null && reverseRequest.Status == 1))
                {
                    // Hai người dùng đã là bạn bè
                    return Ok(new ResponseCommon<object>(1, "Friend request status", true));
                }
                else
                {
                    // Không có lời mời kết bạn giữa hai người dùng này
                    return Ok(new ResponseCommon<object>(0, "Friend request status", true));
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));

            }
        }

        [HttpPost("send-friend-request")]
        public async Task<IActionResult> SendFriendRequest([FromBody] AddFriendRequest request)
        {
            if (request == null || request.UserId == 0 || request.FriendId == 0)
            {
                return BadRequest(new ResponseCommon("Invalid request data", false));
            }

            var success = await _userService.SendFriendRequest(request.UserId, request.FriendId);
            if (success)
            {
                return Ok(new ResponseCommon("Friend request sent successfully", true));
            }

            return BadRequest(new ResponseCommon("Failed to send friend request", false));
        }

        [HttpPatch("confirm-friends")]
        public async Task<IActionResult> ConfirmFriendRequest([FromBody] AddFriendRequest request)
        {
            if (request == null || request.UserId == 0 || request.FriendId == 0)
            {
                return BadRequest(new ResponseCommon("Invalid request data", false));
            }

            var success = await _userService.ConfirmFriendRequest(request.UserId, request.FriendId);
            if (success)
            {
                return Ok(new ResponseCommon("Friend request confirmed successfully", true));
            }

            return BadRequest(new ResponseCommon("Failed to confirm friend request", false));
        }

        [HttpGet("get-friend-notifications")]
        [Authorize]
        public async Task<IActionResult> GetFriendNotifications()
        {
            try
            {
                // Lấy userId từ HttpContext
                var userId = (int)HttpContext.Items["userId"];

                var friendNotifications = await _userRepository.GetFriendNotifications(userId);
                return Ok(friendNotifications);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu cần
                return StatusCode(500, "Internal Server Error");
            }
        }


        [HttpPatch("decline-friend")]
        public async Task<IActionResult> DeclineFriendRequest([FromBody] AddFriendRequest request)
        {
            if (request == null || request.UserId == 0 || request.FriendId == 0)
            {
                return BadRequest(new ResponseCommon("Invalid request data", false));
            }

            var success = await _userService.DeclineFriendRequest(request.UserId, request.FriendId);
            if (success)
            {
                return Ok(new ResponseCommon("Friend request declined successfully", true));
            }

            return BadRequest(new ResponseCommon("Failed to decline friend request", false));
        }


        [HttpGet("search-homepage")]
        public async Task<IActionResult> SearchHomepage()
        {
            try
            {
                var searchResults = await _userService.Search();
                return Ok(searchResults);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi nếu cần
                return StatusCode(500, "Internal Server Error");
            }
        }

        [Authorize]
        [HttpGet("Get-Notification-User")]
        public async Task<IActionResult> GetNotificationUser()
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var service = await _userService.GetNotification(userId.Value);

                if (!service.Status)
                {
                    return NotFound(service);
                }

                return Ok(service);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

        [Authorize]
        [HttpGet("reset-session")]
        public async Task<IActionResult> ResetSession()
        {
            try
            {
                var service = await _userService.ResetSession();
                return Ok(service);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon(ex.Message, false));
            }
        }

    }
}
