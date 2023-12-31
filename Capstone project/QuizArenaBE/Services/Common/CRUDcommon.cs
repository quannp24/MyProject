using System.Data;
using System.Data.SqlClient;
using Dapper;
using QuizArenaBE.Services.Common;

namespace QuizAndFriends.Services.Common
{
    public class CRUDcommon : ICRUDcommon
    {
        private readonly IConfiguration _configuration;
        private readonly string connectionString;
        private readonly IDbConnection _dbConnection;

        public CRUDcommon(IConfiguration configuration)
        {
            _configuration = configuration;
            connectionString = _configuration.GetConnectionString("QuizArenaSQL");
            _dbConnection = new SqlConnection(connectionString);
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }

        public async Task<IEnumerable<T>> Query<T>(string query, object param = null)
        {
            try
            {
                _dbConnection.Open();
                var data = await _dbConnection.QueryAsync<T>(query, param);
                _dbConnection.Close();

                return data;
            }
            catch (Exception ex)
            {

                throw ex;
            }         
        }
     
        public async Task<int> Execute(string query, object param = null)
        {
            try
            {
                _dbConnection.Open();             
                int rowsAffected = await _dbConnection.ExecuteAsync(query, param);              
                _dbConnection.Close();
                return rowsAffected ;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public async Task<T?> QuerySingleOrDefaultAsync<T>(string query, object param = null)
        {
            try
            {
                _dbConnection.Open();
                T? result = await _dbConnection.QuerySingleOrDefaultAsync<T>(query, param);
                _dbConnection.Close();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<T> QueryFirstOrDefaultAsync<T>(string sql, object parameters = null)
        {
            return await _dbConnection.QueryFirstOrDefaultAsync<T>(sql, parameters);
        }

        public async Task InsertBulkCopy<T>(List<T> records)
        {
            try
            {
                _dbConnection.Open();
                // Sử dụng Bulk Copy để chèn nhiều bản ghi một lần
                using (SqlBulkCopy bulkCopy = new SqlBulkCopy((SqlConnection)_dbConnection))
                    {
                        bulkCopy.DestinationTableName = nameof(T);
                        await bulkCopy.WriteToServerAsync(GetDataTable(records));

                    }
                _dbConnection.Close();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            
        }

        public async Task<IEnumerable<T>> QueryAsync<T>(string sql, object param = null)
        {
            try
            {
                _dbConnection.Open();
                var data = await _dbConnection.QueryAsync<T>(sql, param);
                _dbConnection.Close();

                return data;
            }
            catch (Exception ex)
            {
                _dbConnection.Close();
                throw ex;
            }
        }

        public async Task<T> ExecuteScalarAsync<T>(string sql)
        {
            try
            {
                _dbConnection.Open();
                T result = await _dbConnection.ExecuteScalarAsync<T>(sql);
                _dbConnection.Close();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<T> ExecuteScalarAsync<T>(string sql, object param = null)
        {
            try
            {
                _dbConnection.Open();
                T result = await _dbConnection.ExecuteScalarAsync<T>(sql, param);
                _dbConnection.Close();
                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public async Task<int> ExecuteAsync(string sql, object param = null)
        {
            try
            {
                _dbConnection.Open();
                int rowsAffected = await _dbConnection.ExecuteAsync(sql, param);
                _dbConnection.Close();
                return rowsAffected;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        #region Method Private


        private DataTable GetDataTable<T>(List<T> records)
        {
            DataTable table = new DataTable();

            // Tạo cấu trúc bảng dựa trên đối tượng
            foreach (var prop in typeof(T).GetProperties())
            {
                table.Columns.Add(prop.Name, prop.PropertyType);
            }

            // Thêm các dòng dữ liệu vào bảng
            foreach (var record in records)
            {
                DataRow row = table.NewRow();
                foreach (var prop in typeof(T).GetProperties())
                {
                    row[prop.Name] = prop.GetValue(record);
                }
                table.Rows.Add(row);
            }

            return table;
        }

        #endregion

    }
}
