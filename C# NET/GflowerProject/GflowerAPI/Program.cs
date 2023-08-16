using AutoMapper;
using BusinessObject;
using DataAccess.IRepository;
using DataAccess.Repository;
using EBookStoreWebAPI.Middleware;
using GflowerAPI.DTO;
using GflowerAPI.ProfileMapper;
using GflowerAPI.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.OData;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OData.Edm;
using Microsoft.OData.ModelBuilder;
using System.Text;


// Add services to the container.
static IEdmModel GetEdmModel()
{
    ODataConventionModelBuilder builder = new ODataConventionModelBuilder();
    builder.EntitySet<Cart>("Cart").EntityType.HasKey(a => a.CartId);
    builder.EntitySet<Order>("Order").EntityType.HasKey(a => a.OrderId);
    builder.EntitySet<OrderDetail>("OrderDetail").EntityType.HasKey(a => a.Id);
    builder.EntitySet<Product>("Product").EntityType.HasKey(a => a.ProductId);
    builder.EntitySet<Account>("Account").EntityType.HasKey(a => a.AccountId);
    return builder.GetEdmModel();
}

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContext<GFlowersContext>(options => options.UseSqlServer(
    builder.Configuration.GetConnectionString("GflowerDB")
));

builder.Services.AddAutoMapper(typeof(CartProfile));
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(x =>
{
    x.RequireHttpsMetadata = false;
    x.SaveToken = true;
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(builder.Configuration["AppSettings:Secret"])),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});
builder.Services.AddScoped<IAccountRepository, AccountRepository>();
builder.Services.AddScoped<IAuthenticationService, AuthenticationService>();
builder.Services.AddScoped<ICartRepository, CartRepository>();
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IOrderRepositoy, OrderRepository>();
builder.Services.AddScoped<IOrderDetailRepository, OrderDetailRepository>();


builder.Services.AddControllers().AddOData(options =>
{
    options.Select().Filter().Count().OrderBy().Expand().SetMaxTop(100);
    // B?t tính n?ng EnableQuery
    options.EnableQueryFeatures();

    // L?y routeOptions t? AddRouteComponents
    var routeOptions = options.AddRouteComponents("odata", GetEdmModel()).RouteOptions;
    //routeOptions.EnableQualifiedOperationCall = true;
    //routeOptions.EnableKeyAsSegment = true;
    //routeOptions.EnableKeyInParenthesis = true;

    // Ch? b?t tùy ch?n EnableKeyAsSegment và vô hi?u hóa EnableKeyInParenthesis
    routeOptions.EnableQualifiedOperationCall = true;
    routeOptions.EnableKeyAsSegment = true;
    routeOptions.EnableKeyInParenthesis = false;
});
builder.Services.AddCors();

builder.Services.Configure<AppSettings>(builder.Configuration.GetSection("AppSettings"));
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseCors(x
                => x.AllowAnyOrigin()
                .AllowAnyMethod()
                .AllowAnyHeader());

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseMiddleware<JwtMiddleware>();
app.UseODataBatching();
app.UseRouting();
app.UseAuthentication();

app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});
app.Run();
