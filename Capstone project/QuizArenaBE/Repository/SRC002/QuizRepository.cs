using Dapper;
using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC002;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Transactions;
using static QuizArenaBE.Entity.SRC002.GetInforChallengeModel;
using static QuizArenaBE.Entity.SRC002.InsertQuizReq;
using static QuizArenaBE.Entity.SRC002.QuizModel;
using static System.Net.Mime.MediaTypeNames;

namespace QuizArenaBE.Repository.SRC002
{
    public class QuizRepository : IQuizRepository
    {
        private readonly IConfiguration _configuration;
        private readonly IDbConnection _dbConnection;
        public QuizRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _dbConnection = new SqlConnection(_configuration.GetConnectionString("QuizArenaSQL"));
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }
        public async Task<QuizModel> GetDataQuiz(int id, int userId)
        {
            var quizs = new QuizModel();
            string queryQuizz = @"SELECT top 1
                                Quizzes.quiz_id,
                                Quizzes.title,
                                Quizzes.category_id,
                                Quizzes.[description],
                                Quizzes.creator_id,
                                (CASE 
                                WHEN (select count(*) from Friends where user_id = Quizzes.creator_id and friend_id = @UserId and status = 1) > 0 THEN 1
                                ELSE 0
                                END) AS isFriendCreator,
                                Quizzes.quiz_type,
                                Quizzes.image,
                                Quizzes.status,
                                Quizzes.difficulty_level,
                                Quizzes.time_limit,
                                Quizzes.comment,
                                Quizzes.create_date,
                                Quizzes.updated_at	   
                                FROM Quizzes
                                where Quizzes.quiz_id = @Id
                                and Quizzes.status != -1";
            string queryQuestions = @"SELECT
	                                Questions.question_id,
                                    Questions.question_text,
							        Questions.difficulty_level,
	                                Questions.correct_answer,
                                    Questions.user_id,
							        Questions.category_id,
	                                Questions.status,					
	                                Questions.options
                                  FROM QuestionsAttempts
							        inner join Questions on Questions.question_id = QuestionsAttempts.question_id
                                    where QuestionsAttempts.quiz_id = @Id";
            var param = new
            {
                Id = id,
                UserId = userId,
            };
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {

                quizs.quizz = await _dbConnection.QuerySingleOrDefaultAsync<QuizzesSRC002>(queryQuizz, param, Transaction);
                quizs.questions = (List<QuestionsSRC002>?)await _dbConnection.QueryAsync<QuestionsSRC002>(queryQuestions, param, Transaction);
                Transaction.Commit();
                return quizs;
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

        public async Task<object> GetListQuiz(int userId)
        {
            string query = @"SELECT [quiz_id] as quizId
                                  ,[title] 
                                  ,[category_id] as categoryId
                                  ,[description]
                                  ,[quiz_type] as quizType
                                  ,[status]
                                  ,[image]
                                  ,[difficulty_level] as difficultyLevel
                                  ,[comment]
                                  ,[time_limit] as timeLimit
                                  ,[creator_id]
                                  ,[create_date] as createDate
                                  ,[updated_at]
                                  ,(SELECT count(*) from [QuestionsAttempts] where quiz_id = [Quizzes].quiz_id) as numberQues
                                    FROM [dbo].[Quizzes]
                                    where quiz_type =  3 and status=1
                                    and creator_id = @UserId";

            var param = new
            {
                UserId = userId,
            };
            _dbConnection.Open();
            try
            {

                var data = await _dbConnection.QueryAsync<dynamic>(query, param);
                return data;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<List<HistoryUser>> GetAllHistoryUser()
        {
            string query = @"SELECT * FROM [dbo].[HistoryUser]";


            _dbConnection.Open();
            try
            {

                var data = await _dbConnection.QueryAsync<HistoryUser>(query);
                return data.ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<List<QuizRecentPopular>> GetDataQuizPopular()
        {
            string query = @"SELECT 
                                Q.quiz_id,
                                Q.title,
                                C.category_name,
                                Q.description,
                                Q.image
                            FROM [dbo].[Quizzes] as Q
                            inner join [dbo].[Category] as C on Q.category_id = c.category_id
                            where 
                                quiz_id in 
                                    (SELECT TOP (10)
                                        quiz_id
                                    FROM [dbo].[HistoryUser]
                                    where  quiz_id IS NOT NULL 
                                    GROUP BY
                                        quiz_id
                                    ORDER BY
                                        COUNT(user_id) DESC)
                                AND Q.quiz_type = 1
                                and Q.status = 1";

            _dbConnection.Open();
            try
            {
                var result = await _dbConnection.QueryAsync<QuizRecentPopular>(query);
                return result.ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<List<ExamModel>> GetDataExamRecent()
        {
            string query = @"SELECT *
                          FROM [dbo].[Exam]
                          where status != 0
                          order by date desc";

            _dbConnection.Open();
            try
            {
                var result = await _dbConnection.QueryAsync<ExamModel>(query);
                return result.ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<List<QuizRecentPopular>?> GetDataQuizRecent(int userid)
        {
            string query = @$"SELECT 
                                Q.quiz_id,
                                Q.title,
                                C.category_name,
                                Q.description,
                                Q.image
                            FROM [dbo].[Quizzes] as Q
                            inner join [dbo].[Category] as C on Q.category_id = c.category_id
                            where 
                                quiz_id in 
                                    (SELECT TOP 10
                                        quiz_id
                                    FROM
                                    [dbo].[HistoryUser]
                                    WHERE
                                        quiz_id IS NOT NULL
                                        AND user_id = {userid}
                                    GROUP BY
                                        quiz_id
                                    ORDER BY
                                        MAX(date_action) DESC)
                                AND Q.quiz_type <> 2                                     
                                and Q.status = 1";

            _dbConnection.Open();
            try
            {
                var result = await _dbConnection.QueryAsync<QuizRecentPopular>(query);
                if (result == null || result.Count() == 0) { return null; }
                return result.ToList();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<bool> InsertDataQuiz(int userId, InsertQuizReq request)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                //insert Quizz
                string InsertQuizz = @"INSERT INTO [Quizzes]
                                   ([title]
                                   ,[status]
                                   ,[image] 
                                   ,[category_id]
                                   ,[description]
                                   ,[quiz_type]
                                  ,[difficulty_level]
                                   ,[time_limit]
                                   ,[creator_id]
                                   ,[create_date]
                                   ,[updated_at])
                     OUTPUT INSERTED.[quiz_id] VALUES 
                                   (@title                                   
                                   ,@status
                                   ,@image 
                                   ,@category_id
                                   ,@description
                                   ,@quiz_type
                                   ,@difficulty_level
                                   ,@time_limit
                                   ,@creator_id
                                   ,@create_date
                                   ,@updated_at)";

                var param = new
                {
                    title = request.quizz.Title,
                    category_id = request.quizz.CategoryId,
                    description = request.quizz.Description,
                    quiz_type = request.quizz.QuizType,
                    image = request.quizz.Image,
                    status = request.quizz.Status,
                    difficulty_level = request.quizz.DifficultyLevel,
                    time_limit = request.quizz.TimeLimit,
                    creator_id = userId,
                    create_date = DateTime.Now,
                    updated_at = DateTime.Now
                };
                var newQuizId = await _dbConnection.QuerySingleOrDefaultAsync<int?>(InsertQuizz, param, Transaction);
                if (newQuizId == null)
                {
                    Transaction.Rollback();
                    return false;
                }

                //insert Questions
                var listQuestionsIdNew = new List<int>();
                foreach (var item in request.questions)
                {
                    if (item.QuestionId == null || item.QuestionId == 0)
                    {
                        StringBuilder InsertQuestions = new StringBuilder();
                        InsertQuestions.AppendLine("INSERT INTO [dbo].[Questions] ([question_text], [difficulty_level], [correct_answer], [options])");
                        InsertQuestions.AppendLine($"OUTPUT INSERTED.[question_id] VALUES");
                        InsertQuestions.AppendLine($"(@QuestionText, @DifficultyLevel, @CorrectAnswer, @Options)");
                        listQuestionsIdNew.Add(await _dbConnection.QueryFirstAsync<int>(InsertQuestions.ToString(), item, transaction: Transaction));
                    }
                    else
                    {
                        listQuestionsIdNew.Add(item.QuestionId.Value);
                    }
                }


                var DataNewId = listQuestionsIdNew.Select(x => new QuestionsAttempt
                {
                    QuizId = newQuizId,
                    QuestionId = x,
                }).ToList();

                //insert QuestionsAttempts
                StringBuilder InsertQuestionsAttempts = new StringBuilder();
                InsertQuestionsAttempts.AppendLine("INSERT INTO [dbo].[QuestionsAttempts] ([quiz_id], [question_id])");
                InsertQuestionsAttempts.AppendLine($"VALUES");
                int checkQuestionsAttempts = 0;
                foreach (var item in DataNewId)
                {
                    if (checkQuestionsAttempts > 0)
                    {
                        InsertQuestionsAttempts.AppendLine(",");
                    }
                    InsertQuestionsAttempts.AppendLine($"({item.QuizId}, {item.QuestionId})");
                    checkQuestionsAttempts++;
                }

                await _dbConnection.ExecuteAsync(InsertQuestionsAttempts.ToString(), transaction: Transaction);

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

        public async Task<List<dynamic>> GetRandomQuestions(int count, int category, int level)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                //insert Questions
                string sql = @$"SELECT top {count} [question_id] as QuestionId
                                                  ,[question_text] as QuestionText
                                                  ,[difficulty_level] as DifficultyLevel
                                                  ,[category_id] as CategoryId
                                                  ,[user_id] as UserId
                                                  ,[correct_answer] as CorrectAnswer
                                                  ,[status] as Status
                                                  ,[options] as Options
                                FROM [Questions] as Qe
                                where Qe.category_id = {category}
                                and Qe.status = 1
                                and Qe.[difficulty_level] = {level}
                                ORDER BY NEWID()";

                var listQuestions = await _dbConnection.QueryAsync<dynamic>(sql, transaction: Transaction);
                Transaction.Commit();
                return listQuestions.ToList();
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

        public async Task<RoomDoUser?> GetUserDoQuiz(int userId, string roomId)
        {

            _dbConnection.Open();
            try
            {
                string sql = @$"  select top 1
                                      RoomQuiz.current_question, 
                                      RoomQuiz.total_exp, 
                                      UserRoomQuiz.role
                                  from UserRoomQuiz
                                  inner join RoomQuiz on RoomQuiz.room_id = RoomQuiz.room_id
                                  where UserRoomQuiz.user_id = @UserId
                                        and RoomQuiz.room_id = @RoomId";

                var param = new
                {
                    UserId = userId,
                    RoomId = roomId
                };
                var data = await _dbConnection.QueryFirstOrDefaultAsync<RoomDoUser>(sql, param);

                return data;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<List<UserInQuiz>?> GetUsersInRoom(string roomId, int userId)
        {
            _dbConnection.Open();
            try
            {

                string sql = @"select DISTINCT
	                            Users.user_id,
	                            Users.username,
	                            Users.fullname,
	                            Users.images,
                                UserRoomQuiz.role
                            from UserRoomQuiz
                            inner join Users on Users.user_id = UserRoomQuiz.user_id
                            where UserRoomQuiz.room_id =@RoomId AND Users.user_id <> @UserId";
                var param = new
                {
                    RoomId = roomId,
                    UserId = userId
                };
                var data = await _dbConnection.QueryAsync<UserInQuiz>(sql, param);

                return (List<UserInQuiz>?)data;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<int> InsertUserRoomQuiz(int userId, string roomId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                //insert Quizz
                string sql = @"SELECT DISTINCT [room_id],[user_id] ,[role]
                                    FROM [QuizArenaSQL].[dbo].[UserRoomQuiz] WHERE room_id= @RoomId and user_id=@UserId";

                var param = new
                {
                    RoomId = roomId,
                    UserId = userId
                };
                var result = await _dbConnection.QueryFirstOrDefaultAsync(sql, param, Transaction);

                if (result == null) // nếu ở db chưa có thì thêm
                {
                    //insert Quizz
                    sql = @"INSERT INTO [dbo].[UserRoomQuiz]
                                           ([room_id]
                                           ,[user_id]
                                           ,[role])
                                     VALUES
                                           (@RoomId
                                           ,@UserId
                                           ,0)";

                    var paramNew = new
                    {
                        RoomId = roomId,
                        UserId = userId
                    };
                    var newQuizId = await _dbConnection.ExecuteAsync(sql, paramNew, Transaction);
                    Transaction.Commit();
                    return newQuizId;
                }

                Transaction.Commit();
                return 1;
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

        public async Task<int> CheckFriendInBossRoom(int userId, string roomId, int quizId)
        {
            _dbConnection.Open();
            try
            {
                string sql = @"SELECT TOP (1)  [user_id]
				                      FROM [dbo].[UserRoomQuiz] as U
									inner join RoomQuiz as R on u.room_id = r.room_id
				                    where R.room_id = @RoomId and r.quiz_id = @QuizId";

                var param = new
                {
                    RoomId = roomId,
                    QuizId = quizId
                };
                var userIdBoss = await _dbConnection.QueryFirstOrDefaultAsync<int>(sql, param);
                if (userIdBoss != userId) // trường hợp người khác vào phòng
                {
                    sql = @"SELECT count(*)
                                        FROM [dbo].[Friends]
                                        where user_id = (SELECT TOP (1) 
					                                        [user_id]
				                                        FROM [dbo].[UserRoomQuiz] as U
														inner join RoomQuiz as R on u.room_id = r.room_id
				                                        where R.room_id = @RoomId and r.quiz_id = @QuizId
					                                        and role = 1)
	                                         and friend_id = @UserId and Friends.status = 1";

                    var paramNew = new
                    {
                        RoomId = roomId,
                        UserId = userId,
                        QuizId = quizId
                    };
                    var output = await _dbConnection.QueryFirstOrDefaultAsync<int>(sql, paramNew);

                    return output > 0 ? 1 : 0;
                }
                else // trường hợp chủ phòng vào phòng
                {
                    return 2;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<int> DeleteRoomQuizUser(string roomId)
        {
            _dbConnection.Open();
            var Transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql = @"DELETE FROM [dbo].[UserRoomQuiz]
                                  WHERE room_id = @RoomId
	 
	                           DELETE FROM [dbo].[RoomQuiz]
                                  WHERE room_id = @RoomId";

                var param = new
                {
                    RoomId = roomId,
                };
                var output = await _dbConnection.ExecuteAsync(sql, param, Transaction);

                Transaction.Commit();
                return output;
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

        public async Task<IEnumerable<ExamListTopModel>?> GetExamListTop()
        {
            _dbConnection.Open();
            try
            {
                //insert Quizz
                string sql = @"SELECT TOP (10) 
	                                [Exam].[exam_id]
                                    ,[Exam].[exam_name]
                                    ,[Exam].[description]
                                    ,[Exam].[exam_type]
                                    ,[Exam].[image]
                                    ,[Exam].[date]
                                    ,[Exam].[status]
	                                ,Quizzes.time_limit
	                                ,(select COUNT(0) from QuestionsAttempts where quiz_id = Quizzes.quiz_id) as CountQuestion
	                                ,(select count(0) from ExamUser where exam_id = [Exam].[exam_id]) as NumberUserJoin
                            FROM [dbo].[Exam]
                            inner join Quizzes on  [Exam].quiz_id = Quizzes.quiz_id
                            where [Exam].status <> 0
                                  and Quizzes.status != -1
                            order by date desc";

                var output = await _dbConnection.QueryAsync<ExamListTopModel>(sql);

                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<ExamInfoUserModel?> GetExamInfoUser(int userId)
        {
            _dbConnection.Open();
            try
            {
                //insert Quizz
                string sql = @"SELECT TOP (1) 
                                       [Exam].[exam_name]
                                      ,ExamUser.score
                                      ,[Exam].[date]
                                      ,[Exam].[image]
	                                  ,(select top 1 RowNum from(select ROW_NUMBER() OVER(ORDER BY score desc, time_submit) AS RowNum, * from ExamUser where exam_id = [Exam].exam_id) as T where user_id = ExamUser.user_id) as topUser
                                FROM [dbo].[Exam]
                                inner join ExamUser on  ExamUser.exam_id = [Exam].exam_id
                                where ExamUser.user_id = @UserId
	                                  and [Exam].exam_type = 1
                                      and [Exam].status = 5
                                    order by [Exam].[date] desc";
                var param = new
                {
                    UserId = userId,
                };
                var output = await _dbConnection.QueryFirstOrDefaultAsync<ExamInfoUserModel?>(sql, param);

                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<ExamToWeekModel?> GetExamToWeek()
        {
            _dbConnection.Open();
            try
            {
                //insert Quizz
                string sql = @"SELECT
                                [exam_id]
                                ,[exam_name]
                                ,[description]
                                ,[status]
                                ,[date]
                                FROM [dbo].[Exam]
                                Where status != 0
                                order by date asc";

                var data = await _dbConnection.QueryAsync<ExamToWeekModel?>(sql);
                var timeNow = DateTime.Now;
                timeNow.AddHours(-timeNow.Hour);
                timeNow.AddMinutes(-timeNow.Minute);
                timeNow.AddMilliseconds(-timeNow.Millisecond);
                var output = data.FirstOrDefault(x => x.date.Value.AddHours(-x.date.Value.Hour)
                                                                  .AddMinutes(-x.date.Value.Minute)
                                                                  .AddMilliseconds(-x.date.Value.Millisecond) >= timeNow.Date);
                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<IEnumerable<ExamTop3UserModel>?> GetExamTop3User()
        {
            _dbConnection.Open();
            try
            {
                //insert Quizz
                string sql = @"SELECT TOP (3)
                                   Users.[user_id]
                                  ,Users.fullname
                                  ,Users.images
	                              ,[ExamUser].score
                              FROM [dbo].[ExamUser]
                              inner join Users on [ExamUser].user_id = Users.user_id
                              WHERE [ExamUser].exam_id = (SELECT TOP (1) [exam_id]
								                            FROM [dbo].[Exam]
								                            Where status = 5 and exam_type = 1
								                            order by date desc)
                              Order by [ExamUser].score desc, [ExamUser].time_submit asc";

                var output = await _dbConnection.QueryAsync<ExamTop3UserModel?>(sql);

                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<bool> CheckUserInExamUser(string? examId, int userId)
        {
            if (examId != null)
            {
                _dbConnection.Open();
                try
                {
                    //insert Quizz
                    string sql = @"SELECT TOP (1) *
                              FROM [dbo].[ExamUser]
                              WHERE [ExamUser].exam_id = @ExamId and user_id = @UserId and status = 1 ";
                    var parameters = new { ExamId = examId, UserId = userId };

                    var output = await _dbConnection.QueryFirstOrDefaultAsync<dynamic>(sql, parameters);
                    if (output != null)
                    {
                        return true;
                    }
                    return false;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            else
            {
                return false;
            }

        }

        public async Task<int> UpdateQuizPrivate(UpdateQuizModel request, int userId)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();
            try
            {
                var output = 0;
                var fillerQuiz = request.questions.Where(x => x.QuestionId == 0).ToList();
                request.questions = request.questions.Where(x => x.QuestionId != 0).ToList();
                string sqlQuizzes = @$"UPDATE [dbo].[Quizzes]
                               SET [title] = @Title
                                  ,[category_id] = @CategoryId
                                  ,[description] = @Description
                                  ,[quiz_type] = @QuizType                                                               
                                  ,[difficulty_level] = @DifficultyLevel
                                  ,[creator_id] = {userId}
                                  ,[updated_at] = Getdate()
                               ";
                if (request.quizz.Image != null)
                {
                    sqlQuizzes += $" ,[image] = @Image";
                }
                if (request.quizz.Status != null)
                {
                    sqlQuizzes += $" ,[status] = @Status";
                }
                sqlQuizzes += $" WHERE quiz_id = @QuizId";
                output += await _dbConnection.ExecuteAsync(sqlQuizzes, request.quizz, transaction: transaction);
                foreach (var item in request.questions)
                {
                    var sqlQuestions = @$"UPDATE [dbo].[Questions]
                               SET [question_text] = @QuestionText
                                  ,[difficulty_level] = @DifficultyLevel
                                  ,[correct_answer] = @CorrectAnswer
                                  ,[options] = @Options
                             WHERE question_id = @QuestionId";
                    output += await _dbConnection.ExecuteAsync(sqlQuestions, item, transaction: transaction);
                }

                var checkList = request.questions.Select(x => x.QuestionId).ToList();
                if (checkList.Count > 0)
                {
                    var listQuizId = string.Join(",", checkList);
                    var sql = @$"DELETE FROM [dbo].[QuestionsAttempts]
                          WHERE question_id in (select question_id from  Questions where question_id not in ({listQuizId}))
	                            and quiz_id = {request.quizz.QuizId}

                          DELETE FROM [dbo].[Questions]
                          WHERE question_id in (select question_id from  [QuestionsAttempts] where question_id in (select question_id from  Questions where question_id not in ({listQuizId}))
																								and quiz_id = {request.quizz.QuizId})";
                    output += await _dbConnection.ExecuteAsync(sql, transaction: transaction);
                }


                if (fillerQuiz != null && fillerQuiz.Count > 0)
                {
                    //insert Questions
                    var listQuestionsIdNew = new List<int>();
                    foreach (var item in fillerQuiz)
                    {
                        StringBuilder InsertQuestions = new StringBuilder();
                        InsertQuestions.AppendLine("INSERT INTO [dbo].[Questions] ([question_text], [difficulty_level], [correct_answer], [options])");
                        InsertQuestions.AppendLine($"OUTPUT INSERTED.[question_id] VALUES");
                        InsertQuestions.AppendLine($"(@QuestionText, @DifficultyLevel, @CorrectAnswer, @Options)");
                        listQuestionsIdNew.Add(await _dbConnection.QueryFirstAsync<int>(InsertQuestions.ToString(), item, transaction: transaction));
                    }

                    var DataNewId = listQuestionsIdNew.Select(x => new QuestionsAttempt
                    {
                        QuizId = request.quizz.QuizId,
                        QuestionId = x,
                    }).ToList();

                    //insert QuestionsAttempts
                    StringBuilder InsertQuestionsAttempts = new StringBuilder();
                    InsertQuestionsAttempts.AppendLine("INSERT INTO [dbo].[QuestionsAttempts] ([quiz_id], [question_id])");
                    InsertQuestionsAttempts.AppendLine($"VALUES");
                    int checkQuestionsAttempts = 0;
                    foreach (var item in DataNewId)
                    {
                        if (checkQuestionsAttempts > 0)
                        {
                            InsertQuestionsAttempts.AppendLine(",");
                        }
                        InsertQuestionsAttempts.AppendLine($"({item.QuizId}, {item.QuestionId})");
                        checkQuestionsAttempts++;
                    }

                    output += await _dbConnection.ExecuteAsync(InsertQuestionsAttempts.ToString(), transaction: transaction);

                }

                transaction.Commit();
                return output;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<int> UpdateQuiz(UpdateQuizModel request, int userId)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();
            try
            {
                var fillerQuiz = request.questions.Where(x => x.QuestionId == 0).ToList();
                request.questions = request.questions.Where(x => x.QuestionId != 0).ToList();
                string sql = @$"UPDATE [dbo].[Quizzes]
                               SET [title] = '{request.quizz.Title}'
                                  ,[category_id] = {request.quizz.CategoryId}
                                  ,[description] = '{request.quizz.Description}'
                                  ,[quiz_type] = {request.quizz.QuizType}                                                                 
                                  ,[difficulty_level] = {request.quizz.DifficultyLevel}
                                  ,[creator_id] = {userId}
                                  ,[updated_at] = Getdate()
                               ";
                if (request.quizz.Image != null)
                {
                    sql += $" ,[image] = '{request.quizz.Image}'";
                }
                if (request.quizz.Status != null)
                {
                    sql += $" ,[status] = '{request.quizz.Status}'";
                }
                sql += $" WHERE quiz_id = {request.quizz.QuizId}";
                sql += "\n";

                //xử lý xóa question ở bảng QuestionsAttempts
                var checkList = request.questions.Select(x => x.QuestionId).ToList();
                var listQuizId = string.Join(",", checkList);

                if (checkList.Count > 0)
                {
                    sql += @$"DELETE FROM [dbo].[QuestionsAttempts]
                          WHERE question_id in (select question_id from  Questions where question_id not in ({listQuizId}))
	                            and quiz_id = {request.quizz.QuizId} ";
                }
                await _dbConnection.ExecuteAsync(sql, transaction: transaction);


                //xử lý thêm question ở bảng QuestionsAttempts
                string sql1 = @$" select question_id  FROM [dbo].[Questions]
                                WHERE question_id not in 
                                (select question_id from [QuestionsAttempts] where quiz_id = {request.quizz.QuizId})
                                and question_id in ({listQuizId})";
                var quesIdNew = await _dbConnection.QueryAsync<int>(sql1, transaction: transaction);

                if (quesIdNew != null && quesIdNew.Count() > 0)
                {
                    //insert QuestionsAttempts
                    StringBuilder InsertQuestionsAttempts = new StringBuilder();
                    InsertQuestionsAttempts.AppendLine("INSERT INTO [dbo].[QuestionsAttempts] ([quiz_id], [question_id])");
                    InsertQuestionsAttempts.AppendLine($"VALUES");
                    int checkQuestionsAttempts = 0;
                    foreach (var item in quesIdNew)
                    {
                        if (checkQuestionsAttempts > 0)
                        {
                            InsertQuestionsAttempts.AppendLine(",");
                        }
                        InsertQuestionsAttempts.AppendLine($"({request.quizz.QuizId}, {item})");
                        checkQuestionsAttempts++;
                    }
                    await _dbConnection.ExecuteAsync(InsertQuestionsAttempts.ToString(), transaction: transaction);
                }

                transaction.Commit();
                return 1;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<object?> GetQuizForMod()
        {

            string query1 = @"SELECT *
                                  FROM [dbo].[Quizzes]
                                  where (status = 1 or status = 3) and quiz_type<>3";
            string query0 = @"SELECT *
                                  FROM [dbo].[Quizzes]
                                  where status = 2 and quiz_type<>3";
            _dbConnection.Open();
            try
            {

                var dataQuizApprove = await _dbConnection.QueryAsync<Entity.SQL.Quiz>(query1);
                var dataQuizNotApprove = await _dbConnection.QueryAsync<Entity.SQL.Quiz>(query0);
                var output = new
                {
                    DataQuizApprove = dataQuizApprove,
                    DataQuizNotApprove = dataQuizNotApprove
                };
                return output;
            }
            catch (Exception ex)
            {

                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }


        }

        public async Task<List<ActiveQuiz>> GetActiveQuizzes()
        {
            string query = @"SELECT
                            [quiz_id],
                            [title],
                            [category_id],
                            [description],
                            [quiz_type],
                            [status],
                            [image],
                            [difficulty_level],
                            [time_limit],
                            [creator_id],
                            [create_date],
                            [updated_at]
                        FROM [QuizArenaSQL].[dbo].[Quizzes]
                        WHERE [quiz_type] = 1 AND [status] = 1";

            _dbConnection.Open();
            try
            {
                var result = await _dbConnection.QueryAsync<ActiveQuiz>(query);
                return result.ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<ActiveQuiz> GetActiveQuizById(int quizId)
        {
            // Viết truy vấn SQL để lấy thông tin của bài kiểm tra với quizId tương ứng
            string query = "SELECT * FROM [dbo].[Quizzes] WHERE [quiz_id] = @QuizId and status != -1";
            var parameters = new { QuizId = quizId };

            // Sử dụng Dapper hoặc một thư viện ORM khác để thực hiện truy vấn
            var quizInfo = await _dbConnection.QueryFirstOrDefaultAsync<ActiveQuiz>(query, parameters);

            return quizInfo;
        }

        public async Task<bool> UpdateQuizStatus(UpdateStatusQuiz request)
        {
            try
            {
                string updateQuery = @"UPDATE [dbo].[Quizzes]
                                    SET [status] = @Status ";
                if (request.status == 4 && !string.IsNullOrEmpty(request.comment))
                {
                    updateQuery += ",[comment] = @Comment ";
                }
                updateQuery += "WHERE[quiz_id] = @QuizId";

                var parameters = new { QuizId = request.quizId, Status = request.status, Comment = request.comment };

                await _dbConnection.ExecuteAsync(updateQuery, parameters);

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<int> DeleteQuiz(int quizId, int quiz_type)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();
            try
            {
                string sql;
                if (quiz_type == 3)
                {
                    sql = @"UPDATE [dbo].[Quizzes]
                                    SET [status] = -1 WHERE[quiz_id] = @QuizId";

                }
                else
                {
                    sql = @"DECLARE @Table TABLE (question_id int NOT NULL);
                            INSERT INTO @Table(question_id)
                            SELECT [question_id]
                              FROM [dbo].[QuestionsAttempts]
                              where quiz_id = (select top (1) quiz_id from Quizzes where quiz_id = @QuizId and (status = 0 or status = 4))

                            DELETE FROM [dbo].[QuestionsAttempts]
                                  WHERE quiz_id = (select top (1) quiz_id from Quizzes where quiz_id = @QuizId and (status = 0 or status = 4))
                            DELETE FROM [dbo].[Quizzes]
                                  WHERE quiz_id = (select top (1) quiz_id from Quizzes where quiz_id = @QuizId and (status = 0 or status = 4))";

                }

                var param = new
                {
                    QuizId = quizId
                };
                var result = await _dbConnection.ExecuteAsync(sql, param, transaction);

                transaction.Commit();
                return result;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<int> InsertExamUser(InsertExamUserModel req, int userId)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();
            try
            {
                var sql1 = @"SELECT [user_id] FROM [dbo].[ExamUser] WHERE [exam_id] = @ExamId and [user_id]=@UserId";
                var param1 = new
                {
                    ExamId = req.examId,
                    UserId = userId
                };

                var result = await _dbConnection.QueryFirstOrDefaultAsync(sql1, param1, transaction);
                if (result == null)
                {
                    var sql = @"INSERT INTO[dbo].[ExamUser]
                               ([exam_id]
                               ,[user_id]
                               ,[score]
                               ,[status]
                               ,[time_submit])
                            VALUES
                                (@ExamId
                                ,@UserId
                                ,@Score
                                ,@Status
                                ,GETDATE())";
                    var param = new
                    {
                        ExamId = req.examId,
                        UserId = userId,
                        Score = 0,
                        Status = 0
                    };

                    var output = await _dbConnection.ExecuteAsync(sql, param, transaction);
                    transaction.Commit();
                    return output;
                }

                transaction.Commit();
                return 1;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<List<QuizA>> GetQuizzesByStatus(List<int> status, int page = 1, int pageSize = 10, string? searchTerm = null)
        {
            try
            {
                string baseQuery = @"
            SELECT
                q.[quiz_id],
                q.[title],
                q.[category_id],
                q.[description],
                q.[quiz_type],
                q.[status],
                q.[image],
                q.[difficulty_level],
                q.[time_limit],
                q.[creator_id],
                q.[create_date],
                q.[updated_at],
                u.[user_id] AS [creator_id],
                u.[username] AS [creator_username],
                u.[fullname] AS [creator_full_name]
            FROM [dbo].[Quizzes] q
            JOIN [dbo].[Users] u ON q.[creator_id] = u.[user_id]";

                string whereClause = $" WHERE q.[status] IN ({string.Join(",", status)}) and quiz_type<>3";
                if (!string.IsNullOrWhiteSpace(searchTerm))
                {
                    whereClause += $" AND q.[title] LIKE '%{searchTerm}%'";
                }

                string pagingClause = $" ORDER BY q.[create_date] DESC OFFSET {(page - 1) * pageSize} ROWS FETCH NEXT {pageSize} ROWS ONLY";

                string query = baseQuery + whereClause + pagingClause;

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizA>(query);
                    return result.ToList();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizCategory>> GetQuizzesByCategoryAndStatus(int categoryId)
        {
            try
            {
                string query = @"
            SELECT
                q.[quiz_id],
                q.[title],
                q.[category_id],
                q.[description],
                q.[quiz_type],
                q.[status],
                q.[image],
                q.[difficulty_level],
                q.[time_limit],
                q.[creator_id],
                q.[create_date],
                q.[updated_at]
            FROM [dbo].[Quizzes] q
            JOIN [dbo].[Category] c ON q.[category_id] = c.[category_id]
            WHERE c.[category_id] = @CategoryId AND q.[status] = 1 and quiz_type<>3";

                var parameters = new { CategoryId = categoryId };

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizCategory>(query, parameters);
                    return result.ToList();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public async Task<List<QuizStaff>> GetQuizzesStaff0(int userId)
        {
            try
            {
                string query = @"
                        SELECT
                            q.[quiz_id],
                            q.[title],
                            q.[category_id],
                            q.[description],
                            q.[quiz_type],
                            q.[status],
                            q.[image],
                            q.[difficulty_level],
                            q.[time_limit],
                            q.[creator_id],
                            q.[create_date],
                            q.[updated_at]
                        FROM [dbo].[Quizzes] q
                        JOIN [dbo].[Users] u ON q.[creator_id] = u.[user_id]
                        WHERE u.[user_id] = @UserId AND q.[status] = 0 and quiz_type<>3";

                var parameters = new { UserId = userId };

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizStaff>(query, parameters);
                    return result.ToList();
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizStaff>> GetQuizzesStaff4(int userId)
        {
            try
            {
                string query = @"
                        SELECT
                            q.[quiz_id],
                            q.[title],
                            q.[category_id],
                            q.[description],
                            q.[quiz_type],
                            q.[status],
                            q.[image],
                            q.[difficulty_level],
                            q.[time_limit],
                            q.[creator_id],
                            q.[create_date],
                            q.[updated_at]
                        FROM [dbo].[Quizzes] q
                        JOIN [dbo].[Users] u ON q.[creator_id] = u.[user_id]
                        WHERE u.[user_id] = @UserId AND q.[status] = 4 and quiz_type<>3";

                var parameters = new { UserId = userId };

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizStaff>(query, parameters);
                    return result.ToList();
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizStaff>> GetQuizzesStaff1(int userId)
        {
            try
            {
                string query = @"
                        SELECT
                            q.[quiz_id],
                            q.[title],
                            q.[category_id],
                            q.[description],
                            q.[quiz_type],
                            q.[status],
                            q.[image],
                            q.[difficulty_level],
                            q.[time_limit],
                            q.[creator_id],
                            q.[create_date],
                            q.[updated_at]
                        FROM [dbo].[Quizzes] q
                        JOIN [dbo].[Users] u ON q.[creator_id] = u.[user_id]
                        WHERE u.[user_id] = @UserId AND q.[status] = 1 and quiz_type<>3";

                var parameters = new { UserId = userId };

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizStaff>(query, parameters);
                    return result.ToList();
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<List<QuizStaff>> GetQuizzesStaff2(int userId)
        {
            try
            {
                string query = @"
                        SELECT
                            q.[quiz_id],
                            q.[title],
                            q.[category_id],
                            q.[description],
                            q.[quiz_type],
                            q.[status],
                            q.[image],
                            q.[difficulty_level],
                            q.[time_limit],
                            q.[creator_id],
                            q.[create_date],
                            q.[updated_at]
                        FROM [QuizArenaSQL].[dbo].[Quizzes] q
                        JOIN [QuizArenaSQL].[dbo].[Users] u ON q.[creator_id] = u.[user_id]
                        WHERE u.[user_id] = @UserId AND q.[status] = 2 and quiz_type<>3";

                var parameters = new { UserId = userId };

                _dbConnection.Open();
                try
                {
                    var result = await _dbConnection.QueryAsync<QuizStaff>(query, parameters);
                    return result.ToList();
                }
                finally
                {
                    _dbConnection.Close();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<object> GetInforLobby(string examId, int userId)
        {
            string queryListUserExam = @"SELECT Users.user_id as userId
                                                  ,Users.username
                                                  ,Users.fullname
                                                  ,Users.images
                                              FROM ExamUser
                                              inner join Users on ExamUser.user_id = Users.user_id
                                              where ExamUser.exam_id = @ExamId";
            string queryInforExam = @"SELECT [exam_name] as examName
                                              ,(select count(*) from QuestionsAttempts where quiz_id = [Exam].quiz_id) as numberQuesion
                                              ,(select time_limit from Quizzes where quiz_id = [Exam].quiz_id) as timeLimit
                                              ,[exam_type] as examType
                                              ,[image]
                                              ,[quiz_id] as quizId
                                              ,[date]
                                          FROM [dbo].[Exam]
                                          where exam_id = @ExamId";
            string queryCount = @"SELECT count(*)
                                        FROM ExamUser
                                        where exam_id = @ExamId
                                        and user_id = @UserId";

            var param = new
            {
                ExamId = examId,
                UserId = userId
            };
            _dbConnection.Open();
            try
            {
                var result = new
                {
                    ListUserExam = await _dbConnection.QueryAsync<dynamic>(queryListUserExam, param),
                    InforExam = await _dbConnection.QueryAsync<dynamic>(queryInforExam, param),
                    PermissionJoin = await _dbConnection.QueryFirstOrDefaultAsync<int>(queryCount, param) == 0 ? false : true
                };
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<bool> UpdateUserExam(string examId, int userId, int? score)
        {
            string query = "";
            if (score == null)
            {
                query = @"UPDATE [dbo].[ExamUser]
                            SET [status] = 1
                            WHERE exam_id = @ExamId and user_id = @UserId";
            }
            else
            {
                query = @"UPDATE [dbo].[ExamUser]
                            SET score = @Score
                            ,time_submit = GETDATE()
                            WHERE exam_id = @ExamId and user_id = @UserId";
            }

            var param = new
            {
                ExamId = examId,
                UserId = userId,
                Score = score
            };
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();
            try
            {
                var result = await _dbConnection.ExecuteAsync(query, param, transaction);
                transaction.Commit();
                return result == 0 ? false : true;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }

        }

        public async Task<List<ExamModel>> GetExamList()
        {
            string query = @"SELECT
                            [exam_id],
                            [exam_name],
                            [quiz_id],
                            [description],
                            [image],
                            [exam_type],
                            [status],
                            [date]
                        FROM [dbo].[Exam]";

            _dbConnection.Open();

            try
            {
                var examList = await _dbConnection.QueryAsync<ExamModel>(query);
                return examList.ToList();
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<string> CreateExam(string examName, int quizId, string description, string image, int examType, DateTime date)
        {
            try
            {
                // Tạo mã đề thi từ thời gian để đảm bảo tính duy nhất
                string examId = GenerateUniqueExamId();

                string insertQuery = @"
            INSERT INTO [dbo].[Exam] ([exam_id], [exam_name], [quiz_id], [description], [image], [status], [date], [exam_type])
            VALUES (@ExamId, @ExamName, @QuizId, @Description, @Image, 0, @Date, @ExamType)";

                var parameters = new { ExamId = examId, ExamName = examName, QuizId = quizId, Description = description, Image = image, ExamType = examType, Date = date };

                // Thực hiện truy vấn để thêm đề thi mới
                await _dbConnection.ExecuteAsync(insertQuery, parameters);

                return examId;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }


        public async Task<bool> EditExam(string examId, string examName, int quizId, string description, int examType, DateTime date, string? image = null)
        {
            try
            {
                string updateQuery = @"
                    UPDATE [dbo].[Exam]
                    SET [exam_name] = @ExamName,
                        [quiz_id] = @QuizId,
                        [description] = @Description,
                        [date] = @Date,
                        [exam_type] = @ExamType";
                if (image != null && !string.IsNullOrEmpty(image))
                {
                    updateQuery += ",[image] = @Image";
                }
                updateQuery += " WHERE [exam_id] = @ExamId AND [status] = 0";

                var parameters = new { ExamId = examId, ExamName = examName, QuizId = quizId, Description = description, Image = image, ExamType = examType, Date = date };

                await _dbConnection.ExecuteAsync(updateQuery, parameters);

                return true;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<ExamModel?> GetExamById(string examId)
        {
            string query = @"SELECT * FROM [dbo].[Exam] WHERE [exam_id] = @ExamId";
            var parameters = new { ExamId = examId };

            _dbConnection.Open();

            try
            {
                var exam = await _dbConnection.QueryFirstOrDefaultAsync<ExamModel>(query, parameters);
                return exam;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<QuizModel> GetQuizById(int quizId)
        {
            string query = @"SELECT * FROM [dbo].[Quizzes] WHERE [quiz_id] = @QuizId";
            var parameters = new { QuizId = quizId };

            _dbConnection.Open();

            try
            {
                var quiz = await _dbConnection.QueryFirstOrDefaultAsync<QuizModel>(query, parameters);
                return quiz;
            }
            finally
            {
                _dbConnection.Close();
            }
        }
        public async Task DeleteExam(string examId)
        {
            string deleteQuery = @"DELETE FROM [dbo].[Exam] WHERE [exam_id] = @ExamId";
            var parameters = new { ExamId = examId };

            _dbConnection.Open();

            try
            {
                await _dbConnection.ExecuteAsync(deleteQuery, parameters);
            }
            finally
            {
                _dbConnection.Close();
            }
        }
        public async Task ChangeExamStatus(string examId, int newStatus)
        {
            string updateQuery = @"UPDATE [dbo].[Exam] SET [status] = @NewStatus WHERE [exam_id] = @ExamId";
            var parameters = new { ExamId = examId, NewStatus = newStatus };

            _dbConnection.Open();

            try
            {
                await _dbConnection.ExecuteAsync(updateQuery, parameters);
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<IEnumerable<QuizzesSRC002>> GetQuizzesByTypeAndStatus(int quizType, int status)
        {
            try
            {
                // Thực hiện truy vấn SQL để lấy danh sách câu hỏi từ database
                string query = @"
                SELECT [quiz_id]
                    ,[title]
                    ,[category_id]
                    ,[description]
                    ,[quiz_type]
                    ,[status]
                    ,[image]
                    ,[difficulty_level]
                    ,[time_limit]
                    ,[creator_id]
                    ,[create_date]
                    ,[updated_at]
                FROM [QuizArenaSQL].[dbo].[Quizzes]
                WHERE [quiz_type] = @QuizType AND [status] = @Status";

                var parameters = new { QuizType = quizType, Status = status };

                return await _dbConnection.QueryAsync<QuizzesSRC002>(query, parameters);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<ExamModel> GetListExamById(string examId)
        {
            try
            {
                // Thực hiện truy vấn SQL để lấy thông tin đề thi từ database
                string query = @"
                SELECT [exam_id]
                    ,[exam_name]
                    ,[quiz_id]
                    ,[description]
                    ,[exam_type]
                    ,[image]
                    ,[status]
                    ,[date]
                FROM [QuizArenaSQL].[dbo].[Exam]
                WHERE [exam_id] = @ExamId";

                var parameters = new { ExamId = examId };

                return await _dbConnection.QueryFirstOrDefaultAsync<ExamModel>(query, parameters);
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }

        public async Task<GetInforChallengeModel> GetInforChallenge(string examId, int? userId)
        {
            try
            {
                // Thực hiện truy vấn SQL để lấy thông tin đề thi từ database
                string query1 = @"SELECT TOP (1) 
                                [Exam].[exam_name]
                                ,[Exam].[exam_type]
                                ,[Exam].[image]
                                ,[Exam].[date]
                                ,[Exam].[status]
                                ,Quizzes.time_limit
                                ,(select COUNT(0) from QuestionsAttempts where quiz_id = Quizzes.quiz_id) as NumberQuestion
                                ,(select count(0) from ExamUser where exam_id = [Exam].[exam_id]) as NumberUser
                                FROM [dbo].[Exam]
                                inner join Quizzes on  [Exam].quiz_id = Quizzes.quiz_id
                                where [Exam].exam_id = @ExamId
                                order by date desc";
                string query2 = @"SELECT 
                                Users.user_id
                                ,Users.username
                                ,Users.fullname
                                ,Users.images
                                ,ExamUser.score
                                ,ExamUser.time_submit
                                ,RANK() OVER (ORDER BY ExamUser.score DESC, ExamUser.time_submit ASC) AS positionRank
                                FROM [dbo].Users
                                inner join ExamUser on  ExamUser.user_id = Users.user_id
                                where ExamUser.exam_id = @ExamId
                                order by ExamUser.score desc, ExamUser.time_submit ASC";
                string query3 = @"SELECT TOP (1) 
                                ExamUser.score
                                ,ExamUser.time_submit
                                ,(select top 1 RowNum from(select ROW_NUMBER() OVER(ORDER BY score desc, time_submit) AS RowNum, * from ExamUser where exam_id = [Exam].exam_id) as T where user_id = ExamUser.user_id) as positionRank
                                FROM [dbo].[Exam]
                                inner join ExamUser on  ExamUser.exam_id = [Exam].exam_id
                                where ExamUser.user_id = @UserId
                                and [Exam].exam_id = @ExamId 
                                order by [Exam].[date] desc";

                var param = new { ExamId = examId, UserId = userId };
                var MyRanking = userId == null ? null : await _dbConnection.QueryFirstOrDefaultAsync<MyRanking>(query3, param);
                var data = new GetInforChallengeModel
                {
                    examInfo = await _dbConnection.QueryFirstOrDefaultAsync<ExamInfo>(query1, param),
                    ranking = (List<Ranking>)await _dbConnection.QueryAsync<Ranking>(query2, param),
                    myRanking = MyRanking,
                };

                return data;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi theo nhu cầu của bạn
                throw ex;
            }
        }


        public async Task UpdateFinishChallenge(string examId, int userId)
        {
            string Query = @"UPDATE [dbo].[ExamUser]
                                   SET [status] = 2
                                 WHERE [exam_id] = @ExamId
	                                   and [user_id] = @UserId";
            var parameters = new { ExamId = examId, UserId = userId };

            _dbConnection.Open();

            try
            {
                await _dbConnection.ExecuteAsync(Query, parameters);
            }
            finally
            {
                _dbConnection.Close();
            }
        }
        public async Task<bool> AddQuestions(int userId, QuestionModel request)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();

            try
            {
                // Duyệt qua danh sách câu hỏi và thêm chúng vào bảng
                foreach (var question in request.listquestions)
                {
                    string insertQuestionQuery = @"
                INSERT INTO [dbo].[Questions] ([question_text], [difficulty_level], [correct_answer], [options], [status], [category_id], [user_id])
                VALUES (@QuestionText, @DifficultyLevel, @CorrectAnswer, @Options, @Status, @CategoryId, @UserId);
            ";

                    var parameters = new
                    {
                        QuestionText = question.QuestionText,
                        DifficultyLevel = question.DifficultyLevel,
                        CorrectAnswer = question.CorrectAnswer,
                        Options = question.Options,
                        Status = question.Status,
                        CategoryId = request.CategoryId,
                        UserId = userId
                    };

                    await _dbConnection.ExecuteAsync(insertQuestionQuery, parameters, transaction);
                }

                // Commit transaction nếu không có lỗi
                transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                // Rollback transaction nếu có lỗi
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<bool> EditQuestions(int userId, QuestionModel request)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();

            try
            {
                // Duyệt qua danh sách câu hỏi và cập nhật chúng trong bảng
                foreach (var question in request.listquestions)
                {
                    string updateQuestionQuery = @"
                    UPDATE [dbo].[Questions]
                    SET [question_text] = @QuestionText,
                        [difficulty_level] = @DifficultyLevel,
                        [correct_answer] = @CorrectAnswer,
                        [options] = @Options,
                        [status] = @Status
                    WHERE [question_id] = @QuestionId;
                ";

                    var parameters = new
                    {
                        QuestionText = question.QuestionText,
                        DifficultyLevel = question.DifficultyLevel,
                        CorrectAnswer = question.CorrectAnswer,
                        Options = question.Options,
                        Status = question.Status,
                        QuestionId = question.QuestionId
                    };

                    await _dbConnection.ExecuteAsync(updateQuestionQuery, parameters, transaction);
                }

                // Commit transaction nếu không có lỗi
                transaction.Commit();
                return true;
            }
            catch (Exception ex)
            {
                // Rollback transaction nếu có lỗi
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task ChangeQuestionStatus(int questionId, int newStatus)
        {
            _dbConnection.Open();
            var transaction = _dbConnection.BeginTransaction();

            try
            {
                // Kiểm tra xem người dùng có quyền thay đổi trạng thái của câu hỏi hay không
                // Thực hiện các kiểm tra bảo mật cần thiết tại đây

                // Cập nhật trạng thái của câu hỏi
                string updateQuestionStatusQuery = @"
                    UPDATE [dbo].[Questions]
                    SET [status] = @NewStatus
                    WHERE [question_id] = @QuestionId;
        ";

                var parameters = new
                {
                    NewStatus = newStatus,
                    QuestionId = questionId
                };

                await _dbConnection.ExecuteAsync(updateQuestionStatusQuery, parameters, transaction);

                // Commit transaction nếu không có lỗi
                transaction.Commit();
            }
            catch (Exception ex)
            {
                // Rollback transaction nếu có lỗi
                transaction.Rollback();
                throw ex;
            }
            finally
            {
                _dbConnection.Close();
            }
        }

        public async Task<IEnumerable<dynamic>> GetQuestionsByCategory(int categoryId, int status, int? userId)
        {
            try
            {
                string query;
                // Thực hiện truy vấn SQL để lấy danh sách câu hỏi từ database theo danh mục
                if (userId.HasValue)
                {
                    query = @"
                                SELECT [question_id] as questionId
                                    ,[question_text] as questionText
                                    ,[difficulty_level] as difficultyLevel
                                    ,[correct_answer] as correctAnswer
                                    ,[options] as options
                                    ,[Questions].[status] as status
                                    ,[Questions].[user_id] as userId
                                    ,[Users].[username] as username
                                FROM [dbo].[Questions]
                                inner join Users on  Users.user_id = [Questions].user_id
                                WHERE [category_id] = @CategoryId AND [Questions].[status] = @Status AND [Questions].user_id = @UserId
                            ";
                }
                else
                {
                    query = @"
                                SELECT [question_id] as questionId
                                    ,[question_text] as questionText
                                    ,[difficulty_level] as difficultyLevel
                                    ,[correct_answer] as correctAnswer
                                    ,[options] as options
                                    ,[Questions].[status] as status
                                    ,[Questions].[user_id] as userId
                                    ,[Users].[username] as username
                                FROM [dbo].[Questions]
                                inner join Users on  Users.user_id = [Questions].user_id
                                WHERE [category_id] = @CategoryId AND [Questions].[status] = @Status
                            ";
                }
                var parameters = new { CategoryId = categoryId, Status = status, UserId = userId };

                var questions = await _dbConnection.QueryAsync<dynamic>(query, parameters);

                return questions;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<QuestionModel.ListQuestion>> GetQuestionsByCategoryAndSearchPage(int categoryId, int status, string? searchTerm, int page, int pageSize)
        {
            try
            {
                // Thực hiện truy vấn SQL để lấy danh sách câu hỏi từ database theo danh mục
                string query = @"SELECT [question_id]
                                ,[question_text]
                                ,[difficulty_level]
                                ,[correct_answer]
                                ,[options]
                                ,[status]
                                ,[user_id]
                            FROM [dbo].[Questions]
                            WHERE [category_id] = @CategoryId AND [status] = @Status
                            and ([question_text] LIKE @SearchTerm )
                                OR @SearchTerm IS NULL
                            ORDER BY [question_id] 
                            OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";
                var offset = (page - 1) * pageSize;
                var parameters = new { CategoryId = categoryId, Status = status, SearchTerm = $"%{searchTerm}%", Offset = offset, PageSize = pageSize };
                var questions = await _dbConnection.QueryAsync<QuestionModel.ListQuestion>(query, parameters);

                return questions;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public string GenerateUniqueExamId()
        {
            string prefix = GenerateRandomChars(5); // Tạo tiền tố ngẫu nhiên 5 ký tự
            string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss"); // Lấy thời gian hiện tại
            string shortTimestamp = GetShortTimestamp(timestamp, 5); // Chuyển đổi timestamp thành mã ngắn 5 ký tự

            // Kết hợp tiền tố và mã ngắn để tạo uniqueId
            string uniqueId = $"{prefix}{shortTimestamp}";

            return uniqueId;
        }

        private string GetShortTimestamp(string timestamp, int length)
        {
            using (var sha1 = System.Security.Cryptography.SHA1.Create())
            {
                byte[] hashBytes = sha1.ComputeHash(Encoding.UTF8.GetBytes(timestamp));

                // Chuyển đổi các byte thành chuỗi hex và chỉ lấy số ký tự mong muốn
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < length; i++)
                {
                    sb.Append(hashBytes[i].ToString("X2"));
                }

                return sb.ToString();
            }
        }

        private string GenerateRandomChars(int length)
        {
            Random random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZzxcvbnmasdfghjklqwertyuiop";
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }


    }
}
