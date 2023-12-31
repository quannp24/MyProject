namespace QuizArenaBETest.Controllers.SRC002
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.AspNetCore.Http;
    using Microsoft.AspNetCore.Mvc;
    using NSubstitute;
    using QuizArenaBE.Controllers.SRC001;
    using QuizArenaBE.Controllers.SRC002;
    using QuizArenaBE.Entity.Common;
    using QuizArenaBE.Entity.SRC002;
    using QuizArenaBE.Services.SRC001;
    using Xunit;

    public class SRC002ControllerTests
    {
        private SRC002Controller _testClass;
        private IQuizService _quizService;

        public SRC002ControllerTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _quizService = Substitute.For<IQuizService>(); ;
            _testClass = new SRC002Controller(_quizService);
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
        public async Task CanCallGetDataQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            _quizService.GetQuiz(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<QuizModel>>());

            // Act
            var result = await _testClass.GetDataQuiz(quizId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertDataQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<InsertQuizReq>();

            _quizService.AddQuiz(Arg.Any<int>(), Arg.Any<InsertQuizReq>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            var result = await _testClass.InsertDataQuiz(request);

            // Assert
            Assert.NotNull(result);
        }

        

        [Fact]
        public async Task CanCallGetQuestionsRandom()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var req = fixture.Create<GetQuestionsRandomReq>();

            _quizService.GetQuestionsRandom(Arg.Any<GetQuestionsRandomReq>()).Returns(fixture.Create<ResponseCommon<List<object>>>());

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

            _quizService.GetQuizRecentPopular(Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            var result = await _testClass.GetQuizRecentPopular();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetInforDoQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            _quizService.GetInforRoomQuiz(Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.GetInforDoQuiz(roomId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallCreateRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quiz = fixture.Create<CreateRoomReq>();

            _quizService.AddRoomQuiz(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.CreateRoomQuiz(quiz);

            // Assert
            Assert.NotNull(result);
        }

        

        [Fact]
        public async Task CanCallFriendJoinRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var room = fixture.Create<RoomUserQuiz>();

            _quizService.FriendJoinRoomQuiz(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.FriendJoinRoomQuiz(room);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteRoomQuizUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var room = fixture.Create<RoomUserQuiz>();

            _quizService.DeleteRoomQuizUser(Arg.Any<string>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.DeleteRoomQuizUser(room);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamInfo()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizService.GetExamInfo(Arg.Any<int?>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.GetExamInfo();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateQuizModel>();

            _quizService.UpdateQuiz(Arg.Any<UpdateQuizModel>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.UpdateQuiz(request);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallUpdateQuizPrivate()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateQuizModel>();

            _quizService.UpdateQuizPrivate(Arg.Any<UpdateQuizModel>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act

            var result = await _testClass.UpdateQuiz(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizForMod()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizService.GetQuizForMod().Returns(fixture.Create<ResponseCommon<object>>());

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

            _quizService.GetActiveQuizzes().Returns(fixture.Create<ResponseCommon<List<ActiveQuiz>>>());

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
            _quizService.DeleteQuiz(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.DeleteQuiz(quizId,quiztype);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallChangeQuizStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizStatus = fixture.Create<UpdateStatusQuiz>();

            _quizService.ChangeQuizStatus(Arg.Any<UpdateStatusQuiz>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.ChangeQuizStatus(quizStatus);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertExamUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var req = fixture.Create<InsertExamUserModel>();

            _quizService.InsertExamUser(Arg.Any<InsertExamUserModel>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.InsertExamUser(req);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetUnapprovedQuizzes()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();

            _quizService.GetQuizzesByStatus(Arg.Any<List<int>>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<List<QuizA>>());

            // Act
            
            var result = await _testClass.GetUnapprovedQuizzes(page, pageSize, searchTerm);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallGetApprovedQuizzes()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var page = fixture.Create<int>();
            var pageSize = fixture.Create<int>();
            var searchTerm = fixture.Create<string>();

            _quizService.GetQuizzesByStatus(Arg.Any<List<int>>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>()).Returns(fixture.Create<List<QuizA>>());

            // Act
            
            var result = await _testClass.GetApprovedQuizzes(page, pageSize, searchTerm);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesByCategoryAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryId = fixture.Create<int>();

            _quizService.GetQuizzesByCategoryAndStatus(Arg.Any<int>()).Returns(fixture.Create<List<QuizCategory>>());

            // Act
            
            var result = await _testClass.GetQuizzesByCategoryAndStatus(categoryId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesByStaffAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizService.GetQuizzesByStaffAndStatus(Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.GetQuizzesByStaffAndStatus();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamList()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizService.GetExamList().Returns(fixture.Create<List<ExamModel>>());

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
            var request = fixture.Create<ExamModel>();

            _quizService.CreateExam(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<DateTime>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.CreateExam(request);

            // Assert
            Assert.NotNull(result);
        }

      

        [Fact]
        public async Task CanCallEditExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<ExamModel>();

            _quizService.EditExam(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<DateTime>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.EditExam(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizService.DeleteExam(Arg.Any<string>()).Returns(fixture.Create<ResponseCommon>());

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

            _quizService.ChangeExamStatus(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.ChangeExamStatus(examId, newStatus);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetInforLobby()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examid = fixture.Create<string>();

            _quizService.GetInforLobby(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<object>>());

            // Act
            
            var result = await _testClass.GetInforLobby(examid);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateUserExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateUserExam>();

            _quizService.UpdateUserExam(Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int?>()).Returns(fixture.Create<ResponseCommon<bool>>());

            // Act
            
            var result = await _testClass.UpdateUserExam(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesByTypeAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());

            _quizService.GetQuizzesByTypeAndStatus(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuizModel.QuizzesSRC002>>());

            // Act
            
            var result = await _testClass.GetQuizzesByTypeAndStatus();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizService.GetListExamById(Arg.Any<string>()).Returns(fixture.Create<ExamModel>());

            // Act
            
            var result = await _testClass.GetExamById(examId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetInforChallengeDetail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizService.GetInforChallengeDetail(Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<object>());

            // Act
            
            var result = await _testClass.GetInforChallengeDetail(examId);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallCountUserDoQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            _quizService.CountUserDoQuiz(Arg.Any<int>()).Returns(fixture.Create<object>());

            // Act
            
            var result = await _testClass.CountUserDoQuiz(quizId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateFinishChallenge()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            _quizService.UpdateFinishChallenge(Arg.Any<string>(), Arg.Any<int>()).Returns(fixture.Create<object>());

            // Act
            
            var result = await _testClass.UpdateFinishChallenge(examId);

            // Assert
            Assert.NotNull(result);
        }

    
        [Fact]
        public async Task CanCallAddQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<QuestionModel>();

            _quizService.AddQuestions(Arg.Any<int>(), Arg.Any<QuestionModel>()).Returns(fixture.Create<ResponseCommon>());

            // Act
            
            var result = await _testClass.AddQuestions(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetListQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            _quizService.GetListQuiz(Arg.Any<int>()).Returns(fixture.Create<object>());

            // Act
            
            var result = await _testClass.GetListQuiz(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallEditQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<QuestionModel>();

            _quizService.EditQuestions(Arg.Any<int>(), Arg.Any<QuestionModel>()).Returns(fixture.Create<ResponseCommon>());

            // Act           
            
            var result = await _testClass.EditQuestions(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallChangeQuestionStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<ChangeQuestionStatusRequest>();

            _quizService.ChangeQuestionStatus(Arg.Any<ChangeQuestionStatusRequest>()).Returns(fixture.Create<ResponseCommon>());

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

            _quizService.GetQuestionsByCategory(Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuestionModel.ListQuestion>>());

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

            _quizService.GetQuestionsByCategoryAndSearchPage(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<string>(), Arg.Any<int>(), Arg.Any<int>()).Returns(fixture.Create<IEnumerable<QuestionModel.ListQuestion>>());

            // Act
            
            var result = await _testClass.GetQuestionsByCategoryAndSearchPage(categoryId, status, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }
     
    }
}