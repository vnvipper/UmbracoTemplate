using System.Collections.Generic;
using Umbraco.Core.Models.PublishedContent;

namespace UmbracoTemplate.Services.Abstracts
{
    public interface IDataService<T> where T : PublishedContentModel
    {
        IEnumerable<T> GetAll();
        T Get();
    }
}
