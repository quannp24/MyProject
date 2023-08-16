namespace Gflower.DTO
{
    public class CreateOrderRequestDTO
    {
        public int AccountId { get; set; }
        public DateTime OrderDate { get; set; }
        public int OrderStatus { get; set; }
        public string ShippingInfo { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
