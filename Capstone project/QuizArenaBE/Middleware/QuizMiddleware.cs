using QuizAndFriends.Services.Common;
using QuizArenaBE.Repository.Hub;
using QuizArenaBE.Repository.SRC001;
using QuizArenaBE.Repository.SRC002;
using QuizArenaBE.Repository.SRC003;
using QuizArenaBE.Services.Common;
using QuizArenaBE.Services.JWT;
using QuizArenaBE.Services.Payment;
using QuizArenaBE.Services.SRC001;
using QuizArenaBE.Services.SRC002;
using QuizArenaBE.Services.SRC003;

namespace QuizAndFriends.Middleware
{
    public static class QuizMiddleware
    {
        public static void AddMiddleware(this IServiceCollection services)
        {
            services.AddTransient<ICommon, Common>();
            services.AddTransient<ICRUDcommon, CRUDcommon>();

            //Service
            services.AddTransient<IUserService, UserService>();
            services.AddTransient<IQuizService, QuizService>();
            services.AddTransient<IDashboardService, DashboardService>();
            services.AddTransient<IPaymentService, PaymentService>();

            //Repository
            services.AddTransient<IUserRepository, UserRepository>();
            services.AddTransient<IQuizRepository, QuizRepository>();
            services.AddTransient<IDashboardRepository, DashboardRepository>();
            services.AddTransient<IHubRepostiory, HubRepostiory>();
            services.AddMemoryCache();

            services.AddCors(options =>
            {
                options.AddPolicy("AllowSpecificOrigin", builder =>
                {
                    builder.WithOrigins("http://localhost:4200")
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });
        }
    }
}
