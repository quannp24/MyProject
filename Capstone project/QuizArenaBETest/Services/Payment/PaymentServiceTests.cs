namespace QuizArenaBETest.Services.Payment
{
    using System;
    using System.Threading.Tasks;
    using AutoFixture;
    using AutoFixture.AutoMoq;
    using Microsoft.Extensions.Options;
    using NSubstitute;
    using QuizArenaBE.Entity.Payment;
    using QuizArenaBE.Entity.SQL;
    using QuizArenaBE.Repository.SRC001;
    using QuizArenaBE.Services.Payment;
    using Xunit;

    public class PaymentServiceTests
    {
        private PaymentService _testClass;
        private IOptions<MomoOptionModel> _options;
        private IUserRepository _userRepository;

        public PaymentServiceTests()
        {
            var fixture = new Fixture().Customize(new AutoMoqCustomization());           
            _options = Substitute.For<IOptions<MomoOptionModel>>();
            var momoOptions = fixture.Create<MomoOptionModel>();
            momoOptions.MomoApiUrl = "https://test-payment.momo.vn/gw_payment/transactionProcessor";
            momoOptions.SecretKey = "K951B6PE1waDMi640xX08PD3vg6EkVlz";
            _options.Value.Returns(momoOptions);
            _userRepository = Substitute.For<IUserRepository>();
            _testClass = new PaymentService(_options, _userRepository);
        }


        [Fact]
        public async Task CanCallCreatePaymentAsync()
        {
            // Arrange
            var fixture = new Fixture().Customize(new AutoMoqCustomization());
            var model = fixture.Create<OrderInfoDTO>();
            var UserID = fixture.Create<int>();

            _userRepository.GetUser(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>(), Arg.Any<int?>()).Returns(fixture.Create<Users>());

            // Act
            var result = await _testClass.CreatePaymentAsync(model, UserID);

            // Assert
            Assert.NotNull(result);
        }

    }
}