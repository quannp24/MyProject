namespace QuizArenaBETest.Controllers.Payment
{
    using System;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using NSubstitute;
    using QuizArenaBE.Controllers.Payment;
    using QuizArenaBE.Entity.Common;
    using QuizArenaBE.Entity.Payment;
    using QuizArenaBE.Services.Payment;
    using Xunit;

    public class PaymentControllerTests
    {
        private PaymentController _testClass;
        private IPaymentService _paymentService;

        public PaymentControllerTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            _paymentService = Substitute.For<IPaymentService>();
            _testClass = new PaymentController(_paymentService);
        }


        [Fact]
        public async Task CanCallPaymentApi()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var model = fixture.Create<OrderInfoDTO>();

            _paymentService.CreatePaymentAsync(Arg.Any<OrderInfoDTO>(), Arg.Any<int>()).Returns(fixture.Create<ResponseCommon<MomoCreatePaymentResponseModel>>());

            // Act
            var result = await _testClass.PaymentApi(model);

            // Assert
            Assert.NotNull(result);
        }


    }
}