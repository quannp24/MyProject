using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.Payment;
using QuizArenaBE.Entity.SRC001;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Services.Payment;

namespace QuizArenaBE.Controllers.Payment
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly IPaymentService _paymentService;

        public PaymentController(IPaymentService paymentService)
        {
            _paymentService = paymentService;
        }

        [Authorize]
        [HttpPost("Request-Payment")]
        public async Task<IActionResult> PaymentApi([FromBody] OrderInfoDTO model)
        {
            try
            {
                var userId = (int?)HttpContext.Items["userId"];
                if (userId == null)
                {
                    return BadRequest("userId is null");
                }
                var callService = await _paymentService.CreatePaymentAsync(model, userId.Value);
                return Ok(callService);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ResponseCommon<string>("", ex.Message, false));
            }
        }
    }
}
