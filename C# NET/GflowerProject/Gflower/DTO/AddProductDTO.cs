namespace Gflower.DTO
{
    public class AddProductDTO
    {
        public string ProductName { get; set; }
        public string ProductDescription { get; set; }
        public decimal ProductPrice { get; set; }
        public string ProductImage { get; set; }
        public int Status { get; set; }
        public int Discount { get; set; }
    }
}
