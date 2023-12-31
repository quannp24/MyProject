namespace QuizArenaBETest.Services.SRC001
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Configuration;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC001;
    using QuizArenaBE.Entity.SRC003;
    using QuizArenaBE.Repository.SRC001;
    using QuizArenaBE.Services.Common;
    using QuizArenaBE.Services.SRC001;
    using Xunit;

    public class UserServiceTests
    {
        private UserService _testClass;
        private IUserRepository _userRepository;
        private IConfiguration _configuration;
        private ICommon _common;
        private ICRUDcommon _crudCommon;

        public UserServiceTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _userRepository = Substitute.For<IUserRepository>();
            _configuration = Substitute.For<IConfiguration>();
            _common = Substitute.For<ICommon>();
            _crudCommon = Substitute.For<ICRUDcommon>();
            _testClass = new UserService(_userRepository, _configuration, _common, _crudCommon);
        }

       
        [Fact]
        public async Task CanCallLogin()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var username = fixture.Create<string>();
            var password = fixture.Create<string>();
            var appSettings = @"{
                ""JwtSettings"": {
                    ""Secret"": ""CrvBc5SmfwV2ERynuAYaJk4zpheKjGx3"",
                    ""Issuer"": ""WPERYxFg8UNDLVy6wZJa9CnQurv3p7zB"",
                    ""Audience"": ""Us59vYVRmzBfPgSAXDk2cxjWC3uKyp46""
                }
            }";

            var builder = new ConfigurationBuilder();

            builder.AddJsonStream(new MemoryStream(Encoding.UTF8.GetBytes(appSettings)));

            _configuration = builder.Build();

            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());

            // Act
            _testClass = new UserService(_userRepository, _configuration, _common, _crudCommon);        
            var result = await _testClass.Login(username, password);

            // Assert
            Assert.NotNull(result);
        }

       

        [Fact]
        public async Task CanCallRegisterUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<RegisterReq>();

            _userRepository.IsEmailInRegister(Arg.Any<string>()).Returns(fixture.Create<bool>());
            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.RegisterUser(request);

            // Assert
            Assert.NotNull(result);
        }

       
        public async Task CanCallSendMailRestPass()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var mailAddress = fixture.Create<string>();

            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());
            _userRepository.UpdatePassword(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<int>());
            _common.SendMail(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.SendMailRestPass(mailAddress);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallChangePass()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var oldPass = fixture.Create<string>();
            var newPass = fixture.Create<string>();

            _userRepository.GetUserById(Arg.Any<int>()).Returns(fixture.Create<Users>());
            _userRepository.UpdatePassword(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.ChangePass(userId, oldPass, newPass);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetUserInfoById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.GetUserInfoById(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetUserInfoByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<Users?>());
            // Act
            var result = await _testClass.GetUserInfoById(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateUserInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var user = fixture.Create<UserUpdateModel>();

            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());
            _userRepository.IsEmailInUse(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<bool>());
            _userRepository.UpdateUserInfo(Arg.Any<int>(), Arg.Any<UserUpdateModel>(), Arg.Any<Users>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateUserInfo(userId, user);

            // Assert
            Assert.NotNull(result);
        }

        
        [Fact]
        public async Task CanCallUploadHistoryUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var quizId = fixture.Create<int?>();

            // Act
            var result = await _testClass.UploadHistoryUser(userId, quizId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSendFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _userRepository.SendFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.SendFriendRequest(userId, friendId);

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

            _userRepository.ConfirmFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.ConfirmFriendRequest(userId, friendId);

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

            _userRepository.GetFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<FriendInfo>());

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
            _userRepository.GetFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<FriendInfo>());
            // Act
            var result = await _testClass.GetFriendRequest(userId, friendId);

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

            _userRepository.GetFriends(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<FriendInfo>>());

            // Act
            var result = await _testClass.GetFriends(userId, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }

       

        [Fact]
        public async Task CanCallGetFriendNotifications()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _userRepository.GetFriendNotifications(Arg.Any<int>()).Returns(fixture.Create<IEnumerable<FriendNotification>>());

            // Act
            var result = await _testClass.GetFriendNotifications(userId);

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

            _userRepository.DeclineFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.DeclineFriendRequest(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAreFriendsMessage()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _userRepository.AreFriends(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.AreFriendsMessage(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetFriendRequestMessage()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var friendId = fixture.Create<int>();

            _userRepository.GetFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<FriendInfo>());
            _userRepository.GetFriend(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<FriendInfo>());

            // Act
            var result = await _testClass.GetFriendRequestMessage(userId, friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSearch()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userRepository.SearchUser().Returns(fixture.Create<IEnumerable<SearchModel>>());
            _userRepository.SearchExam().Returns(fixture.Create<IEnumerable<SearchModel>>());
            _userRepository.SearchQuiz().Returns(fixture.Create<IEnumerable<SearchModel>>());

            // Act
            var result = await _testClass.Search();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetListFriend()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            _userRepository.GetFriendsOnOrOff(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<List<FriendsOnOrOffModel>>());

            // Act
            var result = await _testClass.GetListFriend(userId, roomId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetNotification()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _userRepository.GetNotification(Arg.Any<int>()).Returns(fixture.Create<IEnumerable<Notification>>());

            // Act
            var result = await _testClass.GetNotification(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertPayment()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<PaymentInfo>();

            // Act
            var result = await _testClass.InsertPayment(request);

            // Assert
            Assert.NotNull(result);
        }

       
        [Fact]
        public async Task CanCallResetSession()
        {
            // Act
            var result = await _testClass.ResetSession();

            // Assert
            Assert.NotNull(result);
        }
    }
}