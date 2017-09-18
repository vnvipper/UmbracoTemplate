using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Umbraco.Core.Models.PublishedContent;

namespace UmbracoTemplate.Services.Abstracts
{
    public interface IDataService<T> where T : PublishedContentModel
    {
        IEnumerable<T> GetAll(Func<T, bool> filter = null);
        T Get(Func<T, bool> filter = null);
        IEnumerable<T> GetAllByCurrentCulture(Func<T, bool> filter = null);
        T GetByCurrentCulture(Func<T, bool> filter = null);
    }
}
