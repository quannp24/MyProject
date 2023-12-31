using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using QuizAndFriends.Middleware;
using QuizArenaBE.Entity.Common;
using QuizArenaBE.Entity.Payment;
using QuizArenaBE.Hub;
using QuizArenaBE.Services.JWT;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddCors(options =>
{
    options.AddPolicy("CorsPolicy", builder => builder
        .WithOrigins("http://localhost:4200")
        .AllowAnyMethod()
        .AllowAnyHeader()
        .AllowCredentials());
});

builder.Services.AddControllers();
builder.Services.Configure<MomoOptionModel>(builder.Configuration.GetSection("MomoAPI"));
// Thêm JWT Middleware
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        // Đọc cài đặt JWT từ appsettings.json
        var jwtSettings = builder.Configuration.GetSection("JwtSettings").Get<JwtSettings>();

        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(jwtSettings.Secret)),
            ValidateIssuer = false,
            ValidateAudience = false,
            ClockSkew = TimeSpan.Zero
        };
    });
builder.Services.AddMiddleware();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddSignalR();


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsEnvironment("BeHung") 
    || app.Environment.IsEnvironment("BeLfar") 
    || app.Environment.IsEnvironment("BeMuld")
    || app.Environment.IsEnvironment("FeQuan")
    || app.Environment.IsEnvironment("FeThai")
    || app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Sử dụng xác thực JWT
app.UseMiddleware<JwtMiddleware>();
app.UseAuthentication();

app.UseCors("CorsPolicy");

app.UseAuthorization();

app.MapControllers();
app.MapHub<DoQuizHub>("/doquizhub");

app.Run();
