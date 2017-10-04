using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Archetype.Models;
using AutoMapper;
using Umbraco.Core.Models;
using Umbraco.Web;
using UmbracoTemplate.Models.Entities;

namespace UmbracoTemplate
{
    public partial class Global : UmbracoApplication
    {
        protected override void OnApplicationStarted(object sender, EventArgs e)
        {
            base.OnApplicationStarted(sender, e);
            // Custom mapper and interesting thing here

            Mapper.CreateMap<ArchetypeFieldsetModel, HeroImage>()
                .ForMember(dest => dest.Image,
                    opt => opt.MapFrom(src => src.GetValue<IPublishedContent>("sliderImage").Url))
                .ForMember(dest => dest.Heading, opt => opt.MapFrom(src => src.GetValue<string>("sliderHeading")))
                .ForMember(dest => dest.Subheading,
                    opt => opt.MapFrom(src => src.GetValue<string>("sliderSubheading")))
                .ForMember(dest => dest.ButtonText,
                    opt => opt.MapFrom(src => src.GetValue<string>("sliderButtonText")))
                .ForMember(dest => dest.Link, opt => opt.MapFrom(src => src.GetValue<string>("sliderLink")));

        }
    }
}