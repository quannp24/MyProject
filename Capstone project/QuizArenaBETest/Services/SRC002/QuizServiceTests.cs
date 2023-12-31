namespace QuizArenaBETest.Services.SRC002
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using NSubstitute;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Entity.SRC002;
    using QuizArenaBE.Repository.Hub;
    using QuizArenaBE.Repository.SRC001;
    using QuizArenaBE.Repository.SRC002;
    using QuizArenaBE.Services.SRC002;
    using Xunit;

    public class QuizServiceTests
    {
        private QuizService _testClass;
        private IQuizRepository _quizrRepository;
        private IUserRepository _userRepository;
        private IHubRepostiory _hubRepostiory;

        public QuizServiceTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _quizrRepository = Substitute.For<IQuizRepository>();
            _userRepository = Substitute.For<IUserRepository>();
            _hubRepostiory = Substitute.For<IHubRepostiory>();
            _testClass = new QuizService(_quizrRepository, _userRepository, _hubRepostiory);
        }

       
        [Fact]
        public async Task CanCallGetQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();
            var userId = fixture.Create<int>();

            _quizrRepository.GetDataQuiz(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<QuizModel>());
            _userRepository.GetHistoryUser(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<List<HistoryUser>>());

            // Act
            var result = await _testClass.GetQuiz(quizId, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAddQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<InsertQuizReq>();

            _quizrRepository.InsertDataQuiz(Arg.Any<int>(), Arg.Any<InsertQuizReq>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.AddQuiz(userId, request);

            // Assert
            Assert.NotNull(result);
        }

       
        [Fact]
        public async Task CanCallGetQuestionsRandom()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var req = fixture.Create<GetQuestionsRandomReq>();

            _quizrRepository.GetRandomQuestions(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<List<dynamic>>());

            // Act
            var result = await _testClass.GetQuestionsRandom(req);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetQuizRecentPopular()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _quizrRepository.GetDataQuizRecent(Arg.Any<int>()).Returns(fixture.Create<List<QuizRecentPopular>>());
            _quizrRepository.GetDataQuizPopular().Returns(fixture.Create<List<QuizRecentPopular>>());
            _quizrRepository.GetDataExamRecent().Returns(fixture.Create<List<ExamModel>>());

            // Act
            var result = await _testClass.GetQuizRecentPopular(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetInforRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            _quizrRepository.GetUserDoQuiz(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<RoomDoUser>());
            _quizrRepository.GetUsersInRoom(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<List<UserInQuiz>>());

            // Act
            var result = await _testClass.GetInforRoomQuiz(userId, roomId);

            // Assert
            Assert.NotNull(result);
        }
 

        [Fact]
        public async Task CanCallGetListQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _quizrRepository.GetListQuiz(Arg.Any<int>()).Returns(fixture.Create<object>());

            // Act
            var result = await _testClass.GetListQuiz(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAddRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();
            var userId = fixture.Create<int>();

            _hubRepostiory.CheckRoomIdExists(Arg.Any<string>()).Returns(false);

            // Act
            var result = await _testClass.AddRoomQuiz(quizId, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallFriendJoinRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();
            var userId = fixture.Create<int>();
            var quizId = fixture.Create<int>();

            _quizrRepository.CheckFriendInBossRoom(Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<int>());
            _quizrRepository.InsertUserRoomQuiz(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.FriendJoinRoomQuiz(roomId, userId, quizId);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallDeleteRoomQuizUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            _quizrRepository.DeleteRoomQuizUser(Arg.Any<string>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.DeleteRoomQuizUser(roomId);

            // Assert
            Assert.NotNull(result);
        }

         
        [Fact]
        public async Task CanCallGetExamInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int?>();

            _quizrRepository.GetExamListTop().Returns(fixture.Create<IEnumerable<ExamListTopModel>>());
            _quizrRepository.GetExamToWeek().Returns(fixture.Create<ExamToWeekModel>());
            _quizrRepository.GetExamTop3User().Returns(fixture.Create<IEnumerable<ExamTop3UserModel>>());
            _quizrRepository.GetExamInfoUser(Arg.Any<int>()).Returns(fixture.Create<ExamInfoUserModel>());
            _quizrRepository.CheckUserInExamUser(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.GetExamInfo(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateQuizModel>();
            var userId = fixture.Create<int>();

            _quizrRepository.UpdateQuiz(Arg.Any<UpdateQuizModel>(), Arg.Any<int>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.UpdateQuiz(request, userId);

            // Assert
            Assert.NotNull(result);
        }
 

        [Fact]
        public async Task CanCallGetQuizForMod()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizrRepository.GetQuizForMod().Returns(fixture.Create<object>());

            // Act
            var result = await _testClass.GetQuizForMod();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetActiveQuizzes()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizrRepository.GetActiveQuizzes().Returns(fixture.Create<List<ActiveQuiz>>());

            // Act
            var result = await _testClass.GetActiveQuizzes();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();
            var quiztype = fixture.Create<int>();
            _quizrRepository.DeleteQuiz(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.DeleteQuiz(quizId, quiztype);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallChangeQuizStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateStatusQuiz>();

            _quizrRepository.GetActiveQuizById(Arg.Any<int>()).Returns(fixture.Create<ActiveQuiz>());
            _quizrRepository.UpdateQuizStatus(Arg.Any<UpdateStatusQuiz>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.ChangeQuizStatus(request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task ChangeQuizStatusPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateStatusQuiz>();

            // Act
            var result = await _testClass.ChangeQuizStatus(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertExamUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var req = fixture.Create<InsertExamUserModel>();
            var userId = fixture.Create<int>();

            _quizrRepository.InsertExamUser(Arg.Any<InsertExamUserModel>(), Arg.Any<int>()).Returns(fixture.Create<int>());

            // Act
            var result = await _testClass.InsertExamUser(req, userId);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetQuizzesByStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var status = fixture.Create<List<int>>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();

            _quizrRepository.GetQuizzesByStatus(Arg.Any<List<int>>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<List<QuizA>>());

            // Act
            var result = await _testClass.GetQuizzesByStatus(status, page, pageSize, searchTerm);

            // Assert
            Assert.NotNull(result);
        }

        

        [Fact]
        public async Task GetQuizzesByStatusPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var status = fixture.Create<List<int>>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();

            _quizrRepository.GetQuizzesByStatus(Arg.Any<List<int>>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<List<QuizA>>());

            // Act
            var result = await _testClass.GetQuizzesByStatus(status, page, pageSize, searchTerm);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesByCategoryAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryId = fixture.Create<int>();

            _quizrRepository.GetQuizzesByCategoryAndStatus(Arg.Any<int>()).Returns(fixture.Create<List<QuizCategory>>());

            // Act
            var result = await _testClass.GetQuizzesByCategoryAndStatus(categoryId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamList()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizrRepository.GetExamList().Returns(fixture.Create<List<ExamModel>>());

            // Act
            var result = await _testClass.GetExamList();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallCreateExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examName = fixture.Create<string>();
            var quizId = fixture.Create<int>();
            var description = fixture.Create<string>();
            var image = fixture.Create<string>();
            var examType = fixture.Create<int>();
            var date = fixture.Create<DateTime>();

            _quizrRepository.GenerateUniqueExamId().Returns(fixture.Create<string>());
            
            _quizrRepository.CreateExam(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<DateTime>()).Returns(fixture.Create<string>());

            // Act
            var result = await _testClass.CreateExam(examName, quizId, description, image, examType, date);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallEditExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var examName = fixture.Create<string>();
            var quizId = fixture.Create<int>();
            var description = fixture.Create<string>();
            var image = fixture.Create<string>();
            var examType = fixture.Create<int>();
            var date = fixture.Create<DateTime>();

            _quizrRepository.GetExamById(Arg.Any<string>()).Returns(fixture.Create<ExamModel>());
            _quizrRepository.GetQuizById(Arg.Any<int>()).Returns(fixture.Create<QuizModel>());
            _quizrRepository.EditExam(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<DateTime>(), Arg.Any<string>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.EditExam(examId, examName, quizId, description, image, examType, date);

            // Assert
            Assert.NotNull(result);
        }
 

        [Fact]
        public async Task CanCallDeleteExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizrRepository.GetExamById(Arg.Any<string>()).Returns(fixture.Create<ExamModel>());

            // Act
            var result = await _testClass.DeleteExam(examId);

            // Assert
            Assert.NotNull(result);
        }

        
        [Fact]
        public async Task CanCallChangeExamStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var newStatus = fixture.Create<int>();

            _quizrRepository.GetExamById(Arg.Any<string>()).Returns(fixture.Create<ExamModel>());

            // Act
            var result = await _testClass.ChangeExamStatus(examId, newStatus);

            // Assert
            Assert.NotNull(result);
        }

         

        [Fact]
        public async Task CanCallGetQuizzesByTypeAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizType = fixture.Create<int>();
            var status = fixture.Create<int>();

            _quizrRepository.GetQuizzesByTypeAndStatus(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuizModel.QuizzesSRC002>>());

            // Act
            var result = await _testClass.GetQuizzesByTypeAndStatus(quizType, status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesByStaffAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _quizrRepository.GetQuizzesStaff0(Arg.Any<int>()).Returns(fixture.Create<List<QuizStaff>>());
            _quizrRepository.GetQuizzesStaff1(Arg.Any<int>()).Returns(fixture.Create<List<QuizStaff>>());
            _quizrRepository.GetQuizzesStaff2(Arg.Any<int>()).Returns(fixture.Create<List<QuizStaff>>());
            _quizrRepository.GetQuizzesStaff4(Arg.Any<int>()).Returns(fixture.Create<List<QuizStaff>>());

            // Act
            var result = await _testClass.GetQuizzesByStaffAndStatus(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetInforLobby()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int>();

            _quizrRepository.GetInforLobby(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<object>());

            // Act
            var result = await _testClass.GetInforLobby(examId, userId);

            // Assert
            Assert.NotNull(result);
        }

        
        [Fact]
        public async Task CanCallUpdateUserExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int>();
            var score = fixture.Create<int?>();

            _quizrRepository.UpdateUserExam(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int?>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.UpdateUserExam(examId, userId, score);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetListExamById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizrRepository.GetListExamById(Arg.Any<string>()).Returns(fixture.Create<ExamModel>());

            // Act
            var result = await _testClass.GetListExamById(examId);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallGetInforChallengeDetail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int?>();

            _quizrRepository.GetInforChallenge(Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<GetInforChallengeModel>());

            // Act
            var result = await _testClass.GetInforChallengeDetail(examId, userId);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallUpdateFinishChallenge()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.UpdateFinishChallenge(examId, userId);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallCountUserDoQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            _quizrRepository.GetAllHistoryUser().Returns(fixture.Create<List<HistoryUser>>());

            // Act
            var result = await _testClass.CountUserDoQuiz(quizId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallAddQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<QuestionModel>();

            _quizrRepository.AddQuestions(Arg.Any<int>(), Arg.Any<QuestionModel>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.AddQuestions(userId, request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallEditQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<QuestionModel>();

            _quizrRepository.EditQuestions(Arg.Any<int>(), Arg.Any<QuestionModel>()).Returns(fixture.Create<bool>());

            // Act
            var result = await _testClass.EditQuestions(userId, request);

            // Assert
            Assert.NotNull(result);
        }
 
        [Fact]
        public async Task CanCallChangeQuestionStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<ChangeQuestionStatusRequest>();

            // Act
            var result = await _testClass.ChangeQuestionStatus(request);

            // Assert
            Assert.NotNull(result);
        }
         
        [Fact]
        public async Task CanCallGetQuestionsByCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryId = fixture.Create<int>();
            var status = fixture.Create<int>();

            _quizrRepository.GetQuestionsByCategory(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuestionModel.ListQuestion>>());

            // Act
            var result = await _testClass.GetQuestionsByCategory(categoryId, status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuestionsByCategoryAndSearchPage()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryId = fixture.Create<int>();
            var status = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();

            _quizrRepository.GetQuestionsByCategoryAndSearchPage(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuestionModel.ListQuestion>>());

            // Act
            var result = await _testClass.GetQuestionsByCategoryAndSearchPage(categoryId, status, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
    }
}