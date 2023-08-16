using BusinessObject;

namespace GflowerAPI.DTO
{
	public class CartRequestDTO
	{
		public int CartId { get; set; }
		public int AccountId { get; set; }
		public int ProductId { get; set; }
		public int Quantity { get; set; }
		public decimal TotalPrice { get; set; }
		public int Status { get; set; }
	}
}
