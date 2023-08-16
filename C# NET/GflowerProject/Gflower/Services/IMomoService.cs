
using Gflower.DTO.Momo;
using Gflower.DTO;

namespace Gflower.Services;

public interface IMomoService
{
    Task<MomoCreatePaymentResponseModel> CreatePaymentAsync(OrderInfoDTO model);
    MomoExecuteResponseModel PaymentExecuteAsync(IQueryCollection collection);
}