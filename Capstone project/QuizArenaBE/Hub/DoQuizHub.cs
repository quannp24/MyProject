using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Caching.Memory;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.Hub;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Repository.Hub;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Services.Common;
using System;
using System.Collections.Concurrent;
using System.Security;
using System.Security.Claims;
using System.Xml.Linq;

namespace QuizArenaBE.Hub
{
    public class DoQuizHub : Microsoft.AspNetCore.SignalR.Hub
    {
        private readonly IHubRepostiory _hubRepostiory;
        private IMemoryCache _cache;

        public DoQuizHub(IHubRepostiory hubRepostiory, IMemoryCache cache)
        {
            _hubRepostiory = hubRepostiory;
            _cache = cache;
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }

        /*
         * Hàm xử lý khi có người kết nối tới signalR
         */
        public override async Task OnConnectedAsync()
        {
            try
            {
                // Lấy userId
                var userId = Context.GetHttpContext().Request.Query["userId"];
                if (int.TryParse(userId, out var parsedUserId) && parsedUserId != 0)
                {
                    //Thử lấy biến list_connections ở memory cache, có thì gán cho biến _userConnectionCount, không có thì khởi tạo ConcurrentDictionary<int, int> với _userConnectionCount
                    if (_cache.TryGetValue<ConcurrentDictionary<int, int>>("list_connections", out var _userConnectionCount))
                    {
                        //Trường hợp key userId có ở trong _userConnectionCount, tức đã vào rồi chỉ đang chuyển trang hoặc tải lại trang
                        if (_userConnectionCount.TryGetValue(parsedUserId, out var num_connect))
                        {
                            //Nếu _userConnectionCount có chứa key bằng userId thì +1, không thì tạo ra và set = 1
                            _userConnectionCount.AddOrUpdate(parsedUserId, 1, (_, count) => count + 1);
                            _cache.Set<ConcurrentDictionary<int, int>>("list_connections", _userConnectionCount);

                            //Add user vào nhóm riêng với tên nhóm là userId của họ
                            await Groups.AddToGroupAsync(Context.ConnectionId, parsedUserId.ToString());
                            Console.WriteLine("UserId " + parsedUserId + " moi them ket noi so " + (num_connect + 1));
                        }
                        else //Trường hợp key userId không có ở trong _userConnectionCount, tức mới vào hệ thống
                        {
                            //Tạo ra key = userId và value = 1, gán _userConnectionCount vào biến list_connections lưu ở memory cache
                            _userConnectionCount.TryAdd(parsedUserId, 1);
                            _cache.Set<ConcurrentDictionary<int, int>>("list_connections", _userConnectionCount);

                            //Add user vào nhóm riêng với tên nhóm là userId của họ
                            await Groups.AddToGroupAsync(Context.ConnectionId, parsedUserId.ToString());
                            Console.WriteLine("UserId " + parsedUserId + " moi onl ne.");

                            //Update status = 1 cho user đó, tức hiển thị trạng thái online ở db
                            await _hubRepostiory.UpdateStatusUser(parsedUserId, 1);


                            //Gửi sự kiện cho bạn bè biết bạn đã onlline            
                            var result = await _hubRepostiory.GetFriendOnline(parsedUserId);
                            if (result != null && result.Count() != 0)
                            {
                                // Gọi phương thức NotifyFriendOffline để thông báo offline cho các friend_id đang làm quiz-friends để cập nhật danh sách online
                                await Clients.Groups(result).SendAsync("NotifyFriendOnlline", parsedUserId);
                            }
                        }

                    }
                    else //Trường hợp list_connections không có ở memory cache
                    {
                        ConcurrentDictionary<int, int> _userConnection = new ConcurrentDictionary<int, int>();
                        //Add một cặp key = userId và value = 1, lưu _userConnectionCount vào biến list_connections ở memory cache
                        _userConnection.TryAdd(parsedUserId, 1);
                        _cache.Set<ConcurrentDictionary<int, int>>("list_connections", _userConnection);

                        //Add user vào nhóm riêng với tên nhóm là userId của họ
                        await Groups.AddToGroupAsync(Context.ConnectionId, parsedUserId.ToString());
                        Console.WriteLine("UserId " + parsedUserId + " moi onl ne.");

                        //Update status = 1 cho user đó, tức hiển thị trạng thái online ở db
                        await _hubRepostiory.UpdateStatusUser(parsedUserId, 1);


                        //Gửi sự kiện cho bạn bè biết bạn đã onlline            
                        var result = await _hubRepostiory.GetFriendOnline(parsedUserId);
                        if (result != null && result.Count() != 0)
                        {
                            // Gọi phương thức NotifyFriendOffline để thông báo offline cho các friend_id đang làm quiz-friends để cập nhật danh sách online
                            await Clients.Groups(result).SendAsync("NotifyFriendOnlline", parsedUserId);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                throw ex;
            }

            //Thực hiện tiếp việc kết nối
            await base.OnConnectedAsync();

        }


        /*
         * Hàm xử lý khi có người ngắt kết nối signalR
         */
        public override async Task OnDisconnectedAsync(Exception exception)
        {
            // Chỉ khi memory có lưu biến list_connections mới thực hiện
            var userId = Context.GetHttpContext().Request.Query["userId"];

            //Thử đổi userId sang int, đổi được và userId phải khác 0 thì mới thực hiện code
            if (int.TryParse(userId, out var parsedUserId) && parsedUserId != 0)
            {
                //Lấy list_connections tìm key userId và trừ value 1
                if (_cache.TryGetValue<ConcurrentDictionary<int, int>>("list_connections", out var _userConnectionCount))
                {
                    //Thử lấy value của key userId từ _userConnectionCount
                    if (_userConnectionCount.TryGetValue(parsedUserId, out var num))
                    {
                        // Giảm value đi 1 và set lại vào biến list_connections lưu memory cache
                        _userConnectionCount.AddOrUpdate(parsedUserId, 0, (_, count) => count - 1);
                        _cache.Set<ConcurrentDictionary<int, int>>("list_connections", _userConnectionCount);
                    }
                }

                //Hàm đợi 10 giây
                await Task.Delay(TimeSpan.FromSeconds(10));

                //Lấy lại biến list_connections từ memory cache xem có connect mới không
                if (_cache.TryGetValue<ConcurrentDictionary<int, int>>("list_connections", out _userConnectionCount))
                {
                    //Kiểm tra _userConnectionCount có chứa userId 
                    if (_userConnectionCount.TryGetValue(parsedUserId, out var num_connectUser))
                    {
                        //Kiểm tra xem số kết nối của userId đó bằng 0 thì cập nhật status db
                        if (num_connectUser == 0)
                        {
                            // Xóa cặp key-value từ _userConnectionCount
                            _userConnectionCount.TryRemove(parsedUserId, out _);

                            // Cập nhật lại giá trị trong Memory Cache
                            _cache.Set<ConcurrentDictionary<int, int>>("list_connections", _userConnectionCount);
                            Console.WriteLine("UserId " + parsedUserId + "da off.");

                            //Cập nhật status = 0 trong dc
                            await _hubRepostiory.UpdateStatusUser(parsedUserId, 0);

                            //Gửi sự kiện cho bạn bè biết bạn đã offline              
                            var result = await _hubRepostiory.GetFriendOnline(parsedUserId);
                            if (result != null && result.Count() != 0)
                            {
                                // Gọi phương thức NotifyFriendOffline để thông báo offline cho các friend_id đang làm quiz-friends để cập nhật danh sách online
                                await Clients.Groups(result).SendAsync("NotifyFriendOffline", parsedUserId);
                            }

                        }
                    }
                }

            }

            // Thực hiện tiếp quá trình ngắt kết nối
            await base.OnDisconnectedAsync(exception);
        }

        /*
         * Hàm xử lý khi có user out khỏi trang do-quiz-friends
         */
        public async Task OutRoomQuiz(string roomId)
        {
            var userIdOut = Context.GetHttpContext().Request.Query["userId"];

            var checkUserOut = await _hubRepostiory.GetUserOutQuiz(int.Parse(userIdOut), roomId);
            if (checkUserOut == 1) // người out là chủ phòng Quiz
            {
                var result = new
                {
                    userId = int.Parse(userIdOut),
                    roleUser = 1
                };
                await Clients.Group(roomId).SendAsync("UserRoomOut", new ResponseCommon<object>(result, "Boss out room", true));
                await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomId);
            }
            else if (checkUserOut == 2)//người out là user trong phòng đó
            {
                var result = new
                {
                    userId = int.Parse(userIdOut),
                    roleUser = 0
                };
                await Clients.Group(roomId).SendAsync("UserRoomOut", new ResponseCommon<object>(result, "User out room", true));
                await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomId);
            }

        }

        /*
         * Hàm tạo add user vào room quiz và phát sự kiện cho mọi người ở trong room, được gọi ở do-quiz-friend component
         */
        public async Task JoinRoom(string roomId)
        {
            var userId = Context.GetHttpContext().Request.Query["userId"];
            try
            {
                if (roomId != null && roomId.Length > 0)
                {
                    var result = await _hubRepostiory.GetUserInforById(int.Parse(userId));
                    await Groups.AddToGroupAsync(Context.ConnectionId, roomId);

                    var data = await _hubRepostiory.GetUserInRoom(roomId, int.Parse(userId));
                    if (data.UserIdBoss != null) // tức user này đang vào room user khác
                    {
                        await Clients.Group(data.UserIdBoss.ToString()).SendAsync("FriendJoinMyRoom", new ResponseCommon<object>(result, "Your friend join my room", true));
                    }
                    await Clients.Groups(data.ListUserId).SendAsync("FriendJoinRoomOrther", new ResponseCommon<object>(result, "Your friend join room orther", true));
                    await Clients.Group(roomId).SendAsync("UserJoin", new ResponseCommon<object>(result, "User join room", true));

                }
            }
            catch (Exception ex)
            {
                await Clients.Groups(userId.ToString()).SendAsync("FriendJoinRoomOrther", new ResponseCommon<object>(null, ex.Message, false)); //phát sự kiện kèm lỗi
            }

        }

        /*
         * Hàm gửi lời mời làm quiz cho bạn bè, được gọi khi nhấn button invite ở màn do-quiz-friends
         */
        public async Task SendInviteQuiz(int friendId, string roomId)
        {
            var userId = Context.GetHttpContext().Request.Query["userId"];
            try
            {
                if (friendId > 0 && roomId != null)
                {
                    var quiz = await _hubRepostiory.GetTitleQuizByRoomID(roomId); // lấy title của quiz dựa vào roomId
                    var user_infor = await _hubRepostiory.GetUserInforById(int.Parse(userId));
                    var result = new
                    {
                        quiz = quiz,
                        user_infor = user_infor,
                        roomId = roomId
                    };
                    await Clients.Group(friendId.ToString()).SendAsync("InviteDoQuiz", new ResponseCommon<object>(result, "", true)); //phát sự kiện khi tạo room xong
                }
            }
            catch (Exception ex)
            {
                await Clients.Groups(friendId.ToString()).SendAsync("InviteDoQuiz", new ResponseCommon<object>(null, "", false)); //phát sự kiện kèm lỗi
            }

        }


        /*
        * Hàm thêm mới helper
        */
        public async Task AddHelper(string roomId, int userId)
        {
            try
            {
                var userIdBoss = Context.GetHttpContext().Request.Query["userId"];

                await _hubRepostiory.UpdateRoleUserRoomQuiz(userId, 2, roomId);

                await Clients.Group(roomId).SendAsync("ChangeHelper", new ResponseCommon<object>(userId, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(roomId).SendAsync("ChangeHelper", new ResponseCommon<object>(null, ex.Message, false));
            }

        }

        /*
        * Hàm xóa helper mode
        */
        public async Task RemoveHelper(string roomId, int userId)
        {
            try
            {
                var userIdBoss = Context.GetHttpContext().Request.Query["userId"];

                await _hubRepostiory.RemoveHelperUserRoomQuiz(roomId);

                await Clients.Group(roomId).SendAsync("SendRemoveHelper", new ResponseCommon<object>(userId, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(roomId).SendAsync("SendRemoveHelper", new ResponseCommon<object>(null, ex.Message, false));
            }

        }


        /*
        * Hàm gửi tin nhắn
        */
        public async Task SendMessages(string message, string roomId)
        {
            try
            {
                var userId = Context.GetHttpContext().Request.Query["userId"];

                var infor = new
                {
                    message = message,
                    from = int.Parse(userId)
                };
                await Clients.Group(roomId).SendAsync("SendMessageToRoom", new ResponseCommon<object>(infor, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(roomId).SendAsync("SendMessageToRoom", new ResponseCommon<object>(null, ex.Message, false));
            }

        }

        /*
        * Hàm gửi sticker
        */
        public async Task SendStickers(string message, string roomId)
        {
            try
            {
                var userId = Context.GetHttpContext().Request.Query["userId"];

                var infor = new
                {
                    message = message,
                    from = int.Parse(userId)
                };
                await Clients.Group(roomId).SendAsync("SendStickerToRoom", new ResponseCommon<object>(infor, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(roomId).SendAsync("SendStickerToRoom", new ResponseCommon<object>(null, ex.Message, false));
            }

        }


        /*
        * Hàm gửi đáp án của chủ phòng đã chọn cho mọi người trong nhóm
        */
        public async Task SendAnswer(int answer, string roomId, int totalExp, int currentQuestion, int numberCorrect)
        {
            var inforRoom = new
            {
                answer = answer,
                totalExp = totalExp,
                currentQuestion = currentQuestion,
                numberCorrect = numberCorrect
            };
            await Clients.Group(roomId).SendAsync("AnswerSelected", new ResponseCommon<object>(inforRoom, "", true)); //phát sự kiện cập nhật phòng
            await _hubRepostiory.UpdateRoomQuiz(roomId, currentQuestion + 1, totalExp);
        }



        /*
        * Hàm gửi đáp án của chủ phòng đã chọn cho mọi người trong nhóm
        */
        public async Task DoAgainQuiz(string roomId)
        {
            await Clients.Group(roomId).SendAsync("SendEventDoAgainQuiz", new ResponseCommon<object>(null, "", true)); //phát sự kiện cập nhật phòng
            await _hubRepostiory.UpdateRoomQuiz(roomId, 0, 0);
        }


        //================CHALLENGE========================



        /*
         * Hàm xử lý khi có user out khỏi trang lobby-challenge
         */
        public async Task OutLobbyChallenge(string examId)
        {
            try
            {
                var userIdOut = Context.GetHttpContext().Request.Query["userId"];

                //dựa vào examId và userId xem status ở bảng ExamUser = 1 hay 0
                /* Nếu status = 1 thì không xóa , nếu status = 0 thì xóa khỏi bảng examUser
                 * 
                 */
                var check = await _hubRepostiory.CheckStatusExamUser(int.Parse(userIdOut), examId);
                if (check) //status = 0 thì xóa khỏi bảng examUser
                {
                    await Groups.RemoveFromGroupAsync(Context.ConnectionId, examId);

                    await Clients.Group(examId).SendAsync("SendUserOutLobby", new ResponseCommon<object>(int.Parse(userIdOut), "User out lobby", true));
                }
                else //status = 1 thì không xóa
                {
                    await Groups.RemoveFromGroupAsync(Context.ConnectionId, examId);

                    await Clients.Group(examId).SendAsync("SendUserOutLobby", new ResponseCommon<object>(int.Parse(userIdOut), "User out lobby", true));
                }
            }
            catch (Exception e)
            {
                await Clients.Group(examId).SendAsync("SendUserOutLobby", new ResponseCommon<object>(null, e.Message, false));

            }

        }





        /*
        * Hàm xử lý khi có user vào trang lobby-challenge
        */
        public async Task JoinLobbyChallenge(string examId)
        {
            var userId = Context.GetHttpContext().Request.Query["userId"];

            try
            {
                if (examId != null && examId.Length > 0)
                {
                    var result = await _hubRepostiory.GetUserInforById(int.Parse(userId));
                    await Groups.AddToGroupAsync(Context.ConnectionId, examId);

                    if (result != null)
                    {
                        await Clients.Group(examId).SendAsync("SendUserJoinLobby", new ResponseCommon<object>(result, "User join lobby", true));
                    }
                    else
                    {
                        await Clients.Group(examId).SendAsync("SendUserJoinLobby", new ResponseCommon<object>(null, "not found user join lobby", false));
                    }
                }
            }
            catch (Exception ex)
            {
                await Clients.Groups(userId.ToString()).SendAsync("SendUserJoinLobby", new ResponseCommon<object>(null, ex.Message, false)); //phát sự kiện kèm lỗi
            }

        }


        /*
        * Hàm xử lý khi có user vào trang do-challenge
        */
        public async Task JoinChallenge(string examId)
        {
            var userId = Context.GetHttpContext().Request.Query["userId"];

            try
            {
                if (examId != null && examId.Length > 0)
                {
                    var result = await _hubRepostiory.CheckUserOnlyDoChallenge(int.Parse(userId), examId);

                    await Groups.AddToGroupAsync(Context.ConnectionId, examId);

                    if (result != null && result)
                    {
                        var chall = await _hubRepostiory.GetInfoChallenge(examId);
                        if (chall != null && chall.date != null && chall.time_limit != null)
                        {
                            DateTime endTime = chall.date.Value.AddMinutes(chall.time_limit.Value);

                            // Tính thời gian còn lại
                            TimeSpan remainingTime = endTime - DateTime.Now;
                            if (remainingTime.TotalMilliseconds > 0)
                            {
                                await Clients.Group(examId).SendAsync("SendUserJoinChallenge", new ResponseCommon<object>(null, "success", true));

                                // Đợi cho đến khi cuộc thi kết thúc
                                await Task.Delay(remainingTime);

                                // Gửi sự kiện để user out khỏi challenge
                                await Clients.Group(examId).SendAsync("TimeOut", new ResponseCommon("Remaining time updated", true));
                                await _hubRepostiory.UpdateFinishChallenge(examId);
                                Console.WriteLine("timeout");
                            }
                            else
                            {
                                // Cuộc thi đã kết thúc
                                await _hubRepostiory.UpdateFinishChallenge(examId);
                            }
                        }
                    }
                    else
                    {
                        await Clients.Group(examId).SendAsync("SendUserJoinChallenge", new ResponseCommon<object>(null, "success", true));
                    }
                }
            }
            catch (Exception ex)
            {
                await Clients.Group(examId).SendAsync("SendUserJoinChallenge", new ResponseCommon<object>(null, ex.Message, false)); //phát sự kiện kèm lỗi
            }

        }



        /*
        * Hàm gửi tin nhắn lobby challenge
        */
        public async Task SendMessagesLobby(string message, string examId)
        {
            try
            {
                var userId = Context.GetHttpContext().Request.Query["userId"];

                var infor = new
                {
                    message = message,
                    from = int.Parse(userId)
                };
                await Clients.Group(examId).SendAsync("SendMessageToLobby", new ResponseCommon<object>(infor, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(examId).SendAsync("SendMessageToLobby", new ResponseCommon<object>(null, ex.Message, false));
            }

        }

        /*
        * Hàm gửi sticker lobby challenge
        */
        public async Task SendStickersLobby(string message, string examId)
        {
            try
            {
                var userId = Context.GetHttpContext().Request.Query["userId"];

                var infor = new
                {
                    message = message,
                    from = int.Parse(userId)
                };
                await Clients.Group(examId).SendAsync("SendStickerToLobby", new ResponseCommon<object>(infor, "", true));
            }
            catch (Exception ex)
            {
                await Clients.Group(examId).SendAsync("SendStickerToLobby", new ResponseCommon<object>(null, ex.Message, false));
            }

        }


        //public async Task JoinRoom(string roomId)
        //{
        //    await Groups.AddToGroupAsync(Context.ConnectionId, roomId);
        //    await Clients.Group(roomId).SendAsync("UserJoined", $"{Context.ConnectionId} has joined the room.");
        //}

        //public async Task LeaveRoom(string roomId)
        //{
        //    await Groups.RemoveFromGroupAsync(Context.ConnectionId, roomId);
        //    await Clients.Group(roomId).SendAsync("UserLeft", $"{Context.ConnectionId} has left the room.");
        //}

        //public async Task SendAnswerToRoom(string roomId, int answer)
        //{
        //    await Clients.Group(roomId).SendAsync("AnswerSubmitted", answer, Context.ConnectionId);
        //}
    }
}
