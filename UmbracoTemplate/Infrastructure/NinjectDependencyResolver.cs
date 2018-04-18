using System;
using System.Collections.Generic;
using Ninject;
using System.Web.Mvc;
using Ninject.Web.Common;
using Umbraco.Web;
using UmbracoTemplate.Services.Abstracts;
using UmbracoTemplate.Services.Implements;

namespace UmbracoTemplate.Infrastructure
{
    public class NinjectDependencyResolver : IDependencyResolver
    {
        private IKernel _kernel;

        public NinjectDependencyResolver(IKernel kernelParam)
        {
            _kernel = kernelParam;
            AddBindings();
        }

        public object GetService(Type serviceType)
        {
            return _kernel.TryGet(serviceType);
        }

        public IEnumerable<object> GetServices(Type serviceType)
        {
            return _kernel.GetAll(serviceType);
        }

        private void AddBindings()
        {
            _kernel.Bind<UmbracoHelper>().ToConstructor(m => new UmbracoHelper(UmbracoContext.Current))
                .InSingletonScope();
            _kernel.Bind(typeof(IDataService<>)).To(typeof(MultiSiteDataService<>)).InRequestScope();
            _kernel.Bind<IEmailSender>().To<EmailSender>().InRequestScope();
        }
    }
}