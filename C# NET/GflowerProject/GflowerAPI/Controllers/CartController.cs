using AutoMapper;
using BusinessObject;
using DataAccess.IRepository;
using GflowerAPI.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Formatter;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;

namespace GflowerAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    public class CartController : ODataController
    {
        private readonly ICartRepository _cartRepository;
        private readonly IMapper _mapper;

        public CartController(ICartRepository cartRepository, GFlowersContext dbContext, IMapper mapper)
        {
            _cartRepository = cartRepository;
            _mapper = mapper;
            dbContext.ChangeTracker.QueryTrackingBehavior = Microsoft.EntityFrameworkCore.QueryTrackingBehavior.NoTracking;
        }

        [HttpGet]
        [EnableQuery(PageSize = 5)]
        public async Task<IActionResult> Get()
        {
            var raw_cart = await _cartRepository.GetCarts();
            return Ok(raw_cart);
        }

        [HttpGet("{key}")]
        [EnableQuery]
        public IActionResult Get([FromODataUri] int key)
        {
            return Ok(_cartRepository.GetCartById(key));
        }


        [HttpPost]
        [EnableQuery]
        public async Task<IActionResult> Post([FromBody] CartRequestDTO cart)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            Cart raw_cart = new Cart
            {
                AccountId = cart.AccountId,
                ProductId = cart.ProductId,
                Quantity = cart.Quantity,
                TotalPrice = cart.TotalPrice

            };
            return Ok(await _cartRepository.AddProductToCart(raw_cart));
            
        }

        [HttpPut]
        [EnableQuery]
        public async Task<IActionResult> Put([FromBody] CartUpdateQuantityDTO cart)
        {
            try
            {
                await _cartRepository.UpdateQuantity(cart.CartUpdate, cart.IsPlus);
            }catch(Exception ex)
            {
                return NotFound(ex.Message);
            }
            return Ok();
        }

        [HttpDelete("{key}")]
        [EnableQuery]
        public async Task<IActionResult> Delete([FromODataUri] int key)
        {
            try
            {
                await _cartRepository.DeleteCart(key);

            }catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok();
        }

        [HttpPost("delete-all-cart")]
        [EnableQuery]
        public async Task<IActionResult> PostDelete([FromBody] List<DeleteCartDTO> carts)
        {
            try
            {
                List<Cart> list =  _mapper.Map<List<Cart>>(carts);
                await _cartRepository.DeleteAll(list);
                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
