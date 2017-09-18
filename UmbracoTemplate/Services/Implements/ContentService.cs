using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Umbraco.Core.Models;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using UmbracoTemplate.Services.Abstracts;

namespace UmbracoTemplate.Services.Implements
{
    public class ContentService<T> : IDataService<T> where T : PublishedContentModel
    {
        private readonly UmbracoHelper _umbracoHelper;

        public ContentService(UmbracoHelper umbracoHelper)
        {
            _umbracoHelper = umbracoHelper;
        }

        public IEnumerable<T> GetAll(Func<T, bool> filter = null)
        {
            var datas = _umbracoHelper.TypedContentAtRoot()
                .DescendantsOrSelf(GetAliasFrom(typeof(T))).Select(CreateDocument);
            return datas;
        }

        public T Get(Func<T, bool> filter = null)
        {
           return GetAll().FirstOrDefault();
        }

        public IEnumerable<T> GetAllByCurrentCulture(Func<T, bool> filter = null)
        {
            throw new NotImplementedException();
        }

        public T GetByCurrentCulture(Func<T, bool> filter = null)
        {
            throw new NotImplementedException();
        }

        private T CreateDocument(IPublishedContent content)
        {
            return (T)Activator.CreateInstance(typeof(T), new object[] { content });
        }

        private string GetAliasFrom(Type t)
        {
            PublishedContentModelAttribute attribute =
                (PublishedContentModelAttribute) Attribute.GetCustomAttribute(t,
                    typeof(PublishedContentModelAttribute));
            return attribute.ContentTypeAlias;
        }
    }
}