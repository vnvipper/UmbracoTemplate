using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Threading;
using Umbraco.Core.Models;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Services.Implements
{
    public class MultiSiteDataService<T> : IDataService<T> where T : PublishedContentModel
    {
        private readonly UmbracoHelper _umbracoHelper;

        public MultiSiteDataService(UmbracoHelper umbracoHelper)
        {
            _umbracoHelper = umbracoHelper;
        }

        public IEnumerable<T> GetAll(Func<T, bool> filter = null)
        {
            var currentCulture = Thread.CurrentThread.CurrentCulture.Name;
            var datas = _umbracoHelper.TypedContentAtRoot()
                .DescendantsOrSelf(GetAliasFrom(typeof(T)))               
                .Select(CreateDocument);

            if (filter != null)
            {
                datas = datas.Where(filter);
            }
            return datas;
        }

        public T Get(Func<T, bool> filter = null)
        {
            return GetAll(filter).FirstOrDefault();
        }

        public IEnumerable<T> GetAllByCurrentCulture(Func<T, bool> filter = null)
        {
            var currentCulture = Thread.CurrentThread.CurrentCulture.Name;
            var datas = GetAll(filter).Where(m =>
                m.GetCulture().Name.Equals(currentCulture, StringComparison.OrdinalIgnoreCase));         
            return datas;
        }

        public T GetByCurrentCulture(Func<T, bool> filter = null)
        {
           return GetAllByCurrentCulture(filter).FirstOrDefault();
        }

        private T CreateDocument(IPublishedContent content)
        {
            return (T)Activator.CreateInstance(typeof(T), new object[] { content });
        }

        private string GetAliasFrom(Type t)
        {
            PublishedContentModelAttribute attribute =
                (PublishedContentModelAttribute)Attribute.GetCustomAttribute(t,
                    typeof(PublishedContentModelAttribute));
            return attribute.ContentTypeAlias;
        }
    }
}