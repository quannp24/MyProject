namespace QuizArenaBETest.Repository.SRC001
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC001;
    using QuizArenaBE.Entity.SRC003;
    using QuizArenaBE.Repository.SRC001;
    using QuizArenaBE.Services.Common;
    using Xunit;

    public class UserRepositoryTests
    {
        private UserRepository _testClass;
        private ICRUDcommon _crudCommon;

        public UserRepositoryTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _crudCommon = Substitute.For<ICRUDcommon>();
            _testClass = new UserRepository(_crudCommon);
        }

        [Fact]
        public async Task CanCallIsEmailInUse()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var email = fixture.Create<string>();

            _crudCommon.QueryFirstOrDefaultAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.IsEmailInUse(userId, email);

            // Assert
            Assert.NotNull(result);
        }
      
        [Fact]
        public async Task CanCallIsEmailInRegister()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var email = fixture.Create<string>();

            _crudCommon.QueryFirstOrDefaultAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.IsEmailInRegister(email);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetUserById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<Users>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.GetUserById(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetUserByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetUserById(userId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallCheckOldPassword()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var oldPassword = fixture.Create<string>();

            _crudCommon.QueryFirstOrDefaultAsync<string>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<string>());

            // Act
            var result = await _testClass.CheckOldPassword(userId, oldPassword);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var username = fixture.Create<string>();
            var password = fixture.Create<string>();
            var mail = fixture.Create<string>();
            var userId = fixture.Create<int?>();

            _crudCommon.QuerySingleOrDefaultAsync<Users>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.GetUser(username, password, mail, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetUserPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var username = fixture.Create<string>();
            var password = fixture.Create<string>();
            var mail = fixture.Create<string>();
            var userId = fixture.Create<int?>();

            // Act
            var result = await _testClass.GetUser(username, password, mail, userId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetHistoryUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizid = fixture.Create<int>();
            var userId = fixture.Create<int>();

            _crudCommon.QueryAsync<HistoryUser>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<HistoryUser>>());

            // Act
            var result = await _testClass.GetHistoryUser(quizid, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<FriendInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<FriendInfo>());

            // Act
            var result = await _testClass.GetFriendRequest(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetFriendRequestPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetFriendRequest(userId, friendId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallAreFriends()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.AreFriends(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAddFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();
            var status = fixture.Create<int>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.AddFriendRequest(userId, friendId, status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriend()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.QuerySingleOrDefaultAsync<FriendInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<FriendInfo>());

            // Act
            var result = await _testClass.GetFriend(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetFriendPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetFriend(userId, friendId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetFriendNotifications()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _crudCommon.QueryAsync<FriendNotification>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<FriendNotification>>());

            // Act
            var result = await _testClass.GetFriendNotifications(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriendRequests()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _crudCommon.QueryAsync<FriendInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<FriendInfo>>());

            // Act
            var result = await _testClass.GetFriendRequests(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriends()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _crudCommon.QueryAsync<FriendInfo>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<FriendInfo>>());

            // Act
            var result = await _testClass.GetFriends(userId, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSearchUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<SearchModel>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<SearchModel>>());

            // Act
            var result = await _testClass.SearchUser();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSearchQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<SearchModel>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<SearchModel>>());

            // Act
            var result = await _testClass.SearchQuiz();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSearchExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.QueryAsync<SearchModel>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<SearchModel>>());

            // Act
            var result = await _testClass.SearchExam();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriendsOnOrOff()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            _crudCommon.QueryAsync<FriendsOnOrOffModel>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<FriendsOnOrOffModel>>());

            // Act
            var result = await _testClass.GetFriendsOnOrOff(userId, roomId);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetNotification()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var UserId = fixture.Create<int>();

            _crudCommon.QueryAsync<Notification>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<IEnumerable<Notification>>());

            // Act
            var result = await _testClass.GetNotification(UserId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertNewUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<RegisterReq>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            await _testClass.InsertNewUser(request);

            // Assert

        }
         
        [Fact]
        public async Task CanCallInsertHistoryUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var quizId = fixture.Create<int?>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            await _testClass.InsertHistoryUser(userId, quizId);

            // Assert
        }

        [Fact]
        public async Task CanCallInsertNotification()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var content = fixture.Create<string>();
            var value = fixture.Create<string>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            await _testClass.InsertNotification(userId, content, value);

            // Assert

        }
         
        [Fact]
        public async Task CanCallSendFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());
            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());
            _crudCommon.ExecuteScalarAsync<string>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<string>());

            // Act
            var result = await _testClass.SendFriendRequest(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertPayment()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<PaymentInfo>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            await _testClass.InsertPayment(request);

            // Assert
        }
         
        [Fact]
        public async Task CanCallUpdateUserInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var user = fixture.Create<UserUpdateModel>();
            var oldUser = fixture.Create<Users>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateUserInfo(userId, user, oldUser);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallUpdatePassword()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var id = fixture.Create<int>();
            var pass = fixture.Create<string>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdatePassword(id, pass);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallUpdateTokenUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var id = fixture.Create<int>();
            var token = fixture.Create<string>();

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            await _testClass.UpdateTokenUser(id, token);

            // Assert
             
        }
         
        [Fact]
        public async Task CanCallResetSession()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _crudCommon.Execute(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.ResetSession();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallConfirmFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.ExecuteScalarAsync<int>(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());
            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.ConfirmFriendRequest(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeclineFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _crudCommon.ExecuteAsync(Arg.Any<string>(), Arg.Any<object>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.DeclineFriendRequest(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }
    }
}