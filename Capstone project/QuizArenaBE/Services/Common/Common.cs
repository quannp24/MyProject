using System.Net.Mail;
using System.Net;

namespace QuizArenaBE.Services.Common
{
    public class Common : ICommon
    {
        public Common()
        {

        }

        public async Task<bool> SendMail(string emailTo, string Subject, string Body)
        {
            try
            {
                // Thông tin SMTP server
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587; // Port của SMTP server (thường là 587 hoặc 465)
                string smtpUsername = "quizarenavn@gmail.com";
                string smtpPassword = "qbnr rdsh tfxy vcyx";

                // Tạo đối tượng MailMessage
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(smtpUsername);
                mail.To.Add(new MailAddress(emailTo));
                mail.Subject = Subject;
                mail.Body = Body;

                // Cấu hình SMTP client
                SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort);
                smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true; // Sử dụng SSL nếu SMTP server yêu cầu

                // Gửi email
                smtpClient.Send(mail);
                return true;
            }
            catch (Exception ex)
            {

                throw ex;
            }
           
        }

        public async Task<bool> SendMailMany(List<string> emailTo, string Subject, string Body)
        {
            try
            {
                // Thông tin SMTP server
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587; // Port của SMTP server (thường là 587 hoặc 465)
                string smtpUsername = "quizarenavn@gmail.com";
                string smtpPassword = "qbnr rdsh tfxy vcyx";

                // Tạo đối tượng MailMessage
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(smtpUsername);

                // Thêm các địa chỉ email người nhận
                foreach (string recipient in emailTo)
                {
                    mail.To.Add(new MailAddress(recipient));
                }

                mail.Subject = Subject;
                mail.Body = Body;

                // Cấu hình SMTP client
                SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort);
                smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true; // Sử dụng SSL nếu SMTP server yêu cầu

                // Gửi email
                smtpClient.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
