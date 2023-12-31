namespace QuizArenaBETest.Repository.SRC003
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC003;
    using QuizArenaBE.Repository.SRC003;
    using QuizArenaBE.Services.Common;
    using Xunit;

    public class DashboardRepositoryTests
    {
        private DashboardRepository _testClass;
        private ICRUDcommon _crudCommon;

        public DashboardRepositoryTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _crudCommon = Substitute.For<ICRUDcommon>();
            _testClass = new DashboardRepository(_crudCommon);
        }


        [Fact]
        public async Task CanCallGetUsersWithInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<UserManager>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<UserManager>>());

            // Act
            var result = await _testClass.GetUsersWithInfo(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
        
        [Fact]
        public async Task CanCallGetUsersRecentActivity()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<UserRecentActivity>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

            // Act
            var result = await _testClass.GetUsersRecentActivity(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetUsersInfrequentActivity()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<UserRecentActivity>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

            // Act
            var result = await _testClass.GetUsersInfrequentActivity(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallUpdateUserExp()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var expToAdd = fixture.Create<int>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateUserExp(userId, expToAdd);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateUserRole()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var newRoleId = fixture.Create<int>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateUserRole(userId, newRoleId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetUserDetails()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<UserManager>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<UserManager>());

            // Act
            var result = await _testClass.GetUserDetails(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetUserDetailsPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetUserDetails(userId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetDailyMembersForMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<(int DailyMembers, DateTime Date)>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<(int DailyMembers, DateTime Date)>>());

            // Act
            var result = await _testClass.GetDailyMembersForMonth();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDailySalesForMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<(decimal DailySales, DateTime Date)>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<(decimal DailySales, DateTime Date)>>());

            // Act
            var result = await _testClass.GetDailySalesForMonth();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsers()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalUsers();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuiz();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalQuizlevel1()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuizlevel1();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalQuizlevel2()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuizlevel2();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalQuizlevel3()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuizlevel3();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsersVip()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalUsersVip();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsersNoVip()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalUsersNoVip();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallTotalSalesThisMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<decimal>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<decimal>());

            // Act
            var result = await _testClass.TotalSalesThisMonth();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalSales()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<decimal>(Arg.Any<string>()).Returns(fixture.Create<decimal>());

            // Act
            var result = await _testClass.GetTotalSales();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<Category>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<Category>>());

            // Act
            var result = await _testClass.GetCategory();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallTotalMemberThisMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.TotalMemberThisMonth();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesWithInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var difficultyLevel = fixture.Create<int?>();
            var status = fixture.Create<int?>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<QuizManager>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<QuizManager>>());

            // Act
            var result = await _testClass.GetQuizzesWithInfo(searchTerm, difficultyLevel, status, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetVIPMembers()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<VIPMember>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<VIPMember>>());

            // Act
            var result = await _testClass.GetVIPMembers(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetUserHistory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<UserHistoryInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<UserHistoryInfo>>());

            // Act
            var result = await _testClass.GetUserHistory(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetPaymentsWithUsername()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<PaymentInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<PaymentInfo>>());

            // Act
            var result = await _testClass.GetPaymentsWithUsername(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         

        [Fact]
        public async Task CanCallGetCategoryByName()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryName = fixture.Create<string>();

            _crudCommon.QuerySingleOrDefaultAsync<Category>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<Category>());

            // Act
            var result = await _testClass.GetCategoryByName(categoryName);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task GetCategoryByNamePerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryName = fixture.Create<string>();

            // Act
            var result = await _testClass.GetCategoryByName(categoryName);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallAddCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var createCategory = fixture.Create<CreateCategory>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.AddCategory(createCategory);

            // Assert
            Assert.NotNull(result);
        }
         

        [Fact]
        public async Task CanCallUpdateCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<CreateCategory>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateCategory(request);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetCategoriesByQuestionStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var status = fixture.Create<int>();

            _crudCommon.QueryAsync<CategoryWithQuestionCount>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<CategoryWithQuestionCount>>());

            // Act
            var result = await _testClass.GetCategoriesByQuestionStatus(status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuestionById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var questionId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<DeleQuestion>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<DeleQuestion>());

            // Act
            var result = await _testClass.GetQuestionById(questionId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetQuestionByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var questionId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuestionById(questionId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallCheckQuestionReferences()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var questionId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.CheckQuestionReferences(questionId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteQuestion()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var questionId = fixture.Create<int>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.DeleteQuestion(questionId);

            // Assert
            Assert.NotNull(result);
        }
    }
}