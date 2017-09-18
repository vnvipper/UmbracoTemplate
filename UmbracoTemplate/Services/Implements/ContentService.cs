using System;
using System.Collections.Generic;
using System.Linq;
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

        public IEnumerable<T> GetAll()
        {
            var datas = _umbracoHelper.TypedContentAtRoot()
                .DescendantsOrSelf(GetAliasFrom(typeof(T))).Select(CreateDocument);
            return datas;
        }

        public T Get()
        {
           return GetAll().FirstOrDefault();
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