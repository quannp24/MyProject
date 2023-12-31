using QuizArenaBE.Entity.SQL;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Entity.SRC003;
using QuizArenaBE.Services.Common;
using System.Data.SqlClient;
using DeleQuestion = QuizArenaBE.Entity.SRC003.DeleQuestion;

namespace QuizArenaBE.Repository.SRC003
{
    public class DashboardRepository : IDashboardRepository
    {
        private readonly ICRUDcommon _crudCommon;

        public DashboardRepository(ICRUDcommon crudCommon)
        {
            _crudCommon = crudCommon;
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }
        // User
        public async Task<IEnumerable<UserManager>> GetUsersWithInfo(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            // Xây dựng câu lệnh SQL dựa trên các điều kiện tìm kiếm và phân trang
            string sql = $@"            
        WITH RankedUserActivity AS (
        SELECT
            U.[user_id] AS UserId,
            U.[fullname] AS Fullname,
            U.[email] AS Email,
            U.[role] AS Role,
            U.[exp] AS Exp,
            U.[score] AS Score,
            U.[created_at] AS CreatedAt,
            U.[images] AS Images,
            H.[action_type] AS ActivityType,
            H.[quiz_id] AS QuizId,
            H.[date_action] AS DateAction,
            ROW_NUMBER() OVER (PARTITION BY U.[user_id] ORDER BY H.[date_action] ASC) AS RowNum
        FROM
            [dbo].[Users] U
        LEFT JOIN
            [dbo].[HistoryUser] H ON U.[user_id] = H.[user_id]
        WHERE
            U.[role] IN (2, 3, 4, 5) -- Thêm điều kiện role vào đây
    )
            SELECT
                UserId,
                Fullname,
                Email,
                Role,
                Exp,
                Score,
                CreatedAt,
                Images,
                ActivityType,
                QuizId,
                DateAction
            FROM
                RankedUserActivity
            WHERE
                RowNum = 1";

            // Thêm điều kiện tìm kiếm nếu có
            if (!string.IsNullOrEmpty(searchTerm))
            {
                sql += " AND ([fullname] LIKE @SearchTerm OR [email] LIKE @SearchTerm)";
            }

            // Thêm phần ORDER BY và phân trang ở cuối câu lệnh SQL
            sql += $@" ORDER BY Fullname
        OFFSET {pageSize * (page - 1)} ROWS FETCH NEXT {pageSize} ROWS ONLY;";

            // Tạo đối tượng param chứa tham số
            var param = new
            {
                SearchTerm = $"%{searchTerm}%" // Thêm dấu % để thực hiện tìm kiếm mơ hồ
            };

            // Thực hiện truy vấn
            var users = await _crudCommon.QueryAsync<UserManager>(sql, param);

            return users;
        }



        public async Task<IEnumerable<UserRecentActivity>> GetUsersRecentActivity(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {

                // Viết câu lệnh SQL hoặc sử dụng Dapper để truy vấn thông tin hoạt động gần đây của người dùng có role = 4
                string sql = @"SELECT 
                                U.[user_id],
                                U.[fullname],
                                U.[email],
                                MAX(H.[date_action]) AS DateAction,
                                COUNT(DISTINCT H.[history_id]) AS TotalActivities
                            FROM 
                                [dbo].[Users] U
                            JOIN 
                                [dbo].[HistoryUser] H ON U.[user_id] = H.[user_id] AND H.[date_action] >= DATEADD(day, -14, GETDATE())
                            WHERE 
                                U.[role] IN (4, 5)
                            GROUP BY 
                                U.[user_id], U.[fullname], U.[email]
                            ORDER BY 
                                TotalActivities DESC, U.[fullname];";

                var param = new
                {
                    SearchTerm = $"%{searchTerm}%",
                    PageSize = pageSize,
                    Page = page
                };

                // Thực hiện truy vấn
                var recentActivity = await _crudCommon.QueryAsync<UserRecentActivity>(sql, param);

                return recentActivity;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc thông báo lỗi nếu cần
                throw ex;
            }
        }
        public async Task<IEnumerable<UserRecentActivity>> GetUsersInfrequentActivity(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            try
            {

                // Viết câu lệnh SQL hoặc sử dụng Dapper để truy vấn thông tin hoạt động gần đây của người dùng có role = 4
                string sql = @"SELECT 
                                U.[user_id],
                                U.[fullname],
                                U.[email],
                                MAX(H.[date_action]) AS DateAction,
                                COUNT(DISTINCT H.[history_id]) AS TotalActivities
                            FROM 
                                [dbo].[Users] U
                            LEFT JOIN 
                                [dbo].[HistoryUser] H ON U.[user_id] = H.[user_id] AND H.[date_action] >= DATEADD(day, -14, GETDATE())
                            WHERE 
                                U.[role] IN (4, 5)
                                AND H.[date_action] IS NULL -- Chưa có hoạt động trong 14 ngày
                            GROUP BY 
                                U.[user_id], U.[fullname], U.[email]
                            ORDER BY 
                                U.[fullname];";

                var param = new
                {
                    SearchTerm = $"%{searchTerm}%",
                    PageSize = pageSize,
                    Page = page
                };

                var infrequentActivity = await _crudCommon.QueryAsync<UserRecentActivity>(sql, param);
                return infrequentActivity;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc thông báo lỗi nếu cần
                throw ex;
            }
        }

        public async Task<bool> UpdateUserExp(int userId, int expToAdd)
        {
            string sql = "UPDATE Users SET exp = exp + @ExpToAdd WHERE user_id = @UserId";
            var param = new { UserId = userId, ExpToAdd = expToAdd };

            int affectedRows = await _crudCommon.ExecuteAsync(sql, param);
            return affectedRows > 0;
        }

        public async Task<bool> UpdateUserRole(int userId, int newRoleId)
        {
            string sql = "UPDATE Users SET role = @NewRoleId WHERE user_id = @UserId";
            var param = new { UserId = userId, NewRoleId = newRoleId };

            int affectedRows = await _crudCommon.ExecuteAsync(sql, param);
            return affectedRows > 0;
        }

        public async Task<UserManager> GetUserDetails(int userId)
        {
            try
            {
                // Viết câu lệnh SQL hoặc sử dụng Dapper để truy vấn thông tin chi tiết của người dùng
                string sql = "SELECT [user_id], [fullname], [email], [role], [exp], [score], [created_at] FROM [dbo].[Users] WHERE [user_id] = @UserId";

                var param = new
                {
                    UserId = userId
                };

                var userDetails = await _crudCommon.QuerySingleOrDefaultAsync<UserManager>(sql, param);

                return userDetails;
            }
            catch (Exception ex)
            {
                // Xử lý lỗi hoặc thông báo lỗi nếu cần
                throw ex;
            }
        }
        public async Task<int[]> GetDailyMembersForMonth()
        {
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            string sql = @"
                    SELECT 
                        COUNT(*) AS DailyMembers, 
                        CAST(created_at AS DATE) AS Date
                    FROM Users 
                    WHERE created_at >= @FirstDayOfMonth AND created_at <= @LastDayOfMonth
                    GROUP BY CAST(created_at AS DATE)
                    ORDER BY Date";

            var param = new
            {
                FirstDayOfMonth = firstDayOfMonth,
                LastDayOfMonth = lastDayOfMonth
            };

            var dailyMembers = await _crudCommon.QueryAsync<(int DailyMembers, DateTime Date)>(sql, param);

            // Tạo mảng kết quả với tất cả các giá trị mặc định là 0
            var result = new int[DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month)];

            // Đổ dữ liệu từ kết quả truy vấn vào mảng
            foreach (var item in dailyMembers)
            {
                int day = item.Date.Day - 1; // Vị trí trong mảng bắt đầu từ 0
                result[day] = item.DailyMembers;
            }

            return result;
        }


        public async Task<decimal[]> GetDailySalesForMonth()
        {
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            string salesSql = @"
                            SELECT 
                                ISNULL(SUM(amount), 0) AS DailySales, 
                                CAST(payment_date AS DATE) AS Date
                            FROM Payments 
                            WHERE payment_date >= @FirstDayOfMonth AND payment_date <= @LastDayOfMonth
                            GROUP BY CAST(payment_date AS DATE)
                            ORDER BY Date";

            var param = new
            {
                FirstDayOfMonth = firstDayOfMonth,
                LastDayOfMonth = lastDayOfMonth
            };

            var dailySales = await _crudCommon.QueryAsync<(decimal DailySales, DateTime Date)>(salesSql, param);

            // Tạo mảng kết quả với tất cả các giá trị mặc định là 0
            var result = new decimal[DateTime.DaysInMonth(firstDayOfMonth.Year, firstDayOfMonth.Month)];

            // Đổ dữ liệu từ kết quả truy vấn vào mảng
            foreach (var item in dailySales)
            {
                int day = item.Date.Day - 1; // Vị trí trong mảng bắt đầu từ 0
                result[day] = item.DailySales;
            }

            return result;
        }


        public async Task<int> GetTotalUsers()
        {
            string sql = "SELECT COUNT(*) FROM Users WHERE [role] IN (2, 3, 4, 5)";
            int totalUsers = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return totalUsers;
        }

        public async Task<int> GetTotalQuiz()
        {
            string sql = "SELECT COUNT(*) FROM Quizzes where status != -1";
            int totalQuiz = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return totalQuiz;
        }

        public async Task<int> GetTotalQuizlevel1()
        {
            string sql = "SELECT COUNT(*) FROM Quizzes WHERE [difficulty_level] = 1 and status != -1";
            int totalQuizlevel1 = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return totalQuizlevel1;
        }

        public async Task<int> GetTotalQuizlevel2()
        {
            string sql = "SELECT COUNT(*) FROM Quizzes WHERE [difficulty_level] = 2  and status != -1";
            int totalQuizlevel2 = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return totalQuizlevel2;
        }

        public async Task<int> GetTotalQuizlevel3()
        {
            string sql = "SELECT COUNT(*) FROM Quizzes WHERE [difficulty_level] = 3 and status != -1";
            int totalQuizlevel3 = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return totalQuizlevel3;
        }

        public async Task<int> GetTotalUsersVip()
        {
            string sql = "SELECT COUNT(*) FROM Users WHERE [role] = 5";
            int TotalUsersVip = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return TotalUsersVip;
        }

        public async Task<int> GetTotalUsersNoVip()
        {
            string sql = "SELECT COUNT(*) FROM Users WHERE [role] = 4";
            int TotalUsersNoVip = await _crudCommon.ExecuteScalarAsync<int>(sql);
            return TotalUsersNoVip;
        }

        public async Task<decimal> TotalSalesThisMonth()
        {
            // Lấy ngày đầu tiên và cuối cùng của tháng hiện tại
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            // Tạo câu lệnh SQL để tính tổng số tiền
            string sql = "SELECT SUM(amount) FROM Payments WHERE payment_date >= @FirstDayOfMonth AND payment_date <= @LastDayOfMonth";

            // Tạo đối tượng param chứa tham số
            var param = new
            {
                FirstDayOfMonth = firstDayOfMonth,
                LastDayOfMonth = lastDayOfMonth
            };

            // Thực hiện truy vấn và lấy tổng số tiền
            decimal totalSales = await _crudCommon.ExecuteScalarAsync<decimal>(sql, param);

            return totalSales;
        }

        public async Task<decimal> GetTotalSales()
        {
            string sql = "SELECT SUM(amount) FROM Payments";

            // Thực hiện truy vấn và lấy tổng số tiền
            decimal totalSales = await _crudCommon.ExecuteScalarAsync<decimal>(sql);

            return totalSales;
        }

        public async Task<List<Category>> GetCategory()
        {
            string sql = @"SELECT [category_id]
                  ,[category_name]
              FROM [dbo].[Category]"; ;

            // Thực hiện truy vấn và lấy tổng số tiền
            var data = await _crudCommon.QueryAsync<Category>(sql);

            return data.ToList();
        }

        public async Task<int> TotalMemberThisMonth()
        {
            // Lấy ngày đầu tiên và cuối cùng của tháng hiện tại
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime lastDayOfMonth = firstDayOfMonth.AddMonths(1).AddDays(-1);

            // Tạo câu lệnh SQL để đếm số thành viên được đăng ký trong tháng
            string sql = "SELECT COUNT(*) FROM Users WHERE created_at >= @FirstDayOfMonth AND created_at <= @LastDayOfMonth";

            // Tạo đối tượng param chứa tham số
            var param = new
            {
                FirstDayOfMonth = firstDayOfMonth,
                LastDayOfMonth = lastDayOfMonth
            };

            // Thực hiện truy vấn và đếm tổng số thành viên
            int totalMembers = await _crudCommon.ExecuteScalarAsync<int>(sql, param);

            return totalMembers;
        }

        //Quiz 
        public async Task<IEnumerable<QuizManager>> GetQuizzesWithInfo(string? searchTerm = null, int? difficultyLevel = null, int? status = null, int page = 1, int pageSize = 10)
        {
            // Xây dựng câu lệnh SQL dựa trên các điều kiện tìm kiếm và phân trang
            string sql = $@"SELECT 
                        Q.[quiz_id],
                        Q.[title],
                        Q.[category_id],
                        Q.[description],
                        Q.[quiz_type],
                        Q.[status],
                        Q.[image],
                        Q.[difficulty_level],
                        Q.[time_limit],
                        Q.[creator_id],
                        Q.[create_date],
                        Q.[updated_at],
                        U.[fullname] AS creator_name
                    FROM [dbo].[Quizzes] Q
                    LEFT JOIN [dbo].[Users] U ON Q.[creator_id] = U.[user_id]
                    WHERE 1 = 1
                        and Q.status != -1";

            // Thêm điều kiện tìm kiếm nếu có
            if (!string.IsNullOrEmpty(searchTerm))
            {
                sql += " AND Q.[title] LIKE @SearchTerm";
            }
            if (difficultyLevel.HasValue)
            {
                sql += " AND Q.[difficulty_level] = @DifficultyLevel";
            }
            if (status.HasValue)
            {
                sql += " AND Q.[status] = @Status";
            }

            sql += $" ORDER BY Q.[create_date] DESC OFFSET {pageSize * (page - 1)} ROWS FETCH NEXT {pageSize} ROWS ONLY;";

            // Tạo đối tượng param chứa tham số
            var param = new
            {
                SearchTerm = $"%{searchTerm}%", // Thêm dấu % để thực hiện tìm kiếm mơ hồ
                DifficultyLevel = difficultyLevel,
                Status = status
            };

            // Thực hiện truy vấn
            var quizzes = await _crudCommon.QueryAsync<QuizManager>(sql, param);

            return quizzes;
        }

        public async Task<IEnumerable<VIPMember>> GetVIPMembers(string searchTerm, int page, int pageSize)
        {
            try
            {
                int offset = (page - 1) * pageSize;

                string sql = $@"
                    SELECT
                        U.[user_id] AS UserId,
                        U.[username] AS Username,
                        U.[fullname] AS Fullname,
                        U.[email] AS Email,
                        ISNULL(SUM(P.[amount]), 0) AS TotalAmount
                    FROM
                        [dbo].[Users] U
                    LEFT JOIN
                        [dbo].[Payments] P ON U.[user_id] = P.[user_id]
                    WHERE
                        U.[role] = 5
                        AND (U.[username] LIKE @SearchTerm OR U.[fullname] LIKE @SearchTerm OR U.[email] LIKE @SearchTerm)
                    GROUP BY
                        U.[user_id], U.[username], U.[fullname], U.[email]
                    ORDER BY
                        U.[username]
                    OFFSET {offset} ROWS
                    FETCH NEXT {pageSize} ROWS ONLY;";

                var param = new { SearchTerm = $"%{searchTerm}%" };

                var vipMembers = await _crudCommon.QueryAsync<VIPMember>(sql, param);

                return vipMembers;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<IEnumerable<UserHistoryInfo>> GetUserHistory(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            // Tính vị trí bắt đầu của trang
            int start = (page - 1) * pageSize;

            // Tạo điều kiện tìm kiếm
            string searchCondition = string.IsNullOrEmpty(searchTerm)
                ? "" // Nếu không có điều kiện tìm kiếm, bỏ qua
                : $"AND (U.[username] LIKE '%{searchTerm}%' OR H.[quiz_id] LIKE '%{searchTerm}%' OR Q.[title] LIKE '%{searchTerm}%')";

            string query = $@"
                            SELECT 
                                H.[history_id] AS HistoryId,
                                H.[user_id] AS UserId,
                                H.[action_type] AS ActionType,
                                H.[quiz_id] AS QuizId,
                                H.[date_action] AS DateAction,
                                U.[username] AS UserName,
                                Q.[title] AS QuizTitle
                            FROM [dbo].[HistoryUser] H
                            INNER JOIN [dbo].[Users] U ON H.[user_id] = U.[user_id]
                            LEFT JOIN [dbo].[Quizzes] Q ON H.[quiz_id] = Q.[quiz_id]
                            WHERE 1=1 {searchCondition}
                            ORDER BY H.[date_action] DESC
                            OFFSET {start} ROWS
                            FETCH NEXT {pageSize} ROWS ONLY";

            return await _crudCommon.QueryAsync<UserHistoryInfo>(query);
        }

        public async Task<IEnumerable<PaymentInfo>> GetPaymentsWithUsername(string? searchTerm = null, int page = 1, int pageSize = 10)
        {
            string query = @"
            SELECT 
                P.[payment_id] AS PaymentId,
                P.[user_id] AS UserId,
                P.[amount] AS Amount,
                P.[payment_date] AS PaymentDate,
                P.[payment_method] AS PaymentMethod,
                U.[username] AS Username
            FROM [dbo].[Payments] P
            INNER JOIN [dbo].[Users] U ON P.[user_id] = U.[user_id]
            WHERE 
                (U.[username] LIKE @SearchTerm OR P.[payment_method] LIKE @SearchTerm)
                OR @SearchTerm IS NULL
            ORDER BY P.[payment_date] DESC
            OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY
            ";

            var offset = (page - 1) * pageSize;
            var parameters = new { SearchTerm = $"%{searchTerm}%", Offset = offset, PageSize = pageSize };

            return await _crudCommon.QueryAsync<PaymentInfo>(query, parameters);
        }

        public async Task<Category> GetCategoryByName(string categoryName)
        {
            string sql = "SELECT [category_id], [category_name] FROM [dbo].[Category] WHERE [category_name] = @CategoryName";

            var param = new
            {
                CategoryName = categoryName
            };

            var category = await _crudCommon.QuerySingleOrDefaultAsync<Category>(sql, param);

            return category;
        }

        public async Task<bool> AddCategory(CreateCategory createCategory)
        {
            string query = @"
                        INSERT INTO [dbo].[Category] ([category_name])
                        VALUES (@CategoryName);
                        ";

            var parameters = new
            {
                CategoryName = createCategory.CategoryName
            };

            int affectedRows = await _crudCommon.ExecuteAsync(query, parameters);
            return affectedRows > 0;
        }

        public async Task<bool> UpdateCategory(CreateCategory request)
        {
            string query = @"UPDATE [dbo].[Category]
                               SET [category_name] = @categoryName
                             WHERE category_id =@categoryId";

            var parameters = new
            {
                categoryId = request.CategoryId,
                categoryName = request.CategoryName
            };

            int affectedRows = await _crudCommon.ExecuteAsync(query, parameters);
            return affectedRows > 0;
        }

        public async Task<IEnumerable<CategoryWithQuestionCount>> GetCategoriesByQuestionStatus(int? userId, int status)
        {
            string sql;
            if (userId != null)
            {
                sql = @"
                SELECT c.[category_id], c.[category_name], COUNT(q.[question_id]) AS question_count
                FROM [QuizArenaSQL].[dbo].[Category] c
                INNER JOIN [QuizArenaSQL].[dbo].[Questions] q ON c.[category_id] = q.[category_id]
                WHERE q.[status] = @Status and user_id=@UserId
                GROUP BY c.[category_id], c.[category_name]
                ";
            }
            else
            {
                sql = @"
                SELECT c.[category_id], c.[category_name], COUNT(q.[question_id]) AS question_count
                FROM [QuizArenaSQL].[dbo].[Category] c
                INNER JOIN [QuizArenaSQL].[dbo].[Questions] q ON c.[category_id] = q.[category_id]
                WHERE q.[status] = @Status
                GROUP BY c.[category_id], c.[category_name]
                ";
            }
     

            var param = new
            {
                Status = status,
                UserId = userId
            };

            return await _crudCommon.QueryAsync<CategoryWithQuestionCount>(sql, param);
        }

        public async Task<DeleQuestion> GetQuestionById(int questionId)
        {
            string sql = "SELECT [question_id], [status] FROM [dbo].[Questions] WHERE [question_id] = @QuestionId";

            var param = new
            {
                QuestionId = questionId
            };

            var question = await _crudCommon.QuerySingleOrDefaultAsync<DeleQuestion>(sql, param);

            return question;
        }

        public async Task<dynamic> GetNumberAllQuestion()
        {
            try
            {
                string sql = "SELECT count(*) as numAll FROM [dbo].[Questions] WHERE status = 1";


                var numAll = await _crudCommon.QueryFirstOrDefaultAsync<int>(sql, null);

                string sql1 = "SELECT count(*) as numApprove FROM [dbo].[Questions] WHERE status = 2";

                var numApprove = await _crudCommon.QueryFirstOrDefaultAsync<int>(sql1, null);


                var result = new
                {
                    numAll = numAll,
                    numApprove = numApprove
                };
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<bool> CheckQuestionReferences(int questionId)
        {
            string sql = @"
                            SELECT COUNT(*) 
                            FROM [QuizArenaSQL].[dbo].[QuestionsAttempts] 
                            WHERE [question_id] = @QuestionId
                         ";

            var param = new
            {
                QuestionId = questionId
            };

            var count = await _crudCommon.QuerySingleOrDefaultAsync<int>(sql, param);

            return count > 0;
        }


        public async Task<bool> DeleteQuestion(int questionId)
        {
            string query = @"
                        DELETE FROM [QuizArenaSQL].[dbo].[Questions]
                        WHERE [question_id] = @QuestionId AND [status] = 4
                     ";

            var parameters = new
            {
                QuestionId = questionId
            };

            int affectedRows = await _crudCommon.ExecuteAsync(query, parameters);
            return affectedRows > 0;
        }

        public async Task<bool> InsertPayment(int userId, PaymentModel request)
        {
            try
            {
                string insertPaymentQuery = @"
            INSERT INTO [dbo].[Payments] ([user_id], [amount], [payment_date], [payment_method])
            VALUES (@UserId, @Amount, Getdate(), @PaymentMethod);
        ";

                var parameters = new
                {
                    UserId = userId,
                    Amount = request.Amount,
                    PaymentMethod = request.PaymentMethod
                };

                await _crudCommon.ExecuteAsync(insertPaymentQuery, parameters);

                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
