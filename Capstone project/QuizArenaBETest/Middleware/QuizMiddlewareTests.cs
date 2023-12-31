namespace QuizArenaBETest
{
    using System;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.DependencyInjection;
    using QuizAndFriends.Middleware;
    using Xunit;

    public static class QuizMiddlewareTests
    {
        [Fact]
        public static void CanCallAddMiddleware()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var services = fixture.Create<IServiceCollection>();

            // Act
            services.AddMiddleware();

            // Assert
        }
    }
}