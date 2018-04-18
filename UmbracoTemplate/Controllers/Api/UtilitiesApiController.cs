using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using Umbraco.Web.Editors;
using Umbraco.Web.Mvc;
using UmbracoTemplate.Infrastructure;

namespace UmbracoTemplate.Controllers.Api
{
    [PluginController("UmbracoUtilities")]
    public class UtilitiesApiController : UmbracoAuthorizedJsonController
    {
        public bool CreateConstants()
        {

            var dictionaries = GetDictionaryItems();
            string filePath = HttpContext.Current.Server.MapPath("~/Infrastructure/DictionaryConstants.cs");
            FileInfo fi = new FileInfo(filePath);
            //open file for write operation
            FileStream fsToWrite = fi.Open(FileMode.OpenOrCreate, FileAccess.ReadWrite, FileShare.ReadWrite);
            //get the StreamWriter
            StreamWriter sw = new StreamWriter(fsToWrite);

            StringBuilder content = new StringBuilder();
            content.AppendLine($"using System;" +
                               $"\r\nusing System.Collections.Generic;" +
                               $"\r\nusing System.Linq;" +
                               $"\r\nusing System.Web;");
            content.AppendLine("namespace UmbracoTemplate.Infrastructure");
            content.AppendLine("{");

            content.AppendLine($"\tpublic static class DictionaryConstants");
            content.AppendLine("\t{");

            foreach (var dictionary in dictionaries)
            {
                content.AppendLine(
                    $"\t\tpublic const string {dictionary.ToUpper().Replace(" ", "_")} = \"{dictionary}\";");
            }
            content.AppendLine("\t}");

            content.AppendLine("}");


            //write some text using StreamWriter
            sw.WriteLine(content.ToString());
            sw.Close();
            fsToWrite.Close();

            return true;
        }

        private IEnumerable<string> GetDictionaryItems()
        {
            //For now, we're only going to get the English items

            var dictionary = new List<string>();

            var root = ApplicationContext.Services.LocalizationService.GetRootDictionaryItems();

            if (!root.Any())
            {
                return Enumerable.Empty<string>();
            }

            foreach (var item in root)
            {
                dictionary.Add(item.ItemKey);

                dictionary.AddRange(LoopThroughDictionaryChildren(item.Key));
            }

            return dictionary;
        }

        private IEnumerable<string> LoopThroughDictionaryChildren(Guid key)
        {
            var dictionary = new List<string>();
            var items = Services.LocalizationService.GetDictionaryItemChildren(key);

            if (!items.Any())
            {
                return Enumerable.Empty<string>();
            }

            foreach (var subItem in items)
            {
                dictionary.Add(subItem.ItemKey);

                dictionary.AddRange(LoopThroughDictionaryChildren(subItem.Key));
            }

            return dictionary;
        }
    }
}