using BusinessObject;
using DataAccess.IRepository;
using GflowerAPI.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Formatter;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;
using Microsoft.EntityFrameworkCore;

namespace GflowerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ODataController
    {
        private readonly IAccountRepository _accountRepository;

        public AccountController(IAccountRepository accountRepository, GFlowersContext dbContext)
        {
            _accountRepository = accountRepository;
            dbContext.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;

        }

        [Authorize]
        [HttpGet("{username}")]
        [EnableQuery]
        public IActionResult Get([FromODataUri] string username)
        {
            return Ok(_accountRepository.GetAccByUsername(username));
        }

        [HttpGet("checkUsername/{username}")]
        [EnableQuery]
        public IActionResult GetCheckUserName([FromODataUri] string username)
        {
            var acc = _accountRepository.GetAccByUsername(username);
            if(acc != null)
            {
                return Ok();
            }
            return NotFound();
        }

        [HttpPost]
        [EnableQuery]
        public IActionResult Post([FromBody] SignupRequestDTO acc)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            try
            {
                Account raw_acc = new Account
                {
                    Username = acc.Username,
                    LastName = acc.LastName,
                    FirstName = acc.FirstName,
                    Password = acc.Password,
                    Role = 2
                };
                _accountRepository.InsertAccount(raw_acc);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }

            return Ok();
        }
    }
}
