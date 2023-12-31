using Dapper;
using Microsoft.Extensions.Configuration;
using QuizArenaBE.Entity.Hub;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC002;
using QuizArenaBE.Services.Common;
using System.Data;
using System.Data.SqlClient;

namespace QuizArenaBE.Repository.Hub
{
    public class HubRepostiory : IHubRepostiory
    {
        private readonly ICRUDcommon _crudCommon;
        private readonly IConfiguration _configuration;
        private readonly IDbConnection _dbConnection;

        public HubRepostiory(ICRUDcommon crudCommon, IConfiguration configuration)
        {
            _crudCommon = crudCommon;
            _configuration = configuration;
            _dbConnection = new SqlConnection(_configuration.GetConnectionString("QuizArenaSQL"));
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }


        #region Method Select

        public async Task<IEnumerable<string>> GetFriendOnline(int userid)
        {
            // Code cập nhật trạng thái
            string sql = @"SELECT DISTINCT
                                Friends.friend_id
                            FROM Friends
                            INNER JOIN UserRoomQuiz ON Friends.friend_id = UserRoomQuiz.user_id
                            INNER JOIN Users ON Friends.friend_id = Users.user_id
                            WHERE Friends.user_id = @UserId
                                AND Friends.status = 1
                                AND UserRoomQuiz.role = 1
                                AND Users.status = 1;";
            // Tạo đối tượng param chứa các tham số
            var param = new
            {
                UserId = userid
            };
            // Sử dụng Dapper để thực hiện câu lệnh SQL
            var data = await _crudCommon.QueryAsync<string>(sql.ToString(), param);
            return data;
        }

        public async Task<Entity.SRC001.Quiz?> GetTitleQuizByRoomID(string roomId)
        {
            // Code cập nhật trạng thái
            string sql = @" select u.title, u.quiz_id from Quizzes as U
                                inner join RoomQuiz as F on U.quiz_id = F.quiz_id
                                where F.room_id = @RoomId";
            // Tạo đối tượng param chứa các tham số
            var param = new
            {
                RoomId = roomId
            };
            // Sử dụng Dapper để thực hiện câu lệnh SQL
            var data = await _crudCommon.QueryFirstOrDefaultAsync<Entity.SRC001.Quiz>(sql.ToString(), param);
            return data;
        }

        public async Task<Users?> GetUserInforById(int userId)
        {
            // Code cập nhật trạng thái
            string sql = @" SELECT [username]
                                    ,[fullname]
                                    ,[images]
                                    ,[user_id]
                                      FROM [QuizArenaSQL].[dbo].[Users]
                                      WHERE user_id = @UserId";
            // Tạo đối tượng param chứa các tham số
            var param = new
            {
                UserId = userId
            };
            // Sử dụng Dapper để thực hiện câu lệnh SQL
            var data = await _crudCommon.QueryFirstOrDefaultAsync<Users>(sql.ToString(), param);
            return data;
        }

        public async Task<bool> CheckRoomIdExists(string roomId)
        {

            string sql = "SELECT room_id FROM RoomQuiz WHERE room_id = @roomId";
            var parameters = new { roomId = roomId };
            var room_idDB = await _crudCommon.QueryFirstOrDefaultAsync<string>(sql, parameters);
            return room_idDB != null;
        }

        public async Task<GetUserInRoomModle> GetUserInRoom(string roomId, int userId)
        {

            string sql = @$"SELECT TOP (1) user_id
                            FROM [dbo].[UserRoomQuiz]
                            where room_id = @RoomId
                            and role = 1";
            var parameters = new { RoomId = roomId };

            var IsUserBoss = await _crudCommon.QuerySingleOrDefaultAsync<int?>(sql, parameters);
            IsUserBoss = IsUserBoss == userId ? null : IsUserBoss; //IsUserBoss có thì là tạo phòng

            string sql1 = @$"SELECT  user_id
                              FROM [dbo].[UserRoomQuiz]
                              where user_id in (SELECT [friend_id] FROM [dbo].[Friends] where user_id = @UserId and status = 1 and (ISNULL(@isUserBoss,1) = 1 or friend_id != @isUserBoss))
                              and role = 1";
            var parametersNew = new
            {
                userId = userId,
                isUserBoss = IsUserBoss
            };

            var listUserId = await _crudCommon.QueryAsync<string>(sql1, parametersNew);

            var output = new GetUserInRoomModle
            {
                UserIdBoss = IsUserBoss,
                ListUserId = listUserId.ToList(),
            };
            return output;
            ;
        }

        #endregion Method Select

        #region Method Update and Insert
        public async Task UpdateStatusUser(int userid, int status)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"UPDATE Users 
                        SET 
                            status = @Status
                        WHERE user_id = @UserId;";
                // Tạo đối tượng param chứa các tham số
                var param = new
                {
                    UserId = userid,
                    Status = status
                };
                await _dbConnection.ExecuteAsync(sql, param, Transaction);

                Transaction.Commit();
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }


        public async Task UpdateRoleUserRoomQuiz(int userid, int role, string roomId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"UPDATE [UserRoomQuiz] 
                            SET role = 0
                            WHERE role = @Role and room_id = @RoomId

                        UPDATE [UserRoomQuiz] 
                        SET role = @Role
                        WHERE user_id = @UserId and room_id = @RoomId";
                // Tạo đối tượng param chứa các tham số
                var param = new
                {
                    UserId = userid,
                    Role = role,
                    RoomId = roomId
                };
                await _dbConnection.ExecuteAsync(sql, param, Transaction);

                Transaction.Commit();
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task RemoveHelperUserRoomQuiz(string roomId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"UPDATE [UserRoomQuiz] 
                            SET role = 0
                            WHERE role = 2 and room_id = @RoomId";
                // Tạo đối tượng param chứa các tham số
                var param = new
                {
                    RoomId = roomId
                };
                await _dbConnection.ExecuteAsync(sql, param, Transaction);

                Transaction.Commit();
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task UpdateRoomQuiz(string roomId, int currentQuestion, int totalExp)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"UPDATE [dbo].[RoomQuiz]
                               SET [current_question] = @CurrentQuestion
                                  ,[total_exp] = @TotalExp
                             WHERE [room_id] = @RoomId";
                // Tạo đối tượng param chứa các tham số
                var param = new
                {
                    CurrentQuestion = currentQuestion,
                    TotalExp = totalExp,
                    RoomId = roomId
                };
                await _dbConnection.ExecuteAsync(sql, param, Transaction);

                Transaction.Commit();
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task CreateRoom(int UserId, string RoomId, int QuizId, int? CurrentQuestion = null, int? TotalExp = null)
        {
            string query = @"INSERT INTO [dbo].[RoomQuiz]
                                   ([room_id]
                                   ,[quiz_id]
                                   ,[current_question]
                                   ,[total_exp])
                             VALUES
                                   (@roomId
                                   ,@quizId
                                   ,ISNULL(@currentQuestion , 0)
                                   ,ISNULL(@totalExp , 0))

                           INSERT INTO [dbo].[UserRoomQuiz]
                                               ([room_id]
                                               ,[user_id]
                                               ,[role])
                                         VALUES
                                               (@roomId
                                               ,@userID
                                               ,1)";
            var param = new
            {
                userID = UserId,
                roomId = RoomId,
                quizId = QuizId,
                currentQuestion = CurrentQuestion,
                totalExp = TotalExp,
            };

            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                await _dbConnection.ExecuteAsync(query, param, Transaction);
                Transaction.Commit();
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<int> GetUserOutQuiz(int userId, string roomId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                var checkStatus = 0;
                string sqlBoss = @"SELECT count(*) FROM [dbo].[UserRoomQuiz] where room_id = @RoomId and user_id = @UserId and role = 1";
                string sqlUser = @"SELECT count(*) FROM [dbo].[UserRoomQuiz] where room_id = @RoomId and user_id = @UserId and role <> 1";

                var param = new
                {
                    RoomId = roomId,
                    UserId = userId
                };
                var outputBoss = await _dbConnection.QueryFirstOrDefaultAsync<int>(sqlBoss, param, Transaction);
                var outputUser = await _dbConnection.QueryFirstOrDefaultAsync<int>(sqlUser, param, Transaction);
                if (outputBoss > 0)
                {
                    checkStatus = 1;
                    string DeleteBoss = @"DELETE FROM [dbo].[UserRoomQuiz]
                                        WHERE room_id = @RoomId	 
                                        DELETE FROM [dbo].[RoomQuiz]
                                        WHERE room_id = @RoomId";
                    await _dbConnection.ExecuteAsync(DeleteBoss, param, Transaction);
                }
                else if (outputUser > 0)
                {
                    checkStatus = 2;
                    string DeleteUser = @"DELETE FROM [dbo].[UserRoomQuiz]
                                        WHERE room_id = @RoomId and user_id = @UserId";
                    await _dbConnection.ExecuteAsync(DeleteUser, param, Transaction);
                }
                Transaction.Commit();
                return checkStatus;
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }


        public async Task<bool> CheckUserOnlyDoChallenge(int userId, string examId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sqlBoss = @"SELECT count(*)
                                      FROM[dbo].[ExamUser]
                                      where [exam_id]=@ExamId
                                      and [status] = 1";

                var param = new
                {
                    ExamId = examId,
                    UserId = userId
                };

                var result = await _dbConnection.QuerySingleAsync<int>(sqlBoss, param, Transaction);


                Transaction.Commit();
                return result == 1 ? true : false;
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<ExamListTopModel> GetInfoChallenge(string examId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sqlBoss = @"SELECT [exam_id] as examId
                                  ,[exam_name] as examName
                                  ,E.[description] as description
                                  ,[exam_type]
                                  ,E.[image]
                                  ,E.[status]
	                              ,Q.time_limit
                                  ,[date]
                              FROM [QuizArenaSQL].[dbo].[Exam] as E
                              inner join Quizzes as Q on Q.quiz_id=E.quiz_id
                              where exam_id = @ExamId";

                var param = new
                {
                    ExamId = examId
                };

                var result = await _dbConnection.QuerySingleAsync<ExamListTopModel>(sqlBoss, param, Transaction);

                Transaction.Commit();
                return result;
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<int> UpdateFinishChallenge(string examId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sqlBoss = @"UPDATE [dbo].[Exam]
                                   SET [status] = 5
                                 WHERE exam_id = @ExamId

                                    UPDATE [dbo].[ExamUser]
                                       SET [status] = 2
                                     WHERE exam_id = @ExamId and status = 1";
                var param = new
                {
                    ExamId = examId
                };
                var result = await _dbConnection.ExecuteAsync(sqlBoss, param, Transaction);

                Transaction.Commit();

                return result;

            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        #endregion Method Update and Insert

        #region Method Delete
        public async Task<bool> CheckStatusExamUser(int userid, string examid)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"SELECT COUNT(*)
	                          FROM [QuizArenaSQL].[dbo].[ExamUser]
	                          where exam_id = @ExamId
	                          and user_id = @UserId
	                          and status = 0";
                string sqlDelete = @"DELETE FROM [dbo].[ExamUser]
                                    where exam_id = @ExamId and user_id = @UserId and status = 0";
                var param = new
                {
                    UserId = userid,
                    ExamId = examid
                };
                var count = await _dbConnection.QueryFirstOrDefaultAsync<int>(sql, param, Transaction);
                if (count == 0)
                {
                    return false;
                }
                await _dbConnection.ExecuteAsync(sqlDelete, param, Transaction);

                Transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                Transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }


        #endregion Method Delete
    }
}
