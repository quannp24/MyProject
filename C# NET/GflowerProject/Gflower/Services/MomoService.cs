using System.Security.Cryptography;
using System.Text;
using Gflower.DTO;
using Gflower.DTO.Momo;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;

using RestSharp;

namespace Gflower.Services;

public class MomoService : IMomoService
{
    private readonly IOptions<MomoOptionModel> _options;

    public MomoService(IOptions<MomoOptionModel> options)
    {
        _options = options;
    }

    public async Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(OrderInfoDTO model)
    {
        model.OrderId = DateTime.UtcNow.Ticks.ToString();
        model.OrderInfo = "Khách hàng " + model.FullName + " thanh toán cho hóa đơn " + model.OrderId;
        var rawData =
            $"partnerCode={_options.Value.PartnerCode}&accessKey={_options.Value.AccessKey}&requestId={model.OrderId}&amount={model.Amount}&orderId={model.OrderId}&orderInfo={model.OrderInfo}&returnUrl={_options.Value.ReturnUrl}&notifyUrl={_options.Value.NotifyUrl}&extraData=";

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
            orderId = model.OrderId,
            amount = model.Amount.ToString(),
            orderInfo = model.OrderInfo,
            requestId = model.OrderId,
            extraData = "",
            signature = signature
        };

        request.AddParameter("application/json", JsonConvert.SerializeObject(requestData), ParameterType.RequestBody);

        var response = await client.ExecuteAsync(request);

        return JsonConvert.DeserializeObject<MomoCreatePaymentResponseModel>(response.Content);
    }

    public MomoExecuteResponseModel PaymentExecuteAsync(IQueryCollection collection)
    {
        var amount = collection.First(s => s.Key == "amount").Value;
        var orderInfo = collection.First(s => s.Key == "orderInfo").Value;
        var orderId = collection.First(s => s.Key == "orderId").Value;
        var errorCode = collection.First(s => s.Key == "errorCode").Value;
        var orderType = collection.First(s => s.Key == "orderType").Value;
        var message = collection.First(s => s.Key == "message").Value;
        var localMessage = collection.First(s => s.Key == "localMessage").Value;
        return new MomoExecuteResponseModel()
        {
            amount = amount,
            orderId = orderId,
            orderInfo = orderInfo,
            errorCode= errorCode,
            message = message,
            localMessage = localMessage,
            orderType = orderType
        };
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