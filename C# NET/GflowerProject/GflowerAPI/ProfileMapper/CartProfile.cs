using AutoMapper;
using BusinessObject;
using GflowerAPI.DTO;

namespace GflowerAPI.ProfileMapper
{
    public class CartProfile: Profile
    {
        public CartProfile()
        {
            //CreateMap<Cart, CartResponseDTO>()
            //.ForMember(dest => dest.Product, opt => opt.MapFrom(src => src.Product));
            CreateMap<Product, ProductDTO>();
            CreateMap<OrderDetailRequestDTO, OrderDetail>();
            CreateMap<DeleteCartDTO, Cart>();
        }
    }
}
