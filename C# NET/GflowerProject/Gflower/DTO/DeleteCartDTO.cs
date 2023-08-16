namespace Gflower.DTO
{
    public class DeleteCartDTO
    {
        public int CartId { get; set; }
        public int AccountId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public decimal TotalPrice { get; set; }
    }
}
