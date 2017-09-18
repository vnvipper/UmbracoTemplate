using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Umbraco.Core.Logging;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Services.Implements
{
    public class EmailSender : IEmailSender
    {
        public bool SendMail(string to, string subject, string body, Stream attachment = null, string fileName = null,
            string fileType = null)
        {
            try
            {
                using (System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient())
                {
                    System.Net.Mail.Attachment att = null;
                    if (attachment != null)
                    {
                        att = new System.Net.Mail.Attachment(attachment, fileName, fileType);
                    }

                    using (System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage())
                    {
                        var view = System.Net.Mail.AlternateView.CreateAlternateViewFromString(body, Encoding.UTF8,
                            "text/html");
                        msg.AlternateViews.Add(view);
                        msg.IsBodyHtml = true;
                        msg.SubjectEncoding = Encoding.UTF8;
                        msg.BodyEncoding = Encoding.UTF8;
                        msg.Subject = subject;
                        msg.Body = body;
                        msg.DeliveryNotificationOptions = System.Net.Mail.DeliveryNotificationOptions.OnSuccess;
                        if (att != null)
                            msg.Attachments.Add(att);
                        msg.To.Add(to);
                        client.Send(msg);
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                LogHelper.Error(MethodBase.GetCurrentMethod().DeclaringType, ex.Message, ex);
                return false;
            }
        }

        public async Task<bool> SendMailAsync(string to, string subject, string body, Stream attachment = null, string fileName = null,
            string fileType = null)
        {
            try
            {
                using (System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient())
                {
                    System.Net.Mail.Attachment att = null;
                    if (attachment != null)
                    {
                        att = new System.Net.Mail.Attachment(attachment, fileName, fileType);
                    }

                    using (System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage())
                    {
                        var view = System.Net.Mail.AlternateView.CreateAlternateViewFromString(body, Encoding.UTF8,
                            "text/html");
                        msg.AlternateViews.Add(view);
                        msg.IsBodyHtml = true;
                        msg.SubjectEncoding = Encoding.UTF8;
                        msg.BodyEncoding = Encoding.UTF8;
                        msg.Subject = subject;
                        msg.Body = body;
                        msg.DeliveryNotificationOptions = System.Net.Mail.DeliveryNotificationOptions.OnSuccess;
                        if (att != null)
                            msg.Attachments.Add(att);
                        msg.To.Add(to);
                        await client.SendMailAsync(msg);
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                LogHelper.Error(MethodBase.GetCurrentMethod().DeclaringType, ex.Message, ex);
                return false;
            }
        }
    }
}