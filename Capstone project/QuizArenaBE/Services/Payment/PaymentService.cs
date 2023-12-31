using AutoFixture.Kernel;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.Payment;
using QuizArenaBE.Repository.SRC001;
using RestSharp;
using System.Security.Cryptography;
using System.Text;

namespace QuizArenaBE.Services.Payment
{
    public class PaymentService : IPaymentService
    {
        private readonly IOptions<MomoOptionModel> _options;
        private IUserRepository _userRepository;

        public PaymentService(IOptions<MomoOptionModel> options, IUserRepository userRepository)
        {
            _options = options;
            _userRepository = userRepository;
        }

        public async Task<ResponseCommon<MomoCreatePaymentResponseModel>> CreatePaymentAsync(OrderInfoDTO model, int UserID)
        {
            try
            {
                var user = await _userRepository.GetUser(userId: UserID);
                model.FullName = model.FullName;
                model.Amount = model.Amount;
                string OrderId = DateTime.UtcNow.Ticks.ToString();

                string OrderInfo = "Khách hàng " + model.FullName + " thanh toán cho hóa đơn " + OrderId;
                var rawData =
                    $"partnerCode={_options.Value.PartnerCode}&accessKey={_options.Value.AccessKey}&requestId={OrderId}&amount={model.Amount}&orderId={OrderId}&orderInfo={OrderInfo}&returnUrl={_options.Value.ReturnUrl}&notifyUrl={_options.Value.NotifyUrl}&extraData=";

                var signature = ComputeHmacSha256(rawData, _options.Value.SecretKey);

                var client = new RestClient(_options.Value.MomoApiUrl);
                var request = new RestRequest() { Method = Method.Post };
                request.AddHeader("Content-Type", "application/json; charset=UTF-8");

                // Create an object representing the request data
                var requestData = new
                {
                    accessKey = _options.Value.AccessKey,
                    partnerCode = _options.Value.PartnerCode,
                    requestType = _options.Value.RequestType,
                    notifyUrl = _options.Value.NotifyUrl,
                    returnUrl = _options.Value.ReturnUrl,
                    orderId = OrderId,
                    amount = model.Amount.ToString(),
                    orderInfo = OrderInfo,
                    requestId = OrderId,
                    extraData = "",
                    signature = signature
                };

                request.AddParameter("application/json", JsonConvert.SerializeObject(requestData), ParameterType.RequestBody);

                var response = await client.ExecuteAsync(request);
                return new ResponseCommon<MomoCreatePaymentResponseModel>(JsonConvert.DeserializeObject<MomoCreatePaymentResponseModel>(response.Content), "Request success", true);
            }
            catch (Exception ex)
            {
                return new ResponseCommon<MomoCreatePaymentResponseModel>(null, ex.Message, false);

            }
        }


        private string ComputeHmacSha256(string message, string secretKey)
        {
            var keyBytes = Encoding.UTF8.GetBytes(secretKey);
            var messageBytes = Encoding.UTF8.GetBytes(message);

            byte[] hashBytes;

            using (var hmac = new HMACSHA256(keyBytes))
            {
                hashBytes = hmac.ComputeHash(messageBytes);
            }

            var hashString = BitConverter.ToString(hashBytes).Replace("-", "").ToLower();

            return hashString;
        }
    }
}
