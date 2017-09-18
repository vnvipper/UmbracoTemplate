//------------------------------------------------------------------------------
// <auto-generated>
//   This code was generated by a tool.
//
//    Umbraco.ModelsBuilder v3.0.7.99
//
//   Changes to this file will be lost if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Web;
using Umbraco.Core.Models;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using Umbraco.ModelsBuilder;
using Umbraco.ModelsBuilder.Umbraco;

namespace UmbracoTemplate.Models
{
	/// <summary>Forgot Password</summary>
	[PublishedContentModel("forgotPassword")]
	public partial class ForgotPassword : PublishedContentModel, INavigationControls
	{
#pragma warning disable 0109 // new is redundant
		public new const string ModelTypeAlias = "forgotPassword";
		public new const PublishedItemType ModelItemType = PublishedItemType.Content;
#pragma warning restore 0109

		public ForgotPassword(IPublishedContent content)
			: base(content)
		{ }

#pragma warning disable 0109 // new is redundant
		public new static PublishedContentType GetModelContentType()
		{
			return PublishedContentType.Get(ModelItemType, ModelTypeAlias);
		}
#pragma warning restore 0109

		public static PublishedPropertyType GetModelPropertyType<TValue>(Expression<Func<ForgotPassword, TValue>> selector)
		{
			return PublishedContentModelUtility.GetModelPropertyType(GetModelContentType(), selector);
		}

		///<summary>
		/// Browser Title
		///</summary>
		[ImplementPropertyType("browserTitle")]
		public string BrowserTitle
		{
			get { return UmbracoTemplate.Models.NavigationControls.GetBrowserTitle(this); }
		}

		///<summary>
		/// Exclude From Top Navigation
		///</summary>
		[ImplementPropertyType("excludeFromTopNavigation")]
		public bool ExcludeFromTopNavigation
		{
			get { return UmbracoTemplate.Models.NavigationControls.GetExcludeFromTopNavigation(this); }
		}

		///<summary>
		/// Keywords: Keywords that describe the content of the page. This is consired optional since most modern search engines don't use this anymore
		///</summary>
		[ImplementPropertyType("keywords")]
		public IEnumerable<string> Keywords
		{
			get { return UmbracoTemplate.Models.NavigationControls.GetKeywords(this); }
		}

		///<summary>
		/// Description: A brief description of the content on your page. This text is shown below the title in a google search result and also used for Social Sharing Cards. The ideal length is between 130 and 155 characters
		///</summary>
		[ImplementPropertyType("seoMetaDescription")]
		public string SeoMetaDescription
		{
			get { return UmbracoTemplate.Models.NavigationControls.GetSeoMetaDescription(this); }
		}

		///<summary>
		/// Social Image Sharing
		///</summary>
		[ImplementPropertyType("socialImageSharing")]
		public IPublishedContent SocialImageSharing
		{
			get { return UmbracoTemplate.Models.NavigationControls.GetSocialImageSharing(this); }
		}
	}
}
