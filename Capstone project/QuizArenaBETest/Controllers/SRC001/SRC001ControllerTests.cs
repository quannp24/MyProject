namespace QuizArenaBETest.Controllers.SRC001
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net.Http;
    using System.Security.Claims;
    using System.Text;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using NSubstitute;
    using NSubstitute.ExceptionExtensions;
    using NSubstitute.ReturnsExtensions;
    using QuizArenaBE.Controllers.SRC001;
    using QuizArenaBE.Entity.Common;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC001;
    using QuizArenaBE.Repository.SRC001;
    using Xunit;

    public class SRC001ControllerTests
    {
        private readonly IFixture _fixture = new Fixture();
        private readonly IUserService _userService;
        private readonly IUserRepository _userRepository;
        private readonly SRC001Controller _testClass;
        public SRC001ControllerTests()
        {
            _fixture.Customize(new AutoMoqCustomization());
            _userService = Substitute.For<IUserService>();
            _userRepository = Substitute.For<IUserRepository>();
            _testClass = new SRC001Controller(_userService, _userRepository);
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

        [Theory]
        [InlineData(true)]
        [InlineData(false)]
        public async void TestLogin(bool status)
        {
            // Arrange
            var request = _fixture.Create<LoginModel>();
            if (status)
            {
                _userService.Login(Arg.Any<string>(), Arg.Any<string>()).Returns(new ResponseCommon<string>(_fixture.Create<string>(), status: true));
            }
            else
            {
                _userService.Login(Arg.Any<string>(), Arg.Any<string>()).Throws(new Exception());
            }
            // Act

            var Result = await _testClass.Login(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        public async void TestSendMailRestPass(int status)
        {
            // Arrange
            var request = _fixture.Create<string>();
            if (status == 1)
            {
                _userService.SendMailRestPass(Arg.Any<string>()).Returns(new ResponseCommon(_fixture.Create<string>(), status: true));
            }
            else if (status == 2)
            {
                _userService.SendMailRestPass(Arg.Any<string>()).Returns(new ResponseCommon(_fixture.Create<string>(), status: false));
            }
            else
            {
                _userService.SendMailRestPass(Arg.Any<string>()).Throws(new Exception());
            }
            // Act

            var Result = await _testClass.SendMailRestPass(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        [InlineData(4)]
        public async void TestChangePass(int status)
        {
            // Arrange
            var request = _fixture.Create<ChangePasswordRequest>();
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
            if (status == 1)
            {
                _userService.ChangePass(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>()).Returns(new ResponseCommon(_fixture.Create<string>(), status: true));
            }
            else if (status == 2)
            {
                _userService.ChangePass(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>()).Returns(new ResponseCommon(_fixture.Create<string>(), status: false));
            }
            else if (status == 3)
            {

                _testClass.ModelState.AddModelError("key", "error message");
                _userService.ChangePass(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>()).Returns(new ResponseCommon(_fixture.Create<string>(), status: false));
            }
            else
            {
                _userService.ChangePass(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.ChangePass(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        public async void TestGetUserInfoById(int status)
        {
            // Arrange
            var request = _fixture.Create<int>();
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
            if (status == 1)
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Returns(_fixture.Create<Users?>());
            }
            else if (status == 2)
            {
                _userService.GetUserInfoById(Arg.Any<int>()).ReturnsNull();
            }

            else
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.GetUserInfoById();

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        public async void TestGetUserPublic(int status)
        {
            // Arrange
            var request = _fixture.Create<int>();

            if (status == 1)
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Returns(_fixture.Create<Users?>());
            }
            else if (status == 2)
            {
                _userService.GetUserInfoById(Arg.Any<int>()).ReturnsNull();
            }

            else
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.GetUserPublic(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        public async void TestUpdateUser(int status)
        {
            // Arrange
            var request = _fixture.Create<UserUpdateModel>();

            if (status == 1)
            {
                _userService.UpdateUserInfo(Arg.Any<int>(), Arg.Any<UserUpdateModel>()).Returns(_fixture.Create<ResponseCommon>());
            }
            else if (status == 2)
            {
                _userService.UpdateUserInfo(Arg.Any<int>(), Arg.Any<UserUpdateModel>()).Returns(new ResponseCommon() { Status = false });
            }

            else
            {
                _userService.UpdateUserInfo(Arg.Any<int>(), Arg.Any<UserUpdateModel>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.UpdateUser(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        [InlineData(4)]
        public async void TestRegister(int status)
        {
            // Arrange
            var request = _fixture.Create<RegisterReq>();

            if (status == 1)
            {
                _userService.RegisterUser(Arg.Any<RegisterReq>()).Returns(_fixture.Create<ResponseCommon>());
            }
            else if (status == 2)
            {
                _userService.RegisterUser(Arg.Any<RegisterReq>()).Returns(new ResponseCommon() { Status = false });
            }

            else if (status == 3)
            {
                _testClass.ModelState.AddModelError("key", "error message");
                _userService.RegisterUser(Arg.Any<RegisterReq>()).Returns(new ResponseCommon() { Status = false });
            }
            else
            {
                _userService.RegisterUser(Arg.Any<RegisterReq>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.Register(request);

            // Assert
            Assert.NotNull(Result);
        }


        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        public async void Testinfouser(int status)
        {
            // Arrange
            var request = _fixture.Create<int>();

            if (status == 1)
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Returns(_fixture.Create<Users>());
            }
            else if (status == 2)
            {

            }
            else
            {
                _userService.GetUserInfoById(Arg.Any<int>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.infouser(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Theory]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        [InlineData(4)]
        public async void TestUploadHistoryUser(int status)
        {
            // Arrange
            var request = _fixture.Create<int>();

            if (status == 1)
            {
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
                _userService.UploadHistoryUser(Arg.Any<int>(), Arg.Any<int>()).Returns(_fixture.Create<ResponseCommon>());
            }
            else if (status == 2)
            {

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
                _userService.UploadHistoryUser(Arg.Any<int>(), Arg.Any<int>()).Returns(new ResponseCommon(status: false));
            }
            else if (status == 3)
            {

            }
            else
            {
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
                _userService.GetUserInfoById(Arg.Any<int>()).Throws(new Exception());
            }


            // Act

            var Result = await _testClass.GetUserPublic(request);

            // Assert
            Assert.NotNull(Result);
        }

        [Fact]
        public async Task CanCallLogin()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var loginModel = fixture.Create<LoginModel>();

            _userService.Login(Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<ResponseCommon<string>>());

            // Act
            var result = await _testClass.Login(loginModel);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallSendMailRestPass()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var toMail = fixture.Create<string>();

            _userService.SendMailRestPass(Arg.Any<string>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.SendMailRestPass(toMail);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallChangePass()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var changePasswordRequest = fixture.Create<ChangePasswordRequest>();

            _userService.ChangePass(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>()).Returns(fixture.Create<ResponseCommon>());
            _userRepository.CheckOldPassword(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.ChangePass(changePasswordRequest);

            // Assert
            Assert.NotNull(result);
        }

      
        [Fact]
        public async Task CanCallRegister()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<RegisterReq>();

            _userService.RegisterUser(Arg.Any<RegisterReq>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.Register(request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetUserInfoById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userService.GetUserInfoById(Arg.Any<int>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.GetUserInfoById();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallinfouser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _userService.GetUserInfoById(Arg.Any<int>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.infouser(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetUserPublic()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _userService.GetUserInfoById(Arg.Any<int>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.GetUserPublic(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var updatedUser = fixture.Create<UserUpdateModel>();

            _userService.UpdateUserInfo(Arg.Any<int>(), Arg.Any<UserUpdateModel>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.UpdateUser(updatedUser);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallUploadHistoryUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var req = fixture.Create<UploadHistoryUserReq>();

            _userService.UploadHistoryUser(Arg.Any<int>(), Arg.Any<int?>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.UploadHistoryUser(req);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetListFriends()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            _userService.GetListFriend(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            var result = await _testClass.GetListFriends(roomId);

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

            _userService.GetFriends(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<FriendInfo>>());

            // Act
            var result = await _testClass.GetFriends(userId, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetFriendStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var friendId = fixture.Create<int>();

            _userService.GetFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<FriendInfo>());

            // Act
            var result = await _testClass.GetFriendStatus(friendId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallSendFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<AddFriendRequest>();

            _userService.SendFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.SendFriendRequest(request);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallConfirmFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<AddFriendRequest>();

            _userService.ConfirmFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.ConfirmFriendRequest(request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetFriendNotifications()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userRepository.GetFriendNotifications(Arg.Any<int>()).Returns(fixture.Create<IEnumerable<FriendNotification>>());

            // Act
            var result = await _testClass.GetFriendNotifications();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeclineFriendRequest()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<AddFriendRequest>();

            _userService.DeclineFriendRequest(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.DeclineFriendRequest(request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallSearchHomepage()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userService.Search().Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            var result = await _testClass.SearchHomepage();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetNotificationUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userService.GetNotification(Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            var result = await _testClass.GetNotificationUser();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallResetSession()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _userService.ResetSession().Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.ResetSession();

            // Assert
            Assert.NotNull(result);
        }
    }
}
