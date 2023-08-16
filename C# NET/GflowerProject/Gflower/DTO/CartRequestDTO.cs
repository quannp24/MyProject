using BusinessObject;

namespace Gflower.DTO
{
	public class CartRequestDTO
	{
		public int CartId { get; set; }
		public int AccountId { get; set; }
		public int ProductId { get; set; }
		public int Quantity { get; set; }
		public decimal TotalPrice { get; set; }
		public int Status { get; set; }
		public virtual Product Product { get; set; } = null!;
	}
}
