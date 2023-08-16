using BusinessObject;

namespace GflowerAPI.DTO
{
    public class CartUpdateQuantityDTO
    {
        public bool IsPlus { get; set; }
        public virtual Cart CartUpdate { get; set; } = null!;
    }
}
