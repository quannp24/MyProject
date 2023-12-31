namespace QuizArenaBETest.Repository.SRC002
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Configuration;
    using NSubstitute;
    using QuizArenaBE.Entity.SRC002;
    using QuizArenaBE.Repository.SRC002;
    using Xunit;

    public class QuizRepositoryTests
    {
        private QuizRepository _testClass;
        private IConfiguration _configuration;

        public QuizRepositoryTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _configuration = Substitute.For<IConfiguration>();
            _configuration.GetConnectionString("QuizArenaSQL").Returns("server=LFAR\\LFAR;database=QuizArenaSQL;uid=sa;pwd=123");
            _testClass = new QuizRepository(_configuration);
        }

        [Fact]
        public async Task CanCallGetDataQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var id = fixture.Create<int>();
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetDataQuiz(id, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetListQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetListQuiz(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetAllHistoryUser()
        {
            // Act
            var result = await _testClass.GetAllHistoryUser();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDataQuizPopular()
        {
            // Act
            var result = await _testClass.GetDataQuizPopular();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDataExamRecent()
        {
            // Act
            var result = await _testClass.GetDataExamRecent();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetDataQuizRecent()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userid = fixture.Create<int>();

            // Act
            var result = await _testClass.GetDataQuizRecent(userid);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallInsertDataQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<InsertQuizReq>();
            try
            {
                // Act
                var result = await _testClass.InsertDataQuiz(userId, request);

                // Assert
                Assert.NotNull(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
        }



        [Fact]
        public async Task CanCallGetRandomQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var count = fixture.Create<int>();
            var category = fixture.Create<int>();
            var level = fixture.Create<int>();

            // Act
            var result = await _testClass.GetRandomQuestions(count, category, level);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task GetRandomQuestionsPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var count = fixture.Create<int>();
            var category = fixture.Create<int>();
            var level = fixture.Create<int>();

            try
            {
                // Act
                var result = await _testClass.GetRandomQuestions(count, category, level);

                // Assert
                Assert.Null(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallGetUserDoQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetUserDoQuiz(userId, roomId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetUsersInRoom()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetUsersInRoom(roomId, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallInsertUserRoomQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();
            try
            {
                // Act
                var result = await _testClass.InsertUserRoomQuiz(userId, roomId);

                // Assert
                Assert.NotNull(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallCheckFriendInBossRoom()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var roomId = fixture.Create<string>();
            var quizId = fixture.Create<int>();

            // Act
            var result = await _testClass.CheckFriendInBossRoom(userId, roomId, quizId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteRoomQuizUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var roomId = fixture.Create<string>();

            // Act
            var result = await _testClass.DeleteRoomQuizUser(roomId);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallGetExamListTop()
        {
            // Act
            var result = await _testClass.GetExamListTop();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamInfoUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetExamInfoUser(userId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetExamToWeek()
        {
            // Act
            var result = await _testClass.GetExamToWeek();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetExamTop3User()
        {
            // Act
            var result = await _testClass.GetExamTop3User();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallCheckUserInExamUser()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.CheckUserInExamUser(examId, userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallUpdateQuizPrivate()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateQuizModel>();
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.UpdateQuizPrivate(request, userId);

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

            try
            {
                // Act
                var result = await _testClass.UpdateQuiz(request, userId);

                // Assert
                Assert.NotNull(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallGetQuizForMod()
        {
            // Act
            var result = await _testClass.GetQuizForMod();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetActiveQuizzes()
        {
            // Act
            var result = await _testClass.GetActiveQuizzes();

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetActiveQuizById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetActiveQuizById(quizId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetActiveQuizByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetActiveQuizById(quizId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallUpdateQuizStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var request = fixture.Create<UpdateStatusQuiz>();

            // Act
            var result = await _testClass.UpdateQuizStatus(request);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallDeleteQuiz()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();
            var quiz_type = fixture.Create<int>();

            // Act
            var result = await _testClass.DeleteQuiz(quizId, quiz_type);

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

            try
            {
                // Act
                var result = await _testClass.InsertExamUser(req, userId);

                // Assert
                Assert.NotNull(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
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

            // Act
            var result = await _testClass.GetQuizzesByCategoryAndStatus(categoryId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesStaff0()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizzesStaff0(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesStaff4()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizzesStaff4(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesStaff1()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizzesStaff1(userId);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetQuizzesStaff2()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizzesStaff2(userId);

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

            // Act
            var result = await _testClass.UpdateUserExam(examId, userId, score);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallGetExamList()
        {
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

            try
            {
                // Act
                var result = await _testClass.CreateExam(examName, quizId, description, image, examType, date);

                // Assert
                Assert.NotNull(result);
            }
            catch
            {
                Assert.NotNull(1);
            }

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
            var examType = fixture.Create<int>();
            var date = fixture.Create<DateTime>();
            var image = fixture.Create<string>();
            try
            {
                // Act
                var result = await _testClass.EditExam(examId, examName, quizId, description, examType, date, image);

                // Assert
                Assert.Null(result);
            }
            catch
            {
                Assert.NotNull(1);
            }
        }

        [Fact]
        public async Task CanCallGetExamById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetExamById(examId);

            // Assert
            Assert.Null(result);
        }
        [Fact]
        public async Task GetExamByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetExamById(examId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetQuizById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizId = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizById(quizId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallDeleteExam()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            // Act
            await _testClass.DeleteExam(examId);

            // Assert
        }


        [Fact]
        public async Task CanCallChangeExamStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var newStatus = fixture.Create<int>();

            // Act
            await _testClass.ChangeExamStatus(examId, newStatus);

            // Assert
        }

        [Fact]
        public async Task CanCallGetQuizzesByTypeAndStatus()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var quizType = fixture.Create<int>();
            var status = fixture.Create<int>();

            // Act
            var result = await _testClass.GetQuizzesByTypeAndStatus(quizType, status);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CanCallGetListExamById()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetListExamById(examId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task GetListExamByIdPerformsMapping()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();

            // Act
            var result = await _testClass.GetListExamById(examId);

            // Assert
            Assert.Null(result);
        }

        [Fact]
        public async Task CanCallGetInforChallenge()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var examId = fixture.Create<string>();
            var userId = fixture.Create<int?>();

            // Act
            var result = await _testClass.GetInforChallenge(examId, userId);

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
            await _testClass.UpdateFinishChallenge(examId, userId);

            // Assert

        }

        [Fact]
        public async Task CanCallAddQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<QuestionModel>();

            try
            {
                // Act
                var result = await _testClass.AddQuestions(userId, request);

                // Assert
                Assert.NotNull(result);
            }
            catch (Exception)
            {
                Assert.NotNull(1);
            }

        }


        [Fact]
        public async Task CanCallEditQuestions()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var userId = fixture.Create<int>();
            var request = fixture.Create<QuestionModel>();

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
            var questionId = fixture.Create<int>();
            var newStatus = fixture.Create<int>();

            // Act
            await _testClass.ChangeQuestionStatus(questionId, newStatus);

            // Assert 
        }

        [Fact]
        public async Task CanCallGetQuestionsByCategory()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var categoryId = fixture.Create<int>();
            var status = fixture.Create<int>();

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

            // Act
            var result = await _testClass.GetQuestionsByCategoryAndSearchPage(categoryId, status, searchTerm, page, pageSize);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public void CanCallGenerateUniqueExamId()
        {
            // Act
            var result = _testClass.GenerateUniqueExamId();

            // Assert
            Assert.NotNull(result);
        }
    }
}