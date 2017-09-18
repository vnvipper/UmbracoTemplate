using System.Threading.Tasks;

namespace UmbracoTemplate.Services.Abstracts
{
    public interface IEmailSender
    {
        bool SendMail(string to, string subject, string body, System.IO.Stream attachment = null,
            string fileName = null, string fileType = null);

        Task<bool> SendMailAsync(string to, string subject, string body,
            System.IO.Stream attachment = null,
            string fileName = null, string fileType = null);
    }
}
