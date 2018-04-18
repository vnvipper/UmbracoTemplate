using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Archetype.Models;
using AutoMapper;
using Umbraco.Core.Models;
using UmbracoTemplate.Models;
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
                .ForMember(dest => dest.Link, opt => opt.MapFrom(src => src.GetValue<RJP.MultiUrlPicker.Models.Link>("sliderLink").Url));

            Mapper.CreateMap<Post, Article>()
                .ForMember(dest => dest.Title,
                    opt => opt.MapFrom(src => src.PostTitle))
                .ForMember(dest => dest.Creator,
                    opt => opt.MapFrom(src => src.CreatorName))
                .ForMember(dest => dest.Category,
                    opt => opt.MapFrom(src => src.Parent.Name))
                .ForMember(dest => dest.Tags,
                    opt => opt.MapFrom(src => src.PostTags))
                .ForMember(dest => dest.PostedDate,
                    opt => opt.MapFrom(src => src.PostedDate != default(DateTime) ? src.PostedDate : src.CreateDate))
                .ForMember(dest => dest.Description,
                    opt => opt.MapFrom(src => src.PostDescription))
                .ForMember(dest => dest.Content,
                    opt => opt.MapFrom(src => src.PostContent))
                .ForMember(dest => dest.FeaturedImage,
                    opt => opt.MapFrom(src => src.FeaturedImage))
                .ForMember(dest => dest.Url,
                    opt => opt.MapFrom(src => src.Url));
        }
    }
}