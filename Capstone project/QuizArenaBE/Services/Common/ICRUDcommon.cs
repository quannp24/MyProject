namespace QuizArenaBE.Services.Common
{
    public interface ICRUDcommon
    {
        public Task<IEnumerable<T>> Query<T>(string query, object param = null);

        public Task InsertBulkCopy<T>(List<T> records);

        public Task<int> Execute(string query, object param = null);

        public Task<T?> QuerySingleOrDefaultAsync<T>(string query, object param = null);
        public Task<T> QueryFirstOrDefaultAsync<T>(string sql, object parameters);
        public Task<IEnumerable<T>> QueryAsync<T>(string sql, object param = null);
        public Task<T> ExecuteScalarAsync<T>(string sql);
        public Task<T> ExecuteScalarAsync<T>(string sql, object param = null);
        public Task<int> ExecuteAsync(string sql, object param);
    }
}
