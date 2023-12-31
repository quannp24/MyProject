using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.Payment;

namespace QuizArenaBE.Services.Payment
{
    public interface IPaymentService
    {
        public Task<ResponseCommon<MomoCreatePaymentResponseModel>> CreatePaymentAsync(OrderInfoDTO model, int UserID);
    }
}
