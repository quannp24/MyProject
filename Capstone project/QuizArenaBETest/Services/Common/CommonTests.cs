namespace QuizArenaBETest.Services.Common
{
    using System;
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using QuizArenaBE.Services.Common;
    using Xunit;

    public class CommonTests
    {
        private Common _testClass;

        public CommonTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _testClass = new Common();
        }


        [Fact]
        public async Task CanCallSendMail()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var emailTo = "dathp028@gmail.com";
            var Subject = fixture.Create<string>();
            var Body = fixture.Create<string>();

            // Act
            var result = await _testClass.SendMail(emailTo, Subject, Body);

            // Assert
            Assert.NotNull(result);
        }


        [Fact]
        public async Task CanCallSendMailMany()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var emailTo = new List<string> { "dathp028@gmail.com" };
            var Subject = fixture.Create<string>();
            var Body = fixture.Create<string>();

            // Act
            var result = await _testClass.SendMailMany(emailTo, Subject, Body);

            // Assert
            Assert.NotNull(result);
        }


    }
}