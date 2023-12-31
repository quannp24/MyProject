namespace QuizArenaBE.Services.Common
{
    public interface ICommon
    {
        public Task<bool> SendMail(string emailTo, string Subject, string Body);

        public Task<bool> SendMailMany(List<string> emailTo, string Subject, string Body);
    }
}
