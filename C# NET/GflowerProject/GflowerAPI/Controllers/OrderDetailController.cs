using AutoMapper;
using BusinessObject;
using DataAccess.IRepository;
using DataAccess.Repository;
using GflowerAPI.DTO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;

namespace GflowerAPI.Controllers
{
    [Route("api/[controller]")]
    public class OrderDetailController : ODataController
    {
        private readonly IOrderDetailRepository _odRepository;
        private readonly IMapper _mapper;

        public OrderDetailController(IOrderDetailRepository odRepository, GFlowersContext dbContext,IMapper mapper)
        {
            _odRepository = odRepository;
            _mapper = mapper;
            dbContext.ChangeTracker.QueryTrackingBehavior = Microsoft.EntityFrameworkCore.QueryTrackingBehavior.NoTracking;
        }

        [HttpPost]
        [EnableQuery]
        public async Task<IActionResult> Post([FromBody] List<OrderDetailRequestDTO> list)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            try
            {
                List<OrderDetail> listOD = _mapper.Map<List<OrderDetail>>(list);
                await _odRepository.AddListOrder(listOD);
            }catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok();

        }
    }
}
