using Microsoft.AspNetCore.Identity;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC003;
using QuizArenaBE.Services.Common;
using System.Data.SqlClient;
using System.Text;
using Quiz = QuizArenaBE.Entity.SRC001.Quiz;

namespace QuizArenaBE.Repository.SRC001
{
    public class UserRepository : IUserRepository
    {
        private readonly ICRUDcommon _crudCommon;

        public UserRepository(ICRUDcommon crudCommon)
        {
            _crudCommon = crudCommon;
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }

        #region Method select

        public async Task<bool> IsEmailInUse(int userId, string email)
        {
            // Viết truy vấn Dapper để kiểm tra xem email đã tồn tại trong cơ sở dữ liệu chưa
            string sql = "SELECT COUNT(*) FROM Users WHERE Email = @Email AND user_id != @UserId";
            var parameters = new
            {
                Email = email,
                UserId = userId
            };
            var count = await _crudCommon.QueryFirstOrDefaultAsync<int>(sql, parameters);

            return count > 0;
        }

        public async Task<bool> IsEmailInRegister(string email)
        {
            string sql = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
            var parameters = new { Email = email };
            var count = await _crudCommon.QueryFirstOrDefaultAsync<int>(sql, parameters);

            return count > 0;
        }

        public async Task<Users?> GetUserById(int userId)
        {
            string query = "SELECT * FROM Users WHERE [user_id] = @UserId";
            var param = new { UserId = userId };

            var user = await _crudCommon.QuerySingleOrDefaultAsync<Users>(query, param);

            return user;
        }
        public async Task<bool> CheckOldPassword(int userId, string oldPassword)
        {
            // Truy vấn cơ sở dữ liệu để lấy mật khẩu đã lưu trữ
            string sql = "SELECT Password FROM Users WHERE user_id = @UserId";
            var parameters = new { UserId = userId };
            var storedPassword = await _crudCommon.QueryFirstOrDefaultAsync<string>(sql, parameters);

            // Kiểm tra mật khẩu cũ
            return oldPassword == storedPassword;
        }

        public async Task<Users?> GetUser(string username = "", string password = "", string mail = "", int? userId = null)
        {
            StringBuilder query = new StringBuilder();
            query.AppendLine("SELECT top (1) * FROM Users WHERE 1 = 1 ");
            if (!username.Equals(""))
            {
                query.AppendLine("AND [username] = @Username");
            }
            if (!username.Equals("") && !password.Equals(""))
            {
                query.AppendLine("AND [username] = @Username AND [password] = @Password");
            }
            if (!mail.Equals(""))
            {
                query.AppendLine("AND [email] = @Mail");
            }
            if (userId != null)
            {
                query.AppendLine("AND [user_id] = @UserId");
            }
            var param = new
            {
                Username = username,
                Password = password,
                Mail = mail,
                UserId = userId
            };

            var user = await _crudCommon.QuerySingleOrDefaultAsync<Users>(query.ToString(), param);

            return user;
        }

        public async Task<List<HistoryUser>?> GetHistoryUser(int quizid, int userId)
        {
            string query = @$"SELECT 
                                [history_id]
                                ,[user_id]
                                ,[action_type]
                                ,[quiz_id]
                                ,[date_action]
                              FROM [dbo].[HistoryUser]
                              where 
                                user_id = {userId}
                                and quiz_id is not null
                                and quiz_id = {quizid}
                                and action_type = 1";
            var result = await _crudCommon.QueryAsync<HistoryUser>(query);
            if (result == null || result.Count() == 0) { return null; }
            return result.ToList();
        }

        public async Task<FriendInfo> GetFriendRequest(int userId, int friendId)
        {
            // Lấy thông tin lời mời kết bạn dựa trên user_id và friend_id
            string sql = "SELECT * FROM [dbo].[Friends] WHERE [user_id] = @UserId AND [friend_id] = @FriendId";
            var param = new { UserId = userId, FriendId = friendId };

            return await _crudCommon.QuerySingleOrDefaultAsync<FriendInfo>(sql, param);
        }

        public async Task<bool> AreFriends(int userId, int friendId)
        {
            string sql = @"
                    SELECT COUNT(*) 
                    FROM [dbo].[Friends] 
                    WHERE 
                    (([user_id] = @UserId AND [friend_id] = @FriendId) OR ([user_id] = @FriendId AND [friend_id] = @UserId))
                    AND [status] = 1";

            var param = new { UserId = userId, FriendId = friendId };

            int count = await _crudCommon.ExecuteScalarAsync<int>(sql, param);

            return count > 0;
        }

        public async Task<bool> AddFriendRequest(int userId, int friendId, int status)
        {
            // Thêm lời mời kết bạn mới vào cơ sở dữ liệu
            string sql = "INSERT INTO [dbo].[Friends] ([user_id], [friend_id], [status]) VALUES (@UserId, @FriendId, @Status)";
            var param = new { UserId = userId, FriendId = friendId, Status = status };

            int affectedRows = await _crudCommon.ExecuteAsync(sql, param);
            return affectedRows > 0;
        }

        public async Task<FriendInfo> GetFriend(int userId, int friendId)
        {
            // Lấy thông tin lời mời kết bạn dựa trên user_id và friend_id
            string sql = "SELECT * FROM [dbo].[Friends] WHERE [user_id] = @UserId AND [friend_id] = @FriendId ";
            var param = new { UserId = userId, FriendId = friendId };

            return await _crudCommon.QuerySingleOrDefaultAsync<FriendInfo>(sql, param);
        }

        public async Task<IEnumerable<FriendNotification>> GetFriendNotifications(int userId)
        {
            // Lấy danh sách thông báo và danh sách những người chưa xác nhận kết bạn từ cơ sở dữ liệu
            string sql = @"
                SELECT 
                    f.[user_id] AS UserId,
                    u.[username] AS Username,
                    'You have a new friend request from ' + u.[username] AS NotificationMessage
                FROM [dbo].[Friends] f
                INNER JOIN [dbo].[Users] u ON f.[user_id] = u.[user_id]
                WHERE f.[friend_id] = @UserId AND f.[status] = 0";

            var param = new { UserId = userId };

            return await _crudCommon.QueryAsync<FriendNotification>(sql, param);
        }

        public async Task<IEnumerable<FriendInfo>> GetFriendRequests(int userId)
        {
            // Lấy danh sách lời mời kết bạn chưa được xác nhận
            string sql = @"SELECT U.[user_id] AS UserId
                        ,U.[username] AS Username
                        ,U.[fullname] AS Fullname
                        ,U.[email] AS Email
                        ,U.[images] AS Images
                        ,F.[status] AS Status
                    FROM [dbo].[Users] U
                    JOIN [dbo].[Friends] F ON U.[user_id] = F.[friend_id]
                    WHERE F.[user_id] = @UserId AND F.[status] = 0";

            var param = new { UserId = userId };

            var friendRequests = await _crudCommon.QueryAsync<FriendInfo>(sql, param);
            return friendRequests;
        }

        public async Task<IEnumerable<FriendInfo>> GetFriends(int userId, string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            // Tạo câu lệnh SQL cơ bản
            string sql = @"SELECT U.[user_id] AS UserId
                ,F.[friend_id] AS UserId
                ,U.[username] AS Username
                ,U.[fullname] AS Fullname
                ,U.[email] AS Email
                ,U.[images] AS Images
                ,U.[status] AS Status
            FROM [dbo].[Users] U
            JOIN [dbo].[Friends] F ON U.[user_id] = F.[friend_id]
            WHERE F.[user_id] = @UserId AND F.[status] = 1";

            // Kiểm tra nếu có từ khóa tìm kiếm
            if (!string.IsNullOrEmpty(searchTerm))
            {
                sql += " AND (U.[fullname] LIKE @SearchTerm OR U.[username] LIKE @SearchTerm OR U.[email] LIKE @SearchTerm)";
            }

            // Thêm phần phân trang
            sql += " ORDER BY U.[fullname] OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            // Tính toán Offset dựa trên pageNumber và pageSize
            int offset = (page - 1) * pageSize;

            // Tạo đối tượng param
            var param = new
            {
                UserId = userId,
                SearchTerm = string.IsNullOrEmpty(searchTerm) ? "%" : $"%{searchTerm}%", // Nếu không có từ khóa, thì hiển thị tất cả
                Offset = offset,
                PageSize = pageSize
            };

            // Thực hiện truy vấn
            var acceptedFriends = await _crudCommon.QueryAsync<FriendInfo>(sql, param);
            return acceptedFriends;
        }


        public async Task<IEnumerable<SearchModel>> SearchUser()
        {
            // Triển khai logic tìm kiếm user dựa trên searchTerm trong cơ sở dữ liệu
            string sql = "SELECT [user_id], fullname as [name], [images] as image  FROM Users ";


            var searchResult = await _crudCommon.QueryAsync<SearchModel>(sql);
            return searchResult;
        }

        public async Task<IEnumerable<SearchModel>> SearchQuiz()
        {
            string sql = "SELECT [quiz_id],title as [name], [image] FROM Quizzes where status != -1 and quiz_type<>3";


            var searchResult = await _crudCommon.QueryAsync<SearchModel>(sql);
            return searchResult;
        }

        public async Task<IEnumerable<SearchModel>> SearchExam()
        {
            string sql = "SELECT [exam_id],exam_name as [name], [image] FROM Exam";


            var searchResult = await _crudCommon.QueryAsync<SearchModel>(sql);
            return searchResult;

        }

        public async Task<List<FriendsOnOrOffModel>?> GetFriendsOnOrOff(int userId, string roomId)
        {
            string query = @$"DECLARE @TableFriend TABLE (friend_id int NOT NULL);
                            INSERT INTO @TableFriend (friend_id)
                            SELECT friend_id
	                            FROM [dbo].[Friends]
	                            where user_id = @UserId AND status = 1;

                            SELECT [user_id]
	                            ,[username]
	                            ,[fullname]
	                            ,[images]
	                            ,[status]
	                            ,(CASE
		                            WHEN (select count(*) from [UserRoomQuiz] where user_id = [Users].user_id and room_id = @RoomId  ) > 0 THEN 1
		                            WHEN (select count(*) from [UserRoomQuiz] where user_id = [Users].user_id and room_id != @RoomId ) > 0 THEN 2
		                            ELSE 0
		                            END ) as statusInvite
                            FROM [QuizArenaSQL].[dbo].[Users]
                            where user_id in (select friend_id from @TableFriend)";
            var param = new
            {
                UserId = userId,
                RoomId = roomId
            };
            var result = await _crudCommon.QueryAsync<FriendsOnOrOffModel>(query, param);
            if (result == null || result.Count() == 0) { return null; }
            return result.ToList();


        }

        public async Task<IEnumerable<Notification>> GetNotification(int UserId)
        {
            string sql = @$"SELECT TOP (10) [user_id]
                              ,[content_notification]
                              ,[value]
                              ,[date_notification]
                          FROM [QuizArenaSQL].[dbo].[Notification]
                          where user_id = {UserId}
                          Order by date_notification desc";


            var Result = await _crudCommon.QueryAsync<Notification>(sql);
            return Result;

        }

        #endregion Method select

        #region Method Insert

        public async Task InsertNewUser(RegisterReq request)
        {
            string query = @"INSERT INTO [dbo].[Users]
                    ([username]
                    ,[email]
                    ,[password]
                    ,[role]
                    ,[exp]
                    ,[score]
                    ,[created_at]
                    ,[updated_at]
                    ,[fullname])
                    VALUES
                    (@Username
                    ,@Mail
                    ,@Password
                    ,4
                    ,0
                    ,0
                    ,@CreatedAt
                    ,@UpdatedAt
                    ,@Fullname)";

            var param = new
            {
                Username = request.username,
                Password = request.password,
                Mail = request.email,
                Fullname = request.fullname,
                CreatedAt = DateTime.Now,
                UpdatedAt = DateTime.Now,
            };

            await _crudCommon.Execute(query, param);
        }

        public async Task InsertHistoryUser(int userId, int? quizId = null)
        {
            string query = "";
            if (quizId != null)
            {
                query = @"INSERT INTO [dbo].[HistoryUser]
                                   ([user_id]
                                   ,[action_type]
                                   ,[quiz_id]
                                   ,[date_action])
                             VALUES
                                   (@userid
                                   ,1
                                   ,@quizid
                                   ,@dateaction)";
            }
            else
            {
                query = @"INSERT INTO [dbo].[HistoryUser]
                                   ([user_id]
                                   ,[action_type]
                                   ,[date_action])
                             VALUES
                                   (@userid
                                   ,2
                                   ,@dateaction)";
            }


            var param = new
            {
                userid = userId,
                quizid = quizId,
                dateaction = DateTime.Now,
            };

            await _crudCommon.Execute(query, param);
        }

        public async Task InsertNotification(int userId, string? content = "", string? value = "")
        {
            string query = @"INSERT INTO [dbo].[Notification]
                                   ([user_id]
                                   ,[content_notification]
                                   ,[value]
                                   ,[date_notification])
                             VALUES
                                   (@userid
                                   ,@contentNotification
                                   ,@Value
                                   ,GETDATE())";
           


            var param = new
            {
                userid = userId,
                contentNotification = content,
                Value = value,
            };

            await _crudCommon.Execute(query, param);
        }

        public async Task<bool> SendFriendRequest(int userId, int friendId)
        {
            // Check if they are already friends
            string areFriendsSql = @"
                    SELECT COUNT(*) 
                    FROM [dbo].[Friends] 
                    WHERE 
                    (([user_id] = @UserId AND [friend_id] = @FriendId) OR ([user_id] = @FriendId AND [friend_id] = @UserId))
                    AND [status] = 1";

            var areFriendsParam = new { UserId = userId, FriendId = friendId };
            int areFriendsCount = await _crudCommon.ExecuteScalarAsync<int>(areFriendsSql, areFriendsParam);

            if (areFriendsCount > 0)
            {
                // If they are already friends, cannot send a new friend request
                Console.WriteLine("These two users are already friends.");
                return false;
            }

            // Check if there is an existing friend request from userId to friendId
            string checkExistingRequestSql = @"
                            SELECT COUNT(*) 
                            FROM [dbo].[Friends] 
                            WHERE 
                            ([user_id] = @UserId AND [friend_id] = @FriendId AND [status] = 0)
                            OR
                            ([user_id] = @FriendId AND [friend_id] = @UserId AND [status] = 0)";

            var checkExistingRequestParam = new { UserId = userId, FriendId = friendId };
            int existingRequestsCount = await _crudCommon.ExecuteScalarAsync<int>(checkExistingRequestSql, checkExistingRequestParam);

            if (existingRequestsCount > 0)
            {
                // If there is an existing friend request, do not add a new one
                Console.WriteLine("There is already a pending friend request.");
                return false;
            }

            // Add a new friend request
            string addFriendRequestSql = @"INSERT INTO [dbo].[Friends] ([user_id], [friend_id], [status]) 
                            VALUES 
                            (@UserId, @FriendId, 0)";

            var addFriendRequestParam = new { UserId = userId, FriendId = friendId };
            int affectedRows = await _crudCommon.ExecuteAsync(addFriendRequestSql, addFriendRequestParam);

            if (affectedRows > 0)
            {
                // Truy vấn SQL để lấy tên người dùng từ bảng Users
                string getUsernameSql = "SELECT [username] FROM [dbo].[Users] WHERE [user_id] = @UserId";

                // Thực hiện truy vấn để lấy tên người dùng
                var username = await _crudCommon.ExecuteScalarAsync<string>(getUsernameSql, new { UserId = userId });

                if (!string.IsNullOrEmpty(username))
                {
                    // Thêm thông báo vào bảng Notification
                    string addNotificationSql = @"INSERT INTO [dbo].[Notification] ([user_id], [content_notification], [value], [date_notification]) 
                                                  VALUES 
                                                  (@UserId, @Content, @Value, GETDATE())";

                    var addNotificationParam = new { UserId = friendId, Content = $"{username} send a friend request to you", Value = $"/profile-orther/{userId}" };
                    await _crudCommon.ExecuteAsync(addNotificationSql, addNotificationParam);
                }
            }


            return affectedRows > 0;
        }

        public async Task InsertPayment(PaymentInfo request)
        {
            string query = @"INSERT INTO [dbo].[Payments]
                                   ([user_id]
                                   ,[amount]
                                   ,[payment_date]
                                   ,[payment_method])
                             VALUES
                                   (@userId
                                   ,@amount
                                   ,@paymentDate
                                   ,@paymentMethod)";

            var param = new
            {
                userId = request.UserId,
                amount = request.Amount,
                paymentDate = DateTime.Now,
                paymentMethod = request.PaymentMethod,
            };

            await _crudCommon.Execute(query, param);
        }


        #endregion Method Insert

        #region Method Update

        public async Task<int> UpdateUserInfo(int userId, UserUpdateModel user, Users oldUser)
        {
            // Tạo câu lệnh SQL để cập nhật thông tin người dùng
            string sql = @"UPDATE Users 
                        SET 
                            Fullname = COALESCE(NULLIF(@fullname, ''), @OldFullname), 
                            Email = COALESCE(NULLIF(@email, ''), @OldEmail), 
                            Images = COALESCE(NULLIF(@images, ''), @OldImages), 
                            Description = COALESCE(NULLIF(@description, ''), @OldDescription),
                            EXP = COALESCE(NULLIF(@EXP, 0), @OldEXP)
                        WHERE user_id = @UserId;";

            // Tạo đối tượng param chứa các tham số
            var param = new
            {
                UserId = userId,
                fullname = user.Fullname,
                OldFullname = oldUser.Fullname,
                email = user.Email,
                OldEmail = oldUser.Email,
                images = user.Images,
                OldImages = oldUser.Images,
                description = user.Description,
                OldDescription = oldUser.Description,
                EXP = user.Exp,
                OldEXP = oldUser.Exp
            };


            // Sử dụng Dapper để thực hiện câu lệnh SQL
            var rowsAffected = await _crudCommon.Execute(sql.ToString(), param);

            return rowsAffected;
        }

        public async Task<int> UpdatePassword(int id, string pass)
        {
            string sql = @"UPDATE [dbo].[Users]
                               SET [password] = @Pass
                             WHERE  [user_id] = @Id";
            var param = new
            {
                Id = id,
                Pass = pass
            };
            return await _crudCommon.Execute(sql, param);
        }

        public async Task UpdateTokenUser(int id, string token)
        {
            string sql = @"UPDATE [dbo].[Users]
                               SET token = @Token
                             WHERE  [user_id] = @Id";
            var param = new
            {
                Id = id,
                Token = token
            };
            await _crudCommon.Execute(sql, param);
        }

        public async Task<int> ResetSession()
        {
            string sql = @"UPDATE [dbo].[Users]
                            SET [role] = 4
                            WHERE [role] = 5

                            UPDATE [dbo].[Users]
                            SET [exp] = 0, token =''
                            WHERE [role] = 4
                            and user_id in (SELECT [user_id]      
                            FROM [dbo].[Users]
                            where [role] = 4
                            and [exp] BETWEEN 0 AND 999)

                            UPDATE [dbo].[Users]
                            SET [exp] = 500, token =''
                            WHERE [role] = 4
                            and user_id in (SELECT [user_id]      
                            FROM [dbo].[Users]
                            where [role] = 4
                            and [exp] BETWEEN 1000 AND 9999)

                            UPDATE [dbo].[Users]
                            SET [exp] = 1000, token =''
                            WHERE [role] = 4
                            and user_id in (SELECT [user_id]      
                            FROM [dbo].[Users]
                            where [role] = 4
                            and [exp] >= 10000)

                            DECLARE @QuizAndQuestion table(
                            [quiz_id] INT  NULL,
                            [question_id] INT  NULL)
                            insert into @QuizAndQuestion
                            SELECT [quiz_id]
                                  ,[question_id]
                              FROM [dbo].[QuestionsAttempts]
                              where quiz_id in (SELECT quiz_id FROM [dbo].[Quizzes] where quiz_type = 3 and status = -1)

                            delete [QuestionsAttempts] where quiz_id in (select [quiz_id] from @QuizAndQuestion)
                            delete [Quizzes] where quiz_id in (select [quiz_id] from @QuizAndQuestion)
                            delete [Questions] where question_id in (select [question_id] from @QuizAndQuestion)

                            delete [dbo].[HistoryUser] where action_type=1

                            UPDATE [dbo].[Users]
                            SET [score] = 0";
            try
            {
                var result = await _crudCommon.Execute(sql);
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<bool> ConfirmFriendRequest(int userId, int friendId)
        {
            // Kiểm tra xem đã tồn tại lời mời từ friendId đến userId chưa
            string checkExistingRequestSql = @"
                        SELECT COUNT(*) 
                        FROM [dbo].[Friends] 
                        WHERE 
                        ([user_id] = @UserId AND [friend_id] = @FriendId AND [status] = 0)
                        OR
                        ([user_id] = @FriendId AND [friend_id] = @UserId AND [status] = 0)";

            var checkExistingRequestParam = new { UserId = friendId, FriendId = userId };
            int existingRequestsCount = await _crudCommon.ExecuteScalarAsync<int>(checkExistingRequestSql, checkExistingRequestParam);

            if (existingRequestsCount > 0)
            {
                // Nếu đã tồn tại lời mời, thực hiện cập nhật trạng thái và đảm bảo tính đối xứng
                string updateFriendRequestSql = @"
                            UPDATE [dbo].[Friends] 
                            SET [status] = 1 
                            WHERE [user_id] = @FriendId AND [friend_id] = @UserId;

                            INSERT INTO [dbo].[Friends] ([user_id], [friend_id], [status]) 
                            VALUES 
                            (@UserId, @FriendId, 1)";

                var updateFriendRequestParams = new { UserId = userId, FriendId = friendId };

                int affectedRows = await _crudCommon.ExecuteAsync(updateFriendRequestSql, updateFriendRequestParams);

                return affectedRows > 0;
            }

            return false;
        }

        #endregion Method Update

        #region Method Delete

        public async Task<bool> DeclineFriendRequest(int userId, int friendId)
        {
            // Xóa yêu cầu kết bạn từ cơ sở dữ liệu
            string deleteFriendRequestSql = @"
        DELETE FROM [dbo].[Friends] 
        WHERE ([user_id] = @UserId AND [friend_id] = @FriendId)
           OR ([user_id] = @FriendId AND [friend_id] = @UserId);";

            var deleteFriendRequestParam = new { UserId = userId, FriendId = friendId };

            int affectedRows = await _crudCommon.ExecuteAsync(deleteFriendRequestSql, deleteFriendRequestParam);

            return affectedRows > 0;
        }

        #endregion Method Delete
    }
}
