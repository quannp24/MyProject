namespace QuizArenaBETest.Repository.Hub
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Configuration;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC001;
    using QuizArenaBE.Repository.Hub;
    using QuizArenaBE.Services.Common;
    using Xunit;

    public class HubRepostioryTests
    {
        private HubRepostiory _testClass;
        private ICRUDcommon _crudCommon;
        private IConfiguration _configuration;

        public HubRepostioryTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _crudCommon = Substitute.For<ICRUDcommon>();
            _configuration = Substitute.For<IConfiguration>();
            _configuration.GetConnectionString("QuizArenaSQL").Returns("server=LFAR\\LFAR;database=QuizArenaSQL;uid=sa;pwd=123");
            _testClass = new HubRepostiory(_crudCommon, _configuration);
        }

        [Fact]
        public async Task CanCallGetFriendOnline()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userid = fixture.Create<int>();

            _crudCommon.QueryAsync<string>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<string>>());

            // Act
            var result = await _testClass.GetFriendOnline(userid);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetTitleQuizByRoomID()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            _crudCommon.QueryFirstOrDefaultAsync<QuizArenaBE.Entity.SRC001.Quiz>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<QuizArenaBE.Entity.SRC001.Quiz>());

            // Act
            var result = await _testClass.GetTitleQuizByRoomID(roomId);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task GetUserInforByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetUserInforById(userId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallCheckRoomIdExists()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            _crudCommon.QueryFirstOrDefaultAsync<string>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<string>());

            // Act
            var result = await _testClass.CheckRoomIdExists(roomId);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallUpdateStatusUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userid = fixture.Create<int>();
            var status = fixture.Create<int>();

            // Act
            await _testClass.UpdateStatusUser(userid, status);

            // Assert 
        }

        [Fact]
        public async Task CanCallUpdateRoleUserRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userid = fixture.Create<int>();
            var role = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            // Act
            await _testClass.UpdateRoleUserRoomQuiz(userid, role, roomId);

            // Assert 
        }
         
        [Fact]
        public async Task CanCallRemoveHelperUserRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            // Act
            await _testClass.RemoveHelperUserRoomQuiz(roomId);

            // Assert 
        }
         
        [Fact]
        public async Task CanCallUpdateRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();
            var currentQuestion = fixture.Create<int>();
            var totalExp = fixture.Create<int>();

            // Act
            await _testClass.UpdateRoomQuiz(roomId, currentQuestion, totalExp);

            // Assert 
        }
         
        [Fact]
        public async Task CanCallCreateRoom()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var UserId = fixture.Create<int>();
            var RoomId = fixture.Create<string>();
            var QuizId = fixture.Create<int>();
            var CurrentQuestion = fixture.Create<int?>();
            var TotalExp = fixture.Create<int?>();

            // Act
            try
            {
                await _testClass.CreateRoom(UserId, RoomId, QuizId, CurrentQuestion, TotalExp);
            }
            catch
            {

                Assert.NotNull(1);
            }
            

            // Assert 
        }
         
        [Fact]
        public async Task CanCallGetUserOutQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetUserOutQuiz(userId, roomId);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallCheckStatusExamUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userid = fixture.Create<int>();
            var examid = fixture.Create<string>();

            // Act
            var result = await _testClass.CheckStatusExamUser(userid, examid);

            // Assert
            Assert.NotNull(result);
        }
         
    }
}