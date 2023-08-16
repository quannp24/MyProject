using BusinessObject;
using DataAccess.IRepository;
using DataAccess.Repository;
using GflowerAPI.DTO;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.OData.Formatter;
using Microsoft.AspNetCore.OData.Query;
using Microsoft.AspNetCore.OData.Routing.Controllers;
using Microsoft.EntityFrameworkCore;
using System;

namespace GflowerAPI.Controllers
{
	[Route("api/[controller]")]
	public class ProductController : ODataController
	{
		private readonly IProductRepository _productRepository;

		public ProductController(IProductRepository productRepository, GFlowersContext dbContext)
		{
			_productRepository = productRepository;
			dbContext.ChangeTracker.QueryTrackingBehavior = Microsoft.EntityFrameworkCore.QueryTrackingBehavior.NoTracking;
		}

		[HttpGet]
		[EnableQuery]
		public async Task<IActionResult> Get()
		{
            var pro = await _productRepository.GetProducts();

            return Ok(pro);
		}

		[HttpGet("product-best-sale")]
		[EnableQuery]
		public async Task<IActionResult> GetProductBestSale()
		{
			var product = await _productRepository.GetProductBestSale();
			if (product != null)
			{
				return Ok(product);
			}
			else
			{
				return NotFound();
			}
        }

        [Authorize]
        [HttpGet("products-admin")]
        [EnableQuery]
        public async Task<IActionResult> GetAdmin()
        {
            return Ok(await _productRepository.GetProductsAdmin());
        }

        [HttpGet("{key}")]
		[EnableQuery]
		public async Task<IActionResult> Get([FromODataUri] int key)
		{
			return Ok(await _productRepository.GetProduct(key));
		}

		[Authorize]
        [HttpPost]
        [EnableQuery]
        public async Task<IActionResult> Post([FromBody] AddProductDTO product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest();
            }
            Product raw_product = new Product
            {
                ProductName = product.ProductName,
				ProductDescription= string.IsNullOrEmpty(product.ProductDescription) ? null : product.ProductDescription,
				ProductPrice = product.ProductPrice,
				ProductImage = product.ProductImage,
				Status = product.Status,
				Discount = product.Discount

            };
			try
			{
				var productAdd = await _productRepository.AddProduct(raw_product);
				return Ok(productAdd);

            }catch(Exception ex)
			{
				return BadRequest(ex.Message);
			}
        }

		[Authorize]
        [HttpPut]
        [EnableQuery]
        public async Task<IActionResult> Put([FromBody] ProductDTO product)
        {
            Product raw_product = new Product
            {
                ProductName = product.ProductName,
                ProductId = product.ProductId,
                ProductDescription = string.IsNullOrEmpty(product.ProductDescription) ? null : product.ProductDescription,
                ProductPrice = product.ProductPrice,
                ProductImage = product.ProductImage,
                Status = product.Status,
                Discount = product.Discount
            };
            try
            {
                await _productRepository.UpdateProduct(raw_product);
            }
            catch (Exception ex)
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
                await _productRepository.RemoveProduct(key);

            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return Ok();
        }
    }
}
