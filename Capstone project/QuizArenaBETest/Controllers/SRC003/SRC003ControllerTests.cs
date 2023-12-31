namespace QuizArenaBETest.Controllers.SRC003
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using NSubstitute;
    using QuizArenaBE.Controllers.SRC003;
    using QuizArenaBE.Entity.Common;
    using QuizArenaBE.Entity.SRC003;
    using QuizArenaBE.Repository.SRC003;
    using QuizArenaBE.Services.SRC003;
    using Xunit;

    public class SRC003ControllerTests
    {
        private SRC003Controller _testClass;
        private IDashboardRepository _dashboardRepository;
        private IDashboardService _dashboardService;

        public SRC003ControllerTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _dashboardRepository = Substitute.For<IDashboardRepository>();
            _dashboardService = Substitute.For<IDashboardService>();
            _testClass = new SRC003Controller(_dashboardRepository, _dashboardService);
            var httpContext = new DefaultHttpContext();
            var items = new Dictionary<object, object>
            {
                { "userId", 1 }
            };
            httpContext.Items = items;

            _testClass.ControllerContext = new ControllerContext
            {
                HttpContext = httpContext
            };
        }

      
        [Fact]
        public async Task CanCallGetUserManager()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _dashboardService.GetUserManager(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserManager>>());

            // Act
            var result = await _testClass.GetUserManager(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }

      

        [Fact]
        public async Task CanCallGetcategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardService.GetCategory().Returns(fixture.Create<object>());

            // Act
            var result = await _testClass.Getcategory();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDashboardStatistics()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardService.GetTotalUsers().Returns(fixture.Create<int>());
            _dashboardService.GetTotalQuiz().Returns(fixture.Create<int>());
            _dashboardService.GetTotalUsersVip().Returns(fixture.Create<int>());
            _dashboardService.TotalSalesThisMonth().Returns(fixture.Create<decimal>());
            _dashboardService.GetTotalSales().Returns(fixture.Create<decimal>());
            _dashboardService.GetTotalUsersNoVip().Returns(fixture.Create<int>());
            _dashboardService.GetTotalQuizlevel1().Returns(fixture.Create<int>());
            _dashboardService.GetTotalQuizlevel2().Returns(fixture.Create<int>());
            _dashboardService.GetTotalQuizlevel3().Returns(fixture.Create<int>());
            _dashboardService.GetDailyMembersForMonth().Returns(fixture.Create<int[]>());
            _dashboardService.GetDailySalesForMonth().Returns(fixture.Create<decimal[]>());

            // Act
            var result = await _testClass.GetDashboardStatistics();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizManager()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var difficultyLevel = fixture.Create<int?>();
            var status = fixture.Create<int?>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _dashboardService.GetQuizzesWithInfo(Arg.Any<string>(), Arg.Any<int?>(), Arg.Any<int?>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuizManager>>());

            // Act
            var result = await _testClass.GetQuizManager(searchTerm, difficultyLevel, status, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
 

        [Fact]
        public async Task CanCallUpdateUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var userUpdateRequest = fixture.Create<UserUpdateRequest>();

            _dashboardService.UpdateUserExp(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IActionResult>());
            _dashboardService.UpdateUserRole(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IActionResult>());

            // Act
            var result = await _testClass.UpdateUser(userId, userUpdateRequest);

            // Assert
            Assert.NotNull(result);
        }

      
        [Fact]
        public async Task CanCallGetUserDetails()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _dashboardService.GetUserDetails(Arg.Any<int>()).Returns(fixture.Create<IActionResult>());

            // Act
            var result = await _testClass.GetUserDetails(userId);

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

            _dashboardService.GetUsersRecentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

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

            _dashboardService.GetUsersInfrequentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

            // Act
            var result = await _testClass.GetUsersInfrequentActivity(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }

       
        [Fact]
        public async Task CanCallSendActivityReminderEmail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardService.SendActivityReminderEmail().Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.SendActivityReminderEmail();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSendInactiveUserInvitationEmail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardService.SendInactiveUserInvitationEmail().Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.SendInactiveUserInvitationEmail();

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

            _dashboardService.GetVIPMembers(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<VIPMember>>());

            // Act
            var result = await _testClass.GetVIPMembers(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallSendCustomEmail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<CustomEmailRequest>();

            _dashboardService.SendCustomEmail(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.SendCustomEmail(request);

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

            _dashboardService.GetUserHistory(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserHistoryInfo>>());

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

            _dashboardService.GetPaymentsWithUsername(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<PaymentInfo>>());

            // Act
            var result = await _testClass.GetPaymentsWithUsername(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallAddCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var createCategory = fixture.Create<CreateCategory>();

            _dashboardService.AddCategory(Arg.Any<CreateCategory>()).Returns(fixture.Create<ResponseCommon>());

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
            var createCategory = fixture.Create<CreateCategory>();

            _dashboardService.UpdateCategory(Arg.Any<CreateCategory>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.UpdateCategory(createCategory);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetCategoriesByQuestionStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var status = fixture.Create<int>();

            _dashboardService.GetCategoriesByQuestionStatus(Arg.Any<int>()).Returns(fixture.Create<IEnumerable<CategoryWithQuestionCount>>());

            // Act
            var result = await _testClass.GetCategoriesByQuestionStatus(status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteQuestion()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var questionId = fixture.Create<int>();

            _dashboardService.DeleteQuestion(Arg.Any<int>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.DeleteQuestion(questionId);

            // Assert
            Assert.NotNull(result);
        }
    }
}