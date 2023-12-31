namespace QuizArenaBETest.Services.SRC003
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Configuration;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC003;
    using QuizArenaBE.Repository.SRC001;
    using QuizArenaBE.Repository.SRC003;
    using QuizArenaBE.Services.Common;
    using QuizArenaBE.Services.SRC003;
    using Xunit;

    public class DashboardServiceTests
    {
        private DashboardService _testClass;
        private IDashboardRepository _dashboardRepository;
        private IConfiguration _configuration;
        private ICommon _common;
        private ICRUDcommon _crudCommon;
        private IUserRepository _userRepository;

        public DashboardServiceTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _dashboardRepository = Substitute.For<IDashboardRepository>();
            _configuration = Substitute.For<IConfiguration>();
            _common = Substitute.For<ICommon>();
            _crudCommon = Substitute.For<ICRUDcommon>();
            _userRepository = Substitute.For<IUserRepository>();
            _testClass = new DashboardService(_dashboardRepository, _configuration, _common, _crudCommon, _userRepository);
        }

        [Fact]
        public async Task CanCallGetUserManager()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _dashboardRepository.GetUsersWithInfo(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserManager>>());

            // Act
            var result = await _testClass.GetUserManager(searchTerm, page, pageSize);

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

            _dashboardRepository.UpdateUserExp(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

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

            _dashboardRepository.UpdateUserRole(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

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

            _dashboardRepository.GetUserDetails(Arg.Any<int>()).Returns(fixture.Create<UserManager>());

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

            _dashboardRepository.GetUsersRecentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

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

            _dashboardRepository.GetUsersInfrequentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());

            // Act
            var result = await _testClass.GetUsersInfrequentActivity(searchTerm, page, pageSize);

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

            _dashboardRepository.GetVIPMembers(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<VIPMember>>());

            // Act
            var result = await _testClass.GetVIPMembers(searchTerm, page, pageSize);

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

            _dashboardRepository.GetPaymentsWithUsername(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<PaymentInfo>>());

            // Act
            var result = await _testClass.GetPaymentsWithUsername(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallSendActivityReminderEmail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetUsersRecentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());
            _common.SendMail(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

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

            _dashboardRepository.GetUsersInfrequentActivity(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserRecentActivity>>());
            _common.SendMail(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.SendInactiveUserInvitationEmail();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSendCustomEmail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userEmail = fixture.Create<string>();
            var subject = fixture.Create<string>();
            var content = fixture.Create<string>();

            _dashboardRepository.GetUsersWithInfo(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserManager>>());
            _common.SendMail(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.SendCustomEmail(userEmail, subject, content);

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

            _dashboardRepository.GetQuizzesWithInfo(Arg.Any<string>(), Arg.Any<int?>(), Arg.Any<int?>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuizManager>>());

            // Act
            var result = await _testClass.GetQuizzesWithInfo(searchTerm, difficultyLevel, status, page, pageSize);

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

            _dashboardRepository.GetUserHistory(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<UserHistoryInfo>>());

            // Act
            var result = await _testClass.GetUserHistory(searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallTotalSalesThisMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.TotalSalesThisMonth().Returns(fixture.Create<decimal>());

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

            _dashboardRepository.GetTotalSales().Returns(fixture.Create<decimal>());

            // Act
            var result = await _testClass.GetTotalSales();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDailyMembersForMonth()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetDailyMembersForMonth().Returns(fixture.Create<int[]>());

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

            _dashboardRepository.GetDailySalesForMonth().Returns(fixture.Create<decimal[]>());

            // Act
            var result = await _testClass.GetDailySalesForMonth();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsersNoVip()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetTotalUsersNoVip().Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalUsersNoVip();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalQuizlevel1()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetTotalQuizlevel1().Returns(fixture.Create<int>());

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

            _dashboardRepository.GetTotalQuizlevel2().Returns(fixture.Create<int>());

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

            _dashboardRepository.GetTotalQuizlevel3().Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuizlevel3();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsers()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetTotalUsers().Returns(fixture.Create<int>());

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

            _dashboardRepository.GetTotalQuiz().Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalQuiz();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTotalUsersVip()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetTotalUsersVip().Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.GetTotalUsersVip();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _dashboardRepository.GetCategory().Returns(fixture.Create<List<Category>>());

            // Act
            var result = await _testClass.GetCategory();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAddCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var createCategory = fixture.Create<CreateCategory>();

            _dashboardRepository.GetCategoryByName(Arg.Any<string>()).Returns(fixture.Create<Category>());
            _dashboardRepository.AddCategory(Arg.Any<CreateCategory>()).Returns(fixture.Create<bool>());

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

            _dashboardRepository.UpdateCategory(Arg.Any<CreateCategory>()).Returns(fixture.Create<bool>());

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

            _dashboardRepository.GetCategoriesByQuestionStatus(Arg.Any<int>()).Returns(fixture.Create<IEnumerable<CategoryWithQuestionCount>>());

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

            _dashboardRepository.GetQuestionById(Arg.Any<int>()).Returns(fixture.Create<DeleQuestion>());
            _dashboardRepository.CheckQuestionReferences(Arg.Any<int>()).Returns(fixture.Create<bool>());
            _dashboardRepository.DeleteQuestion(Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.DeleteQuestion(questionId);

            // Assert
            Assert.NotNull(result);
        }
    }
}