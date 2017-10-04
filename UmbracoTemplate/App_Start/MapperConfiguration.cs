using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Archetype.Models;
using AutoMapper;
using Umbraco.Core.Models;
using UmbracoTemplate.Models.Entities;

namespace UmbracoTemplate.App_Start
{
    public class MapperConfiguration
    {
        public static void Setup()
        {
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