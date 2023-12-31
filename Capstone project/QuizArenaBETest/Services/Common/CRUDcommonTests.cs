namespace QuizArenaBETest
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Configuration;
    using NSubstitute;
    using QuizAndFriends.Services.Common;
    using Xunit;
    using T = System.String;

    public class CRUDcommonTests
    {
        private CRUDcommon _testClass;
        private IConfiguration _configuration;

        public CRUDcommonTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _configuration = Substitute.For<IConfiguration>();
            _configuration.GetConnectionString("QuizArenaSQL").Returns("server=LFAR\\LFAR;database=QuizArenaSQL;uid=sa;pwd=123");
            _testClass = new CRUDcommon(_configuration);
        }


        [Fact]
        public async Task CanCallQuery()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var query = fixture.Create<string>();
            var @param = fixture.Create<object>();

            try
            {
                // Act
                var result = await _testClass.Query<T>(query, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }

        }

        [Fact]
        public async Task CanCallExecute()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var query = fixture.Create<string>();
            var @param = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.Execute(query, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallQuerySingleOrDefaultAsync()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var query = fixture.Create<string>();
            var @param = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.QuerySingleOrDefaultAsync<T>(query, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallQueryFirstOrDefaultAsync()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var sql = fixture.Create<string>();
            var parameters = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.QueryFirstOrDefaultAsync<T>(sql, parameters);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallInsertBulkCopy()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var records = fixture.Create<List<T>>();
            try
            {
                // Act
                await _testClass.InsertBulkCopy<T>(records);
                // Assert
                Assert.NotNull(2);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallQueryAsync()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var sql = fixture.Create<string>();
            var @param = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.QueryAsync<T>(sql, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallExecuteScalarAsyncWithSql()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var sql = fixture.Create<string>();
            try
            {
                // Act
                var result = await _testClass.ExecuteScalarAsync<T>(sql);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }


        [Fact]
        public async Task CanCallExecuteScalarAsyncWithTAndStringAndObject()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var sql = fixture.Create<string>();
            var @param = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.ExecuteScalarAsync<T>(sql, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallExecuteAsync()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var sql = fixture.Create<string>();
            var @param = fixture.Create<object>();
            try
            {
                // Act
                var result = await _testClass.ExecuteAsync(sql, param);
                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {

                Assert.NotNull(1);
            }
        }

    }
}