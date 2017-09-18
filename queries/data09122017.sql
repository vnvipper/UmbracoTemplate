USE [master]
GO
/****** Object:  Database [UmbracoTemplate]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE DATABASE [UmbracoTemplate]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UmbracoTemplate', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\UmbracoTemplate.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UmbracoTemplate_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\UmbracoTemplate_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [UmbracoTemplate] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UmbracoTemplate].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UmbracoTemplate] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET ARITHABORT OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UmbracoTemplate] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UmbracoTemplate] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UmbracoTemplate] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UmbracoTemplate] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET RECOVERY FULL 
GO
ALTER DATABASE [UmbracoTemplate] SET  MULTI_USER 
GO
ALTER DATABASE [UmbracoTemplate] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UmbracoTemplate] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UmbracoTemplate] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UmbracoTemplate] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [UmbracoTemplate] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'UmbracoTemplate', N'ON'
GO
USE [UmbracoTemplate]
GO
/****** Object:  Table [dbo].[cmsContent]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[contentType] [int] NOT NULL,
 CONSTRAINT [PK_cmsContent] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[thumbnail] [nvarchar](255) NOT NULL CONSTRAINT [DF_cmsContentType_thumbnail]  DEFAULT ('folder.png'),
	[description] [nvarchar](1500) NULL,
	[isContainer] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_isContainer]  DEFAULT ('0'),
	[allowAtRoot] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_allowAtRoot]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType2ContentType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType2ContentType](
	[parentContentTypeId] [int] NOT NULL,
	[childContentTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsContentType2ContentType] PRIMARY KEY CLUSTERED 
(
	[parentContentTypeId] ASC,
	[childContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentTypeAllowedContentType](
	[Id] [int] NOT NULL,
	[AllowedId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL CONSTRAINT [df_cmsContentTypeAllowedContentType_sortOrder]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AllowedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentVersion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[VersionDate] [datetime] NOT NULL CONSTRAINT [DF_cmsContentVersion_VersionDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentXml](
	[nodeId] [int] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[propertyEditorAlias] [nvarchar](255) NOT NULL,
	[dbType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_cmsDataType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataTypePreValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datatypeNodeId] [int] NOT NULL,
	[value] [ntext] NULL,
	[sortorder] [int] NOT NULL,
	[alias] [nvarchar](50) NULL,
 CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDictionary](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[parent] [uniqueidentifier] NULL,
	[key] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsDictionary] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocument](
	[nodeId] [int] NOT NULL,
	[published] [bit] NOT NULL,
	[documentUser] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[releaseDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_cmsDocument_updateDate]  DEFAULT (getdate()),
	[templateId] [int] NULL,
	[newest] [bit] NOT NULL CONSTRAINT [DF_cmsDocument_newest]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocument] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocumentType](
	[contentTypeNodeId] [int] NOT NULL,
	[templateNodeId] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_cmsDocumentType_IsDefault]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY CLUSTERED 
(
	[contentTypeNodeId] ASC,
	[templateNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsLanguageText](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[languageId] [int] NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uniqueId] [uniqueidentifier] NOT NULL,
	[macroUseInEditor] [bit] NOT NULL,
	[macroRefreshRate] [int] NOT NULL,
	[macroAlias] [nvarchar](255) NOT NULL,
	[macroName] [nvarchar](255) NULL,
	[macroScriptType] [nvarchar](255) NULL,
	[macroScriptAssembly] [nvarchar](255) NULL,
	[macroXSLT] [nvarchar](255) NULL,
	[macroCacheByPage] [bit] NOT NULL,
	[macroCachePersonalized] [bit] NOT NULL,
	[macroDontRender] [bit] NOT NULL,
	[macroPython] [nvarchar](255) NULL,
 CONSTRAINT [PK_cmsMacro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacroProperty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uniquePropertyId] [uniqueidentifier] NOT NULL,
	[editorAlias] [nvarchar](255) NOT NULL,
	[macro] [int] NOT NULL,
	[macroPropertySortOrder] [int] NOT NULL,
	[macroPropertyAlias] [nvarchar](50) NOT NULL,
	[macroPropertyName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember](
	[nodeId] [int] NOT NULL,
	[Email] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_Email]  DEFAULT (''''),
	[LoginName] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_LoginName]  DEFAULT (''''),
	[Password] [nvarchar](1000) NOT NULL CONSTRAINT [DF_cmsMember_Password]  DEFAULT (''''),
 CONSTRAINT [PK_cmsMember] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember2MemberGroup](
	[Member] [int] NOT NULL,
	[MemberGroup] [int] NOT NULL,
 CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY CLUSTERED 
(
	[Member] ASC,
	[MemberGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMemberType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[propertytypeId] [int] NOT NULL,
	[memberCanEdit] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_memberCanEdit]  DEFAULT ('0'),
	[viewOnProfile] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_viewOnProfile]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsMemberType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPreviewXml](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentNodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NULL,
	[propertytypeid] [int] NOT NULL,
	[dataInt] [int] NULL,
	[dataDecimal] [decimal](38, 6) NULL,
	[dataDate] [datetime] NULL,
	[dataNvarchar] [nvarchar](500) NULL,
	[dataNtext] [ntext] NULL,
 CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dataTypeId] [int] NOT NULL,
	[contentTypeId] [int] NOT NULL,
	[propertyTypeGroupId] [int] NULL,
	[Alias] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[sortOrder] [int] NOT NULL CONSTRAINT [DF_cmsPropertyType_sortOrder]  DEFAULT ('0'),
	[mandatory] [bit] NOT NULL CONSTRAINT [DF_cmsPropertyType_mandatory]  DEFAULT ('0'),
	[validationRegExp] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
	[UniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyType_UniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyTypeGroup]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyTypeGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contenttypeNodeId] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[sortorder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyTypeGroup_uniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTagRelationship](
	[nodeId] [int] NOT NULL,
	[tagId] [int] NOT NULL,
	[propertyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[propertyTypeId] ASC,
	[tagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTags]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[group] [nvarchar](100) NULL,
 CONSTRAINT [PK_cmsTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTask]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTask](
	[closed] [bit] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskTypeId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[parentUserId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_cmsTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTaskType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsTaskType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTemplate](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](100) NULL,
	[design] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsTemplate] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExternalLogins]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExternalLogins](
	[ExternalLoginId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[LoginProvider] [nvarchar](4000) NOT NULL,
	[ProviderKey] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_ExternalLoginId] PRIMARY KEY CLUSTERED 
(
	[ExternalLoginId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccess]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccess](
	[id] [uniqueidentifier] NOT NULL,
	[nodeId] [int] NOT NULL,
	[loginNodeId] [int] NOT NULL,
	[noAccessNodeId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccess] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccessRule]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccessRule](
	[id] [uniqueidentifier] NOT NULL,
	[accessId] [uniqueidentifier] NOT NULL,
	[ruleValue] [nvarchar](255) NOT NULL,
	[ruleType] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoCacheInstruction]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoCacheInstruction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[utcStamp] [datetime] NOT NULL,
	[jsonInstruction] [ntext] NOT NULL,
	[originated] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDomains](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[domainDefaultLanguage] [int] NULL,
	[domainRootStructureID] [int] NULL,
	[domainName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoDomains] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoExternalLogin]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoExternalLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[loginProvider] [nvarchar](4000) NOT NULL,
	[providerKey] [nvarchar](4000) NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLanguage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[languageISOCode] [nvarchar](10) NULL,
	[languageCultureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLock]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLock](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[value] [int] NOT NULL,
	[name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_umbracoLock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[Datestamp] [datetime] NOT NULL CONSTRAINT [DF_umbracoLog_Datestamp]  DEFAULT (getdate()),
	[logHeader] [nvarchar](50) NOT NULL,
	[logComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_umbracoLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoMigration]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoMigration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoMigration_createDate]  DEFAULT (getdate()),
	[version] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_umbracoMigration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trashed] [bit] NOT NULL CONSTRAINT [DF_umbracoNode_trashed]  DEFAULT ('0'),
	[parentID] [int] NOT NULL,
	[nodeUser] [int] NULL,
	[level] [int] NOT NULL,
	[path] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_umbracoNode_uniqueID]  DEFAULT (newid()),
	[text] [nvarchar](255) NULL,
	[nodeObjectType] [uniqueidentifier] NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoNode_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRedirectUrl]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRedirectUrl](
	[id] [uniqueidentifier] NOT NULL,
	[contentKey] [uniqueidentifier] NOT NULL,
	[createDateUtc] [datetime] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[urlHash] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_umbracoRedirectUrl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NOT NULL,
	[childId] [int] NOT NULL,
	[relType] [int] NOT NULL,
	[datetime] [datetime] NOT NULL CONSTRAINT [DF_umbracoRelation_datetime]  DEFAULT (getdate()),
	[comment] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_umbracoRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelationType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[typeUniqueId] [uniqueidentifier] NOT NULL,
	[dual] [bit] NOT NULL,
	[parentObjectType] [uniqueidentifier] NOT NULL,
	[childObjectType] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoServer]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoServer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[computerName] [nvarchar](255) NOT NULL,
	[registeredDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoServer_registeredDate]  DEFAULT (getdate()),
	[lastNotifiedDate] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isMaster] [bit] NOT NULL,
 CONSTRAINT [PK_umbracoServer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userDisabled] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userDisabled]  DEFAULT ('0'),
	[userNoConsole] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userNoConsole]  DEFAULT ('0'),
	[userType] [int] NOT NULL,
	[startStructureID] [int] NOT NULL,
	[startMediaID] [int] NULL,
	[userName] [nvarchar](255) NOT NULL,
	[userLogin] [nvarchar](125) NOT NULL,
	[userPassword] [nvarchar](500) NOT NULL,
	[userEmail] [nvarchar](255) NOT NULL,
	[userLanguage] [nvarchar](10) NULL,
	[securityStampToken] [nvarchar](255) NULL,
	[failedLoginAttempts] [int] NULL,
	[lastLockoutDate] [datetime] NULL,
	[lastPasswordChangeDate] [datetime] NULL,
	[lastLoginDate] [datetime] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2app]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2app](
	[user] [int] NOT NULL,
	[app] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_user2app] PRIMARY KEY CLUSTERED 
(
	[user] ASC,
	[app] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodeNotify](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[action] [nchar](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodePermission]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodePermission](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[permission] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodePermission] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserType]    Script Date: 9/18/2017 10:32:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userTypeAlias] [nvarchar](50) NULL,
	[userTypeName] [nvarchar](255) NOT NULL,
	[userTypeDefaultPermissions] [nvarchar](50) NULL,
 CONSTRAINT [PK_umbracoUserType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[cmsContent] ON 

INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (4, 1066, 1057)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (25, 1128, 1123)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (26, 1129, 1125)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (27, 1130, 1124)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (28, 1131, 1126)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (29, 1132, 1127)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (30, 1134, 1133)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (39, 1145, 1144)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (40, 1148, 1147)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (45, 1155, 1153)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (47, 1157, 1044)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (48, 1158, 1123)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (49, 1159, 1125)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (50, 1160, 1126)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (51, 1161, 1127)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (52, 1162, 1133)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (53, 1163, 1144)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (54, 1164, 1147)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (55, 1165, 1153)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (56, 1166, 1124)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (57, 1167, 1057)
SET IDENTITY_INSERT [dbo].[cmsContent] OFF
SET IDENTITY_INSERT [dbo].[cmsContentType] ON 

INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (531, 1044, N'Member', N'icon-user', N'icon-user', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (532, 1031, N'Folder', N'icon-folder', N'icon-folder', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (533, 1032, N'Image', N'icon-picture', N'icon-picture', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (534, 1033, N'File', N'icon-document', N'icon-document', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (537, 1057, N'settings', N'icon-umb-developer color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (556, 1122, N'navigationControls', N'icon-nodes color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (557, 1123, N'home', N'icon-globe color-red', N'folder.png', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (558, 1124, N'contact', N'icon-message color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (559, 1125, N'account', N'icon-users color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (560, 1126, N'login', N'icon-user-glasses color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (561, 1127, N'register', N'icon-keychain color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (562, 1133, N'confirmEmail', N'icon-check color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (563, 1144, N'forgotPassword', N'icon-add color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (564, 1147, N'resetPassword', N'icon-sync color-red', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (565, 1153, N'externalLoginConfirmation', N'icon-sitemap color-red', N'folder.png', NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[cmsContentType] OFF
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1057)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1123)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1124)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1125)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1126)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1127)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1133)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1144)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1147)
INSERT [dbo].[cmsContentType2ContentType] ([parentContentTypeId], [childContentTypeId]) VALUES (1122, 1153)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1031, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1032, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1033, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1123, 1057, 2)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1123, 1124, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1123, 1125, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1126, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1127, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1133, 2)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1144, 3)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1147, 4)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1125, 1153, 5)
SET IDENTITY_INSERT [dbo].[cmsContentVersion] ON 

INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (9, 1066, N'e25ca576-8c69-4924-a022-30200d722831', CAST(N'2017-09-05 10:04:41.567' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (10, 1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', CAST(N'2017-09-05 10:40:06.823' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (58, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', CAST(N'2017-09-10 23:34:24.987' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (59, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', CAST(N'2017-09-10 23:35:27.397' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (60, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', CAST(N'2017-09-10 23:35:47.027' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (61, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', CAST(N'2017-09-10 23:35:59.873' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (62, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', CAST(N'2017-09-10 23:37:13.010' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (63, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', CAST(N'2017-09-10 23:37:22.200' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (64, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', CAST(N'2017-09-10 23:38:58.157' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (73, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', CAST(N'2017-09-11 08:44:53.387' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (74, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', CAST(N'2017-09-11 09:08:13.363' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (79, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', CAST(N'2017-09-12 11:59:50.220' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (81, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', CAST(N'2017-09-12 14:02:03.920' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (82, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', CAST(N'2017-09-12 14:05:00.427' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (83, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', CAST(N'2017-09-16 00:00:10.640' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (84, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', CAST(N'2017-09-16 00:00:10.893' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (85, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', CAST(N'2017-09-16 00:00:10.913' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (86, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', CAST(N'2017-09-16 00:00:10.927' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (87, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', CAST(N'2017-09-16 00:00:10.940' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (88, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', CAST(N'2017-09-16 00:00:10.950' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (89, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', CAST(N'2017-09-16 00:00:10.960' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (90, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', CAST(N'2017-09-16 00:00:10.973' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (91, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', CAST(N'2017-09-16 00:00:10.987' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (92, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', CAST(N'2017-09-16 00:00:27.333' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (93, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', CAST(N'2017-09-16 00:00:27.367' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (94, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', CAST(N'2017-09-16 00:01:36.210' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (95, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', CAST(N'2017-09-17 08:45:00.333' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (96, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', CAST(N'2017-09-17 10:01:57.140' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (97, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', CAST(N'2017-09-17 10:01:57.627' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (98, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', CAST(N'2017-09-17 10:01:58.257' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (99, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', CAST(N'2017-09-17 10:01:58.867' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (100, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', CAST(N'2017-09-17 10:01:59.337' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (101, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', CAST(N'2017-09-17 10:01:59.763' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (102, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', CAST(N'2017-09-17 10:02:00.200' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (103, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', CAST(N'2017-09-17 10:02:00.653' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (104, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', CAST(N'2017-09-17 10:02:01.127' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1095, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', CAST(N'2017-09-18 10:20:52.773' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1096, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', CAST(N'2017-09-18 10:21:42.033' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1097, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', CAST(N'2017-09-18 10:21:47.800' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1098, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', CAST(N'2017-09-18 10:22:43.223' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1099, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', CAST(N'2017-09-18 10:22:57.507' AS DateTime))
SET IDENTITY_INSERT [dbo].[cmsContentVersion] OFF
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1066, N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="1128" level="2" creatorID="0" sortOrder="2" createDate="2017-09-05T10:04:41" updateDate="2017-09-18T10:22:43" nodeName="Settings" urlName="settings" path="-1,1128,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><excludeFromTopNavigation>1</excludeFromTopNavigation><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1128, N'<home id="1128" key="01c2bb91-543e-4cf5-ab29-4409d80293af" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2017-09-10T23:34:24" updateDate="2017-09-17T08:45:00" nodeName="Home" urlName="home" path="-1,1128" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation><title><![CDATA[Hello]]></title></home>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1129, N'<account id="1129" key="549199dd-8963-4ccf-8c20-e1cee61fb601" parentID="1128" level="2" creatorID="0" sortOrder="0" createDate="2017-09-10T23:35:47" updateDate="2017-09-12T14:05:00" nodeName="Account" urlName="account" path="-1,1128,1129" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>1</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1130, N'<contact id="1130" key="d61ba0fb-2c5d-457e-86eb-c8ca945a69b5" parentID="1128" level="2" creatorID="0" sortOrder="1" createDate="2017-09-10T23:35:59" updateDate="2017-09-10T23:35:59" nodeName="Contact" urlName="contact" path="-1,1128,1130" isDoc="" nodeType="1124" creatorName="admin" writerName="admin" writerID="0" template="1083" nodeTypeAlias="contact"><excludeFromTopNavigation>0</excludeFromTopNavigation></contact>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1131, N'<login id="1131" key="cfa9e73d-eb82-46c0-8aca-2d041d3d8129" parentID="1129" level="3" creatorID="0" sortOrder="0" createDate="2017-09-10T23:37:13" updateDate="2017-09-10T23:37:13" nodeName="Login" urlName="login" path="-1,1128,1129,1131" isDoc="" nodeType="1126" creatorName="admin" writerName="admin" writerID="0" template="1082" nodeTypeAlias="login"><excludeFromTopNavigation>0</excludeFromTopNavigation></login>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1132, N'<register id="1132" key="d82dd4a3-04d8-4039-96b9-1e11cf991b4b" parentID="1129" level="3" creatorID="0" sortOrder="1" createDate="2017-09-10T23:37:22" updateDate="2017-09-10T23:37:22" nodeName="Register" urlName="register" path="-1,1128,1129,1132" isDoc="" nodeType="1127" creatorName="admin" writerName="admin" writerID="0" template="1077" nodeTypeAlias="register"><excludeFromTopNavigation>0</excludeFromTopNavigation></register>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1134, N'<confirmEmail id="1134" key="b0deabe2-d345-46fd-a754-f701281223d6" parentID="1129" level="3" creatorID="0" sortOrder="2" createDate="2017-09-10T23:38:58" updateDate="2017-09-10T23:38:58" nodeName="Confirm Email" urlName="confirm-email" path="-1,1128,1129,1134" isDoc="" nodeType="1133" creatorName="admin" writerName="admin" writerID="0" template="1119" nodeTypeAlias="confirmEmail"><excludeFromTopNavigation>0</excludeFromTopNavigation></confirmEmail>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1145, N'<forgotPassword id="1145" key="ccb5204f-a0eb-466f-9d7b-4ed7525324bc" parentID="1129" level="3" creatorID="0" sortOrder="3" createDate="2017-09-11T08:44:53" updateDate="2017-09-11T08:44:53" nodeName="Forgot Password" urlName="forgot-password" path="-1,1128,1129,1145" isDoc="" nodeType="1144" creatorName="admin" writerName="admin" writerID="0" template="1143" nodeTypeAlias="forgotPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></forgotPassword>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1148, N'<resetPassword id="1148" key="32b97bec-67e1-4787-bb9a-370346241d93" parentID="1129" level="3" creatorID="0" sortOrder="4" createDate="2017-09-11T09:08:13" updateDate="2017-09-11T09:08:13" nodeName="Reset Password" urlName="reset-password" path="-1,1128,1129,1148" isDoc="" nodeType="1147" creatorName="admin" writerName="admin" writerID="0" template="1146" nodeTypeAlias="resetPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></resetPassword>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1155, N'<externalLoginConfirmation id="1155" key="e321ab20-eba5-4b58-be38-896a3e283d61" parentID="1129" level="3" creatorID="0" sortOrder="5" createDate="2017-09-12T11:59:50" updateDate="2017-09-12T11:59:50" nodeName="External Login Confirmation" urlName="external-login-confirmation" path="-1,1128,1129,1155" isDoc="" nodeType="1153" creatorName="admin" writerName="admin" writerID="0" template="1154" nodeTypeAlias="externalLoginConfirmation"><excludeFromTopNavigation>0</excludeFromTopNavigation></externalLoginConfirmation>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1157, N'<Member id="1157" key="30f91007-10d2-4770-954a-a3b3f2f20912" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2017-09-12T14:02:03" updateDate="2017-09-12T14:02:03" nodeName="Vũ Nguyễn" urlName="vũ-nguyễn" path="-1,1157" isDoc="" nodeType="1044" nodeTypeAlias="Member" loginName="vnvipper@gmail.com" email="vnvipper@gmail.com" icon="icon-user"><umbracoMemberApproved>1</umbracoMemberApproved><securityStamp><![CDATA[771ab383-4d9d-4d05-a9a3-1ddcc1669172]]></securityStamp><isEmailConfirmed>1</isEmailConfirmed></Member>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1158, N'<home id="1158" key="0e784f9d-7059-4046-8761-19374529c976" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:57" nodeName="Vi" urlName="vi" path="-1,1158" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation><title><![CDATA[Xin Chào]]></title></home>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1159, N'<account id="1159" key="e9f80fb8-27c2-4bdc-bcda-36bb88d21d5e" parentID="1158" level="2" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:57" nodeName="Account" urlName="account" path="-1,1158,1159" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>1</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1160, N'<login id="1160" key="104ba2f0-f06a-4381-9b2d-0275458cad0d" parentID="1159" level="3" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:58" nodeName="Login" urlName="login" path="-1,1158,1159,1160" isDoc="" nodeType="1126" creatorName="admin" writerName="admin" writerID="0" template="1082" nodeTypeAlias="login"><excludeFromTopNavigation>0</excludeFromTopNavigation></login>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1161, N'<register id="1161" key="cbf0a7b9-7b29-42e6-875c-22aa5cc0fef6" parentID="1159" level="3" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:59" nodeName="Register" urlName="register" path="-1,1158,1159,1161" isDoc="" nodeType="1127" creatorName="admin" writerName="admin" writerID="0" template="1077" nodeTypeAlias="register"><excludeFromTopNavigation>0</excludeFromTopNavigation></register>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1162, N'<confirmEmail id="1162" key="f656b38c-44e0-4977-b7b5-5ad1f3009799" parentID="1159" level="3" creatorID="0" sortOrder="2" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:59" nodeName="Confirm Email" urlName="confirm-email" path="-1,1158,1159,1162" isDoc="" nodeType="1133" creatorName="admin" writerName="admin" writerID="0" template="1119" nodeTypeAlias="confirmEmail"><excludeFromTopNavigation>0</excludeFromTopNavigation></confirmEmail>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1163, N'<forgotPassword id="1163" key="2962ec17-a9f5-43f1-a582-55cbe6de462d" parentID="1159" level="3" creatorID="0" sortOrder="3" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:00" nodeName="Forgot Password" urlName="forgot-password" path="-1,1158,1159,1163" isDoc="" nodeType="1144" creatorName="admin" writerName="admin" writerID="0" template="1143" nodeTypeAlias="forgotPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></forgotPassword>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1164, N'<resetPassword id="1164" key="f51d9f91-40c9-4237-8ca3-6a08c926fa03" parentID="1159" level="3" creatorID="0" sortOrder="4" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:00" nodeName="Reset Password" urlName="reset-password" path="-1,1158,1159,1164" isDoc="" nodeType="1147" creatorName="admin" writerName="admin" writerID="0" template="1146" nodeTypeAlias="resetPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></resetPassword>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1165, N'<externalLoginConfirmation id="1165" key="ad6383b7-e6be-4ef9-bef0-e422f2679694" parentID="1159" level="3" creatorID="0" sortOrder="5" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:01" nodeName="External Login Confirmation" urlName="external-login-confirmation" path="-1,1158,1159,1165" isDoc="" nodeType="1153" creatorName="admin" writerName="admin" writerID="0" template="1154" nodeTypeAlias="externalLoginConfirmation"><excludeFromTopNavigation>0</excludeFromTopNavigation></externalLoginConfirmation>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1166, N'<contact id="1166" key="7e9c876e-99dd-4b50-a689-6ab1aebd2a66" parentID="1158" level="2" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:58" nodeName="Contact" urlName="contact" path="-1,1158,1166" isDoc="" nodeType="1124" creatorName="admin" writerName="admin" writerID="0" template="1083" nodeTypeAlias="contact"><excludeFromTopNavigation>0</excludeFromTopNavigation></contact>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1167, N'<settings id="1167" key="bfb38c72-6017-4958-8bc4-ad80c80930bf" parentID="1158" level="2" creatorID="0" sortOrder="2" createDate="2017-09-18T10:21:42" updateDate="2017-09-18T10:22:57" nodeName="Settings" urlName="settings" path="-1,1158,1167" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><excludeFromTopNavigation>1</excludeFromTopNavigation><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
SET IDENTITY_INSERT [dbo].[cmsDataType] ON 

INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-28, -97, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-27, -96, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-26, -95, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (1, -49, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (2, -51, N'Umbraco.Integer', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (3, -87, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (4, -88, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (5, -89, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (6, -90, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (7, -92, N'Umbraco.NoEdit', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (8, -36, N'Umbraco.DateTime', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (9, -37, N'Umbraco.ColorPickerAlias', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (11, -39, N'Umbraco.DropDownMultiple', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (12, -40, N'Umbraco.RadioButtonList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (13, -41, N'Umbraco.Date', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (14, -42, N'Umbraco.DropDown', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (15, -43, N'Umbraco.CheckBoxList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (22, 1041, N'Umbraco.Tags', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (24, 1043, N'Umbraco.ImageCropper', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (26, 1046, N'Umbraco.ContentPicker2', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (27, 1047, N'Umbraco.MemberPicker2', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (28, 1048, N'Umbraco.MediaPicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (29, 1049, N'Umbraco.MediaPicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (30, 1050, N'Umbraco.RelatedLinks2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (31, 1058, N'Imulus.Archetype', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (32, 1059, N'Umbraco.Tags', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (33, 1060, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (34, 1067, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (35, 1068, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (36, 1069, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (37, 1089, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (38, 1105, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (39, 1115, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (40, 1121, N'Umbraco.TextboxMultiple', N'Ntext')
SET IDENTITY_INSERT [dbo].[cmsDataType] OFF
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] ON 

INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-9, -96, N'[{"alias":"updateDate","header":"Last edited","isSystem":1},{"alias":"owner","header":"Updated by","isSystem":1}]', 5, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-8, -96, N'[{"name": "Grid","path": "views/propertyeditors/listview/layouts/grid/grid.html", "icon": "icon-thumbnails-small", "isSystem": 1, "selected": true},{"name": "List","path": "views/propertyeditors/listview/layouts/list/list.html","icon": "icon-list", "isSystem": 1,"selected": true}]', 4, N'layouts')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-7, -96, N'desc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-6, -96, N'updateDate', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-5, -96, N'100', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-4, -97, N'[{"alias":"username","isSystem":1},{"alias":"email","isSystem":1},{"alias":"updateDate","header":"Last edited","isSystem":1}]', 4, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-3, -97, N'asc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-2, -97, N'username', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-1, -97, N'10', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (3, -87, N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|', 0, N'')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (4, 1041, N'default', 0, N'group')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (6, 1049, N'1', 0, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (7, 1058, N'{
  "showAdvancedOptions": false,
  "startWithAddButton": true,
  "hideFieldsetToolbar": false,
  "enableMultipleFieldsets": false,
  "hideFieldsetControls": false,
  "hidePropertyLabel": false,
  "maxFieldsets": null,
  "enableCollapsing": true,
  "enableMultipleOpen": true,
  "enableCloning": false,
  "enableDisabling": true,
  "enableDeepDatatypeRequests": false,
  "enablePublishing": false,
  "enableMemberGroups": false,
  "enableCrossDragging": false,
  "fieldsets": [
    {
      "alias": "social",
      "remove": false,
      "collapse": false,
      "labelTemplate": "{{name}}",
      "icon": "",
      "label": "Social",
      "properties": [
        {
          "alias": "name",
          "remove": false,
          "collapse": false,
          "label": "Name",
          "helpText": "",
          "dataTypeGuid": "0cc0eba1-9960-42c9-bf9b-60e150b429ae",
          "value": "",
          "aliasIsDirty": true,
          "required": true
        },
        {
          "alias": "linkUrl",
          "remove": false,
          "collapse": false,
          "label": "LinkUrl",
          "helpText": "",
          "dataTypeGuid": "0cc0eba1-9960-42c9-bf9b-60e150b429ae",
          "value": "",
          "required": true
        },
        {
          "alias": "logo",
          "remove": false,
          "collapse": false,
          "label": "Logo",
          "helpText": "",
          "dataTypeGuid": "0cc0eba1-9960-42c9-bf9b-60e150b429ae",
          "value": "",
          "aliasIsDirty": true,
          "required": true
        }
      ],
      "group": null
    }
  ],
  "fieldsetGroups": []
}', 1, N'archetypeConfig')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (8, 1058, NULL, 2, N'hideLabel')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (9, 1059, N'default', 1, N'group')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (10, 1059, N'Json', 2, N'storageType')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (11, 1060, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (13, 1067, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (14, 1068, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (16, 1069, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (17, 1089, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (18, 1105, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (19, 1115, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (20, 1121, NULL, 1, N'maxChars')
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] OFF
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1129, 0, 0, N'64312f62-8db6-4ceb-9976-004d3facb05e', N'Account', NULL, NULL, CAST(N'2017-09-10 23:35:47.027' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1128, 1, 0, N'a5c22550-1a3f-4279-b811-05c03c981611', N'Home', NULL, NULL, CAST(N'2017-09-17 08:45:00.333' AS DateTime), 1063, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1155, 1, 0, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', N'External Login Confirmation', NULL, NULL, CAST(N'2017-09-12 11:59:50.220' AS DateTime), 1154, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1166, 0, 0, N'ff8023cf-66db-416f-b16d-1c705d32aa33', N'Contact', NULL, NULL, CAST(N'2017-09-16 00:00:10.987' AS DateTime), 1083, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1165, 1, 0, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', N'External Login Confirmation', NULL, NULL, CAST(N'2017-09-17 10:02:01.127' AS DateTime), 1154, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1158, 0, 0, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', N'Vi', NULL, NULL, CAST(N'2017-09-16 00:01:36.210' AS DateTime), 1063, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1066, 0, 0, N'e25ca576-8c69-4924-a022-30200d722831', N'Settings', NULL, NULL, CAST(N'2017-09-05 10:04:41.567' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1128, 0, 0, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', N'Home', NULL, NULL, CAST(N'2017-09-10 23:34:24.987' AS DateTime), 1063, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1164, 1, 0, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', N'Reset Password', NULL, NULL, CAST(N'2017-09-17 10:02:00.653' AS DateTime), 1146, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1165, 0, 0, N'df3af16a-f734-4c55-ae61-48b2cdc99576', N'External Login Confirmation', NULL, NULL, CAST(N'2017-09-16 00:00:10.973' AS DateTime), 1154, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1162, 0, 0, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', N'Confirm Email', NULL, NULL, CAST(N'2017-09-16 00:00:10.940' AS DateTime), 1119, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1134, 1, 0, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', N'Confirm Email', NULL, NULL, CAST(N'2017-09-10 23:38:58.157' AS DateTime), 1119, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1167, 0, 0, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', N'Settings', NULL, NULL, CAST(N'2017-09-18 10:21:42.033' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1158, 1, 0, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', N'Vi', NULL, NULL, CAST(N'2017-09-17 10:01:57.140' AS DateTime), 1063, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1066, 1, 0, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', N'Settings', NULL, NULL, CAST(N'2017-09-18 10:22:43.223' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1132, 1, 0, N'b0195386-fd75-47ea-be45-70e7cb2a5521', N'Register', NULL, NULL, CAST(N'2017-09-10 23:37:22.200' AS DateTime), 1077, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1158, 0, 0, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', N'Home (1)', NULL, NULL, CAST(N'2017-09-16 00:00:27.333' AS DateTime), 1063, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1145, 1, 0, N'fee421be-5c56-434f-b2ed-74492c409fb0', N'Forgot Password', NULL, NULL, CAST(N'2017-09-11 08:44:53.387' AS DateTime), 1143, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1159, 0, 0, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', N'Account', NULL, NULL, CAST(N'2017-09-16 00:00:10.893' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1066, 0, 0, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', N'Settings', NULL, NULL, CAST(N'2017-09-05 10:40:06.823' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1159, 1, 0, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', N'Account', NULL, NULL, CAST(N'2017-09-17 10:01:57.627' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1161, 0, 0, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', N'Register', NULL, NULL, CAST(N'2017-09-16 00:00:10.927' AS DateTime), 1077, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1148, 1, 0, N'98e82282-cca4-4a05-8dfa-8989defc841a', N'Reset Password', NULL, NULL, CAST(N'2017-09-11 09:08:13.363' AS DateTime), 1146, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1160, 0, 0, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', N'Login', NULL, NULL, CAST(N'2017-09-16 00:00:10.913' AS DateTime), 1082, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1161, 1, 0, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', N'Register', NULL, NULL, CAST(N'2017-09-17 10:01:59.337' AS DateTime), 1077, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1163, 1, 0, N'69f601ae-1daa-4c33-8aac-a9b21a411920', N'Forgot Password', NULL, NULL, CAST(N'2017-09-17 10:02:00.200' AS DateTime), 1143, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1130, 1, 0, N'3549aab4-94b6-426d-a90e-ac8d16049439', N'Contact', NULL, NULL, CAST(N'2017-09-10 23:35:59.873' AS DateTime), 1083, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1164, 0, 0, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', N'Reset Password', NULL, NULL, CAST(N'2017-09-16 00:00:10.960' AS DateTime), 1146, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1160, 1, 0, N'e27468ff-5b48-476f-9219-b1415f77638c', N'Login', NULL, NULL, CAST(N'2017-09-17 10:01:58.867' AS DateTime), 1082, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1167, 1, 0, N'935e1234-77f7-4f48-ab65-b6245515c023', N'Settings', NULL, NULL, CAST(N'2017-09-18 10:22:57.507' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1162, 1, 0, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', N'Confirm Email', NULL, NULL, CAST(N'2017-09-17 10:01:59.763' AS DateTime), 1119, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1066, 0, 0, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', N'Settings', NULL, NULL, CAST(N'2017-09-16 00:00:27.367' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1167, 0, 0, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', N'Settings', NULL, NULL, CAST(N'2017-09-18 10:21:47.800' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1128, 0, 0, N'012e721f-4b66-431f-9f50-d3bfc336ce65', N'Home', NULL, NULL, CAST(N'2017-09-10 23:35:27.397' AS DateTime), 1063, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1166, 1, 0, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', N'Contact', NULL, NULL, CAST(N'2017-09-17 10:01:58.257' AS DateTime), 1083, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1131, 1, 0, N'2ff195fc-1c17-458a-84c8-dd1823852def', N'Login', NULL, NULL, CAST(N'2017-09-10 23:37:13.010' AS DateTime), 1082, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1066, 0, 0, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', N'Settings', NULL, NULL, CAST(N'2017-09-18 10:20:52.773' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1158, 0, 0, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', N'Home (1)', NULL, NULL, CAST(N'2017-09-16 00:00:10.640' AS DateTime), 1063, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1129, 1, 0, N'2bf5eac5-ad71-407c-b058-f939f91da362', N'Account', NULL, NULL, CAST(N'2017-09-12 14:05:00.427' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1163, 0, 0, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', N'Forgot Password', NULL, NULL, CAST(N'2017-09-16 00:00:10.950' AS DateTime), 1143, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1123, 1063, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1124, 1083, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1126, 1082, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1127, 1077, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1133, 1119, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1144, 1143, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1147, 1146, 1)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1153, 1154, 1)
INSERT [dbo].[cmsMember] ([nodeId], [Email], [LoginName], [Password]) VALUES (1157, N'vnvipper@gmail.com', N'vnvipper@gmail.com', N'___UIDEMPTYPWORD__AJHc2lFQa4nAGlclKU41lpABoLcj1E5H8A2tHMsOgrbwtVPKhUG6eXjL4Q56kd5yeA==')
SET IDENTITY_INSERT [dbo].[cmsMemberType] ON 

INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (71, 1044, 35, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (72, 1044, 36, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (73, 1044, 28, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (74, 1044, 29, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (75, 1044, 30, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (76, 1044, 31, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (77, 1044, 32, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (78, 1044, 33, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (79, 1044, 34, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (80, 1044, 49, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (81, 1044, 57, 1, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile]) VALUES (82, 1044, 68, 1, 0)
SET IDENTITY_INSERT [dbo].[cmsMemberType] OFF
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1066, N'e25ca576-8c69-4924-a022-30200d722831', CAST(N'2017-09-05 10:04:41.583' AS DateTime), N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-05T10:04:41" updateDate="2017-09-05T10:04:41" nodeName="Settings" urlName="settings" path="-1,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', CAST(N'2017-09-18 10:22:43.950' AS DateTime), N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="1128" level="2" creatorID="0" sortOrder="2" createDate="2017-09-05T10:04:41" updateDate="2017-09-18T10:22:43" nodeName="Settings" urlName="settings" path="-1,1128,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><excludeFromTopNavigation>1</excludeFromTopNavigation><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', CAST(N'2017-09-05 10:40:06.910' AS DateTime), N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-05T10:04:41" updateDate="2017-09-05T10:40:06" nodeName="Settings" urlName="settings" path="-1,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', CAST(N'2017-09-16 00:00:27.393' AS DateTime), N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2017-09-05T10:04:41" updateDate="2017-09-16T00:00:27" nodeName="Settings" urlName="settings" path="-1,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', CAST(N'2017-09-18 10:20:53.363' AS DateTime), N'<settings id="1066" key="49f4b0f3-b21f-4dbc-89d4-645db8c9aae7" parentID="1128" level="2" creatorID="0" sortOrder="2" createDate="2017-09-05T10:04:41" updateDate="2017-09-18T10:20:52" nodeName="Settings" urlName="settings" path="-1,1128,1066" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1128, N'a5c22550-1a3f-4279-b811-05c03c981611', CAST(N'2017-09-17 08:45:00.437' AS DateTime), N'<home id="1128" key="01c2bb91-543e-4cf5-ab29-4409d80293af" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2017-09-10T23:34:24" updateDate="2017-09-17T08:45:00" nodeName="Home" urlName="home" path="-1,1128" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation><title><![CDATA[Hello]]></title></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', CAST(N'2017-09-10 23:34:25.037' AS DateTime), N'<home id="1128" key="01c2bb91-543e-4cf5-ab29-4409d80293af" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2017-09-10T23:34:24" updateDate="2017-09-10T23:34:24" nodeName="Home" urlName="home" path="-1,1128" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', CAST(N'2017-09-10 23:35:27.440' AS DateTime), N'<home id="1128" key="01c2bb91-543e-4cf5-ab29-4409d80293af" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2017-09-10T23:34:24" updateDate="2017-09-10T23:35:27" nodeName="Home" urlName="home" path="-1,1128" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', CAST(N'2017-09-10 23:35:47.050' AS DateTime), N'<account id="1129" key="549199dd-8963-4ccf-8c20-e1cee61fb601" parentID="1128" level="2" creatorID="0" sortOrder="0" createDate="2017-09-10T23:35:47" updateDate="2017-09-10T23:35:47" nodeName="Account" urlName="account" path="-1,1128,1129" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>0</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', CAST(N'2017-09-12 14:05:00.523' AS DateTime), N'<account id="1129" key="549199dd-8963-4ccf-8c20-e1cee61fb601" parentID="1128" level="2" creatorID="0" sortOrder="0" createDate="2017-09-10T23:35:47" updateDate="2017-09-12T14:05:00" nodeName="Account" urlName="account" path="-1,1128,1129" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>1</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', CAST(N'2017-09-10 23:35:59.890' AS DateTime), N'<contact id="1130" key="d61ba0fb-2c5d-457e-86eb-c8ca945a69b5" parentID="1128" level="2" creatorID="0" sortOrder="1" createDate="2017-09-10T23:35:59" updateDate="2017-09-10T23:35:59" nodeName="Contact" urlName="contact" path="-1,1128,1130" isDoc="" nodeType="1124" creatorName="admin" writerName="admin" writerID="0" template="1083" nodeTypeAlias="contact"><excludeFromTopNavigation>0</excludeFromTopNavigation></contact>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', CAST(N'2017-09-10 23:37:13.057' AS DateTime), N'<login id="1131" key="cfa9e73d-eb82-46c0-8aca-2d041d3d8129" parentID="1129" level="3" creatorID="0" sortOrder="0" createDate="2017-09-10T23:37:13" updateDate="2017-09-10T23:37:13" nodeName="Login" urlName="login" path="-1,1128,1129,1131" isDoc="" nodeType="1126" creatorName="admin" writerName="admin" writerID="0" template="1082" nodeTypeAlias="login"><excludeFromTopNavigation>0</excludeFromTopNavigation></login>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', CAST(N'2017-09-10 23:37:22.243' AS DateTime), N'<register id="1132" key="d82dd4a3-04d8-4039-96b9-1e11cf991b4b" parentID="1129" level="3" creatorID="0" sortOrder="1" createDate="2017-09-10T23:37:22" updateDate="2017-09-10T23:37:22" nodeName="Register" urlName="register" path="-1,1128,1129,1132" isDoc="" nodeType="1127" creatorName="admin" writerName="admin" writerID="0" template="1077" nodeTypeAlias="register"><excludeFromTopNavigation>0</excludeFromTopNavigation></register>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', CAST(N'2017-09-10 23:38:58.190' AS DateTime), N'<confirmEmail id="1134" key="b0deabe2-d345-46fd-a754-f701281223d6" parentID="1129" level="3" creatorID="0" sortOrder="2" createDate="2017-09-10T23:38:58" updateDate="2017-09-10T23:38:58" nodeName="Confirm Email" urlName="confirm-email" path="-1,1128,1129,1134" isDoc="" nodeType="1133" creatorName="admin" writerName="admin" writerID="0" template="1119" nodeTypeAlias="confirmEmail"><excludeFromTopNavigation>0</excludeFromTopNavigation></confirmEmail>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', CAST(N'2017-09-11 08:44:53.493' AS DateTime), N'<forgotPassword id="1145" key="ccb5204f-a0eb-466f-9d7b-4ed7525324bc" parentID="1129" level="3" creatorID="0" sortOrder="3" createDate="2017-09-11T08:44:53" updateDate="2017-09-11T08:44:53" nodeName="Forgot Password" urlName="forgot-password" path="-1,1128,1129,1145" isDoc="" nodeType="1144" creatorName="admin" writerName="admin" writerID="0" template="1143" nodeTypeAlias="forgotPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></forgotPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', CAST(N'2017-09-11 09:08:13.427' AS DateTime), N'<resetPassword id="1148" key="32b97bec-67e1-4787-bb9a-370346241d93" parentID="1129" level="3" creatorID="0" sortOrder="4" createDate="2017-09-11T09:08:13" updateDate="2017-09-11T09:08:13" nodeName="Reset Password" urlName="reset-password" path="-1,1128,1129,1148" isDoc="" nodeType="1147" creatorName="admin" writerName="admin" writerID="0" template="1146" nodeTypeAlias="resetPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></resetPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', CAST(N'2017-09-12 11:59:50.800' AS DateTime), N'<externalLoginConfirmation id="1155" key="e321ab20-eba5-4b58-be38-896a3e283d61" parentID="1129" level="3" creatorID="0" sortOrder="5" createDate="2017-09-12T11:59:50" updateDate="2017-09-12T11:59:50" nodeName="External Login Confirmation" urlName="external-login-confirmation" path="-1,1128,1129,1155" isDoc="" nodeType="1153" creatorName="admin" writerName="admin" writerID="0" template="1154" nodeTypeAlias="externalLoginConfirmation"><excludeFromTopNavigation>0</excludeFromTopNavigation></externalLoginConfirmation>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', CAST(N'2017-09-16 00:01:36.230' AS DateTime), N'<home id="1158" key="0e784f9d-7059-4046-8761-19374529c976" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:01:36" nodeName="Vi" urlName="vi" path="-1,1158" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', CAST(N'2017-09-17 10:01:57.573' AS DateTime), N'<home id="1158" key="0e784f9d-7059-4046-8761-19374529c976" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:57" nodeName="Vi" urlName="vi" path="-1,1158" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation><title><![CDATA[Xin Chào]]></title></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', CAST(N'2017-09-16 00:00:27.363' AS DateTime), N'<home id="1158" key="0e784f9d-7059-4046-8761-19374529c976" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:27" nodeName="Home (1)" urlName="home-1" path="-1,1158" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', CAST(N'2017-09-16 00:00:10.720' AS DateTime), N'<home id="1158" key="0e784f9d-7059-4046-8761-19374529c976" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Home (1)" urlName="home-1" path="-1,1158" isDoc="" nodeType="1123" creatorName="admin" writerName="admin" writerID="0" template="1063" nodeTypeAlias="home"><excludeFromTopNavigation>0</excludeFromTopNavigation></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', CAST(N'2017-09-16 00:00:10.903' AS DateTime), N'<account id="1159" key="e9f80fb8-27c2-4bdc-bcda-36bb88d21d5e" parentID="1158" level="2" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Account" urlName="account" path="-1,1158,1159" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>1</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', CAST(N'2017-09-17 10:01:58.120' AS DateTime), N'<account id="1159" key="e9f80fb8-27c2-4bdc-bcda-36bb88d21d5e" parentID="1158" level="2" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:57" nodeName="Account" urlName="account" path="-1,1158,1159" isDoc="" nodeType="1125" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="account"><excludeFromTopNavigation>1</excludeFromTopNavigation></account>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', CAST(N'2017-09-16 00:00:10.920' AS DateTime), N'<login id="1160" key="104ba2f0-f06a-4381-9b2d-0275458cad0d" parentID="1159" level="3" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Login" urlName="login" path="-1,1158,1159,1160" isDoc="" nodeType="1126" creatorName="admin" writerName="admin" writerID="0" template="1082" nodeTypeAlias="login"><excludeFromTopNavigation>0</excludeFromTopNavigation></login>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1160, N'e27468ff-5b48-476f-9219-b1415f77638c', CAST(N'2017-09-17 10:01:59.237' AS DateTime), N'<login id="1160" key="104ba2f0-f06a-4381-9b2d-0275458cad0d" parentID="1159" level="3" creatorID="0" sortOrder="0" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:58" nodeName="Login" urlName="login" path="-1,1158,1159,1160" isDoc="" nodeType="1126" creatorName="admin" writerName="admin" writerID="0" template="1082" nodeTypeAlias="login"><excludeFromTopNavigation>0</excludeFromTopNavigation></login>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', CAST(N'2017-09-16 00:00:10.933' AS DateTime), N'<register id="1161" key="cbf0a7b9-7b29-42e6-875c-22aa5cc0fef6" parentID="1159" level="3" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Register" urlName="register" path="-1,1158,1159,1161" isDoc="" nodeType="1127" creatorName="admin" writerName="admin" writerID="0" template="1077" nodeTypeAlias="register"><excludeFromTopNavigation>0</excludeFromTopNavigation></register>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', CAST(N'2017-09-17 10:01:59.677' AS DateTime), N'<register id="1161" key="cbf0a7b9-7b29-42e6-875c-22aa5cc0fef6" parentID="1159" level="3" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:59" nodeName="Register" urlName="register" path="-1,1158,1159,1161" isDoc="" nodeType="1127" creatorName="admin" writerName="admin" writerID="0" template="1077" nodeTypeAlias="register"><excludeFromTopNavigation>0</excludeFromTopNavigation></register>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', CAST(N'2017-09-16 00:00:10.947' AS DateTime), N'<confirmEmail id="1162" key="f656b38c-44e0-4977-b7b5-5ad1f3009799" parentID="1159" level="3" creatorID="0" sortOrder="2" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Confirm Email" urlName="confirm-email" path="-1,1158,1159,1162" isDoc="" nodeType="1133" creatorName="admin" writerName="admin" writerID="0" template="1119" nodeTypeAlias="confirmEmail"><excludeFromTopNavigation>0</excludeFromTopNavigation></confirmEmail>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', CAST(N'2017-09-17 10:02:00.117' AS DateTime), N'<confirmEmail id="1162" key="f656b38c-44e0-4977-b7b5-5ad1f3009799" parentID="1159" level="3" creatorID="0" sortOrder="2" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:59" nodeName="Confirm Email" urlName="confirm-email" path="-1,1158,1159,1162" isDoc="" nodeType="1133" creatorName="admin" writerName="admin" writerID="0" template="1119" nodeTypeAlias="confirmEmail"><excludeFromTopNavigation>0</excludeFromTopNavigation></confirmEmail>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', CAST(N'2017-09-17 10:02:00.563' AS DateTime), N'<forgotPassword id="1163" key="2962ec17-a9f5-43f1-a582-55cbe6de462d" parentID="1159" level="3" creatorID="0" sortOrder="3" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:00" nodeName="Forgot Password" urlName="forgot-password" path="-1,1158,1159,1163" isDoc="" nodeType="1144" creatorName="admin" writerName="admin" writerID="0" template="1143" nodeTypeAlias="forgotPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></forgotPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', CAST(N'2017-09-16 00:00:10.957' AS DateTime), N'<forgotPassword id="1163" key="2962ec17-a9f5-43f1-a582-55cbe6de462d" parentID="1159" level="3" creatorID="0" sortOrder="3" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Forgot Password" urlName="forgot-password" path="-1,1158,1159,1163" isDoc="" nodeType="1144" creatorName="admin" writerName="admin" writerID="0" template="1143" nodeTypeAlias="forgotPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></forgotPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', CAST(N'2017-09-17 10:02:01.033' AS DateTime), N'<resetPassword id="1164" key="f51d9f91-40c9-4237-8ca3-6a08c926fa03" parentID="1159" level="3" creatorID="0" sortOrder="4" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:00" nodeName="Reset Password" urlName="reset-password" path="-1,1158,1159,1164" isDoc="" nodeType="1147" creatorName="admin" writerName="admin" writerID="0" template="1146" nodeTypeAlias="resetPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></resetPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', CAST(N'2017-09-16 00:00:10.970' AS DateTime), N'<resetPassword id="1164" key="f51d9f91-40c9-4237-8ca3-6a08c926fa03" parentID="1159" level="3" creatorID="0" sortOrder="4" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Reset Password" urlName="reset-password" path="-1,1158,1159,1164" isDoc="" nodeType="1147" creatorName="admin" writerName="admin" writerID="0" template="1146" nodeTypeAlias="resetPassword"><excludeFromTopNavigation>0</excludeFromTopNavigation></resetPassword>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', CAST(N'2017-09-17 10:02:01.457' AS DateTime), N'<externalLoginConfirmation id="1165" key="ad6383b7-e6be-4ef9-bef0-e422f2679694" parentID="1159" level="3" creatorID="0" sortOrder="5" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:02:01" nodeName="External Login Confirmation" urlName="external-login-confirmation" path="-1,1158,1159,1165" isDoc="" nodeType="1153" creatorName="admin" writerName="admin" writerID="0" template="1154" nodeTypeAlias="externalLoginConfirmation"><excludeFromTopNavigation>0</excludeFromTopNavigation></externalLoginConfirmation>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', CAST(N'2017-09-16 00:00:10.980' AS DateTime), N'<externalLoginConfirmation id="1165" key="ad6383b7-e6be-4ef9-bef0-e422f2679694" parentID="1159" level="3" creatorID="0" sortOrder="5" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="External Login Confirmation" urlName="external-login-confirmation" path="-1,1158,1159,1165" isDoc="" nodeType="1153" creatorName="admin" writerName="admin" writerID="0" template="1154" nodeTypeAlias="externalLoginConfirmation"><excludeFromTopNavigation>0</excludeFromTopNavigation></externalLoginConfirmation>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', CAST(N'2017-09-16 00:00:10.993' AS DateTime), N'<contact id="1166" key="7e9c876e-99dd-4b50-a689-6ab1aebd2a66" parentID="1158" level="2" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-16T00:00:10" nodeName="Contact" urlName="contact" path="-1,1158,1166" isDoc="" nodeType="1124" creatorName="admin" writerName="admin" writerID="0" template="1083" nodeTypeAlias="contact"><excludeFromTopNavigation>0</excludeFromTopNavigation></contact>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', CAST(N'2017-09-17 10:01:58.760' AS DateTime), N'<contact id="1166" key="7e9c876e-99dd-4b50-a689-6ab1aebd2a66" parentID="1158" level="2" creatorID="0" sortOrder="1" createDate="2017-09-16T00:00:10" updateDate="2017-09-17T10:01:58" nodeName="Contact" urlName="contact" path="-1,1158,1166" isDoc="" nodeType="1124" creatorName="admin" writerName="admin" writerID="0" template="1083" nodeTypeAlias="contact"><excludeFromTopNavigation>0</excludeFromTopNavigation></contact>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', CAST(N'2017-09-18 10:21:42.493' AS DateTime), N'<settings id="1167" key="bfb38c72-6017-4958-8bc4-ad80c80930bf" parentID="1158" level="2" creatorID="0" sortOrder="2" createDate="2017-09-18T10:21:42" updateDate="2017-09-18T10:21:42" nodeName="Settings" urlName="settings" path="-1,1158,1167" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1167, N'935e1234-77f7-4f48-ab65-b6245515c023', CAST(N'2017-09-18 10:22:58.140' AS DateTime), N'<settings id="1167" key="bfb38c72-6017-4958-8bc4-ad80c80930bf" parentID="1158" level="2" creatorID="0" sortOrder="2" createDate="2017-09-18T10:21:42" updateDate="2017-09-18T10:22:57" nodeName="Settings" urlName="settings" path="-1,1158,1167" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><excludeFromTopNavigation>1</excludeFromTopNavigation><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', CAST(N'2017-09-18 10:21:48.203' AS DateTime), N'<settings id="1167" key="bfb38c72-6017-4958-8bc4-ad80c80930bf" parentID="1158" level="2" creatorID="0" sortOrder="2" createDate="2017-09-18T10:21:42" updateDate="2017-09-18T10:21:47" nodeName="Settings" urlName="settings" path="-1,1158,1167" isDoc="" nodeType="1057" creatorName="admin" writerName="admin" writerID="0" template="0" nodeTypeAlias="settings"><siteName><![CDATA[Umbraco Template]]></siteName><socialNetwork><![CDATA[{"fieldsets":[]}]]></socialNetwork></settings>')
SET IDENTITY_INSERT [dbo].[cmsPropertyData] ON 

INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (13, 1066, N'e25ca576-8c69-4924-a022-30200d722831', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (14, 1066, N'e25ca576-8c69-4924-a022-30200d722831', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (15, 1066, N'e25ca576-8c69-4924-a022-30200d722831', 41, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (16, 1066, N'e25ca576-8c69-4924-a022-30200d722831', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (17, 1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (18, 1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (19, 1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (20, 1066, N'4cd9d923-f71b-4224-a002-7c1e72b54bde', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (226, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (227, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (228, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (229, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (230, 1128, N'5d3ff5ee-e721-4dfb-9a89-36eb41fee1f8', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (231, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (232, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (233, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (234, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (235, 1128, N'012e721f-4b66-431f-9f50-d3bfc336ce65', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (236, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (237, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (238, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (239, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (240, 1129, N'64312f62-8db6-4ceb-9976-004d3facb05e', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (241, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (242, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (243, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (244, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (245, 1130, N'3549aab4-94b6-426d-a90e-ac8d16049439', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (246, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (247, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (248, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (249, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (250, 1131, N'2ff195fc-1c17-458a-84c8-dd1823852def', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (251, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (252, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (253, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (254, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (255, 1132, N'b0195386-fd75-47ea-be45-70e7cb2a5521', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (256, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (257, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (258, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (259, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (260, 1134, N'af44d1d9-9dcf-4c8e-8ff7-63d944b254a3', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (350, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (351, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (352, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (353, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (354, 1145, N'fee421be-5c56-434f-b2ed-74492c409fb0', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (355, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (356, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (357, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (358, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (359, 1148, N'98e82282-cca4-4a05-8dfa-8989defc841a', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (408, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (409, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (410, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (411, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (412, 1155, N'c29fbb94-f326-4e5a-adc2-0c34216de1ed', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (425, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 35, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (426, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 36, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (427, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 28, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (428, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 29, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (429, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 30, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (430, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 31, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (431, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 32, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (432, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 33, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (433, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 34, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (434, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 49, NULL, NULL, NULL, N'771ab383-4d9d-4d05-a9a3-1ddcc1669172', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (435, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 57, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (436, 1157, N'7f358529-8d0c-4f85-ac82-d3b8f97a5954', 68, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (437, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (438, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', 67, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (439, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (440, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (441, 1129, N'2bf5eac5-ad71-407c-b058-f939f91da362', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (442, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (443, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (444, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (445, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (446, 1158, N'c4d6475c-d50a-4eaf-a20f-f5f449dc182d', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (447, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (448, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', 67, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (449, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (450, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (451, 1159, N'1923e25b-0205-4b42-8f4c-7797ef48b72b', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (452, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (453, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (454, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (455, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (456, 1160, N'bb4264f9-1764-41be-ac0f-8ef739850b4a', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (457, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (458, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (459, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (460, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (461, 1161, N'7c75d3a8-e444-4004-aa84-893c12ff21a5', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (462, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (463, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (464, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (465, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', 66, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (466, 1162, N'3f844e72-1bfc-4ddf-ada9-4d6943fc473f', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (467, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (468, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (469, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (470, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (471, 1163, N'872efa23-385d-4569-a301-fb3d5ad6bb2c', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (472, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (473, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (474, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (475, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (476, 1164, N'17ecd715-1dea-41bc-96b1-b0b64466cc30', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (477, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (478, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (479, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (480, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (481, 1165, N'df3af16a-f734-4c55-ae61-48b2cdc99576', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (482, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (483, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (484, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (485, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (486, 1166, N'ff8023cf-66db-416f-b16d-1c705d32aa33', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (487, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (488, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (489, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (490, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (491, 1158, N'896f0dd8-5673-4293-90d8-72a62dc5bbf8', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (492, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (493, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (494, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (495, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (496, 1066, N'd9d18b77-edc1-4d21-a4d0-d12060d7b2c9', 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (497, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (498, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (499, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (500, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (501, 1158, N'16920bd6-b6e2-4910-828a-2cb4af8fb5c1', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (502, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (503, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (504, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (505, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (506, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (507, 1128, N'a5c22550-1a3f-4279-b811-05c03c981611', 69, NULL, NULL, NULL, N'Hello', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (508, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (509, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (510, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (511, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (512, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (513, 1158, N'6bf71ea3-8178-42af-8e14-66a55691a0bf', 69, NULL, NULL, NULL, N'Xin Chào', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (514, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (515, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', 67, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (516, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (517, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (518, 1159, N'1ac7c14e-bf91-4f64-9fc3-80f416d1b9b8', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (519, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (520, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (521, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (522, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (523, 1166, N'05e740a2-fa2b-4671-a7ad-d92c6dea343d', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (524, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (525, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (526, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (527, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (528, 1160, N'e27468ff-5b48-476f-9219-b1415f77638c', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (529, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (530, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (531, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (532, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (533, 1161, N'0b3a10aa-3809-41c7-9631-a2207fe4ab90', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (534, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (535, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (536, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (537, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (538, 1162, N'cc69cb4a-3645-478e-a83e-c4785e27f2a2', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (539, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (540, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (541, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (542, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (543, 1163, N'69f601ae-1daa-4c33-8aac-a9b21a411920', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (544, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (545, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (546, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (547, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (548, 1164, N'4e1bb14e-fc07-4ae4-98d8-47cc4e5bb5b0', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (549, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (550, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', 67, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (551, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (552, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (553, 1165, N'31b6da2e-fe7a-4902-ae20-27a5bce9eb27', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1502, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1503, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1504, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1505, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1506, 1066, N'5a6ba4b5-7bd1-4b72-93ec-f1550f13cd06', 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1507, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1508, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1509, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1510, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1511, 1167, N'dedd4c8e-79fb-4a98-b0d2-657a011e2d24', 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1512, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1513, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', 39, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1514, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1515, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1516, 1167, N'f4fc26fd-b0ef-4dab-9fbf-d17bc28f8bfd', 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1517, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1518, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 67, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1519, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1520, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1521, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1522, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1523, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1524, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1525, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1526, 1066, N'6779c8ab-f5ac-45a3-8c93-6764cd2afabc', 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1527, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 63, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1528, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 67, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1529, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 65, NULL, NULL, NULL, NULL, N'')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1530, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 66, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1531, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 64, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1532, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 40, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1533, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 39, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1534, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 41, NULL, NULL, NULL, N'Umbraco Template', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1535, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 42, NULL, NULL, NULL, NULL, N'{"fieldsets":[]}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1536, 1167, N'935e1234-77f7-4f48-ab65-b6245515c023', 50, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[cmsPropertyData] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyType] ON 

INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (6, 1043, 1032, 3, N'umbracoFile', N'Upload image', 0, 0, NULL, NULL, N'00000006-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (7, -92, 1032, 3, N'umbracoWidth', N'Width', 0, 0, NULL, NULL, N'00000007-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (8, -92, 1032, 3, N'umbracoHeight', N'Height', 0, 0, NULL, NULL, N'00000008-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (9, -92, 1032, 3, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'00000009-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (10, -92, 1032, 3, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'0000000a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (24, -90, 1033, 4, N'umbracoFile', N'Upload file', 0, 0, NULL, NULL, N'00000018-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (25, -92, 1033, 4, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'00000019-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (26, -92, 1033, 4, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'0000001a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (27, -96, 1031, 5, N'contents', N'Contents:', 0, 0, NULL, NULL, N'0000001b-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (28, -89, 1044, 11, N'umbracoMemberComments', N'Comments', 0, 0, NULL, NULL, N'0000001c-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (29, -92, 1044, 11, N'umbracoMemberFailedPasswordAttempts', N'Failed Password Attempts', 1, 0, NULL, NULL, N'0000001d-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (30, -49, 1044, 11, N'umbracoMemberApproved', N'Is Approved', 2, 0, NULL, NULL, N'0000001e-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (31, -49, 1044, 11, N'umbracoMemberLockedOut', N'Is Locked Out', 3, 0, NULL, NULL, N'0000001f-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (32, -92, 1044, 11, N'umbracoMemberLastLockoutDate', N'Last Lockout Date', 4, 0, NULL, NULL, N'00000020-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (33, -92, 1044, 11, N'umbracoMemberLastLogin', N'Last Login Date', 5, 0, NULL, NULL, N'00000021-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (34, -92, 1044, 11, N'umbracoMemberLastPasswordChangeDate', N'Last Password Change Date', 6, 0, NULL, NULL, N'00000022-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (35, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalAnswer', N'Password Answer', 0, 0, NULL, NULL, N'fb85465f-b141-4f94-8700-70fd284d5287')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (36, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalQuestion', N'Password Question', 1, 0, NULL, NULL, N'9c2a45fd-ed8a-49ae-8f76-ba6309a0d2b3')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (39, 1048, 1057, 14, N'favicon', N'Favicon', 0, 0, NULL, NULL, N'a9932505-4d69-4e31-9676-202c447a99e7')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (40, 1048, 1057, 14, N'siteLogo', N'Site logo', 1, 0, NULL, NULL, N'bc09040d-bfa3-4e56-b843-084f7d760fcb')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (41, -88, 1057, 14, N'siteName', N'Site name', 2, 0, NULL, NULL, N'96728033-efb6-4b83-aaff-f83251885389')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (42, 1058, 1057, 15, N'socialNetwork', N'Social network', 0, 0, NULL, NULL, N'196eb11a-bf2f-46e1-96aa-a0ef2ee2524e')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (49, 1069, 1044, 11, N'securityStamp', N'Security Stamp', 7, 0, NULL, NULL, N'fc84411a-81e5-4bf1-8971-b07124c9fb1b')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (50, -88, 1057, 15, N'googleAnalyticsId', N'Google Analytics Id', 1, 0, NULL, NULL, N'f8261567-eca5-4806-b3b0-e88972384501')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (57, 1105, 1044, 11, N'emailConfirmationToken', N'Email Confirmation Token', 8, 0, NULL, NULL, N'0aebd228-bfd2-4120-969d-86f3dbd83103')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (63, -88, 1122, 22, N'browserTitle', N'Browser Title', 0, 0, NULL, NULL, N'15d767e3-cbbd-4d2e-9f12-6351d62aec09')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (64, 1121, 1122, 22, N'seoMetaDescription', N'Description', 1, 0, NULL, N'A brief description of the content on your page. This text is shown below the title in a google search result and also used for Social Sharing Cards. The ideal length is between 130 and 155 characters', N'facf0431-c5e2-49ec-8f4f-c4b477b6e4d1')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (65, 1041, 1122, 22, N'keywords', N'Keywords', 2, 0, NULL, N'Keywords that describe the content of the page. This is consired optional since most modern search engines don''t use this anymore', N'c94bf977-216c-48ce-84ad-9038c45a49e3')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (66, 1048, 1122, 22, N'socialImageSharing', N'Social Image Sharing', 3, 0, NULL, NULL, N'4659bca1-d601-4629-84df-9a5c75913d8a')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (67, -49, 1122, 22, N'excludeFromTopNavigation', N'Exclude From Top Navigation', 4, 0, NULL, NULL, N'ab5b68d5-2ced-4809-a7a2-8ecaa82f7b1e')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (68, -49, 1044, 11, N'isEmailConfirmed', N'Is Email Confirmed', 9, 0, NULL, NULL, N'ca3dc6d8-7c59-430e-b773-29ca33338d3f')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (69, -88, 1123, 23, N'title', N'Title', 0, 0, NULL, NULL, N'1169de73-1104-43e7-be36-7b33a0f325f5')
SET IDENTITY_INSERT [dbo].[cmsPropertyType] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] ON 

INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (3, 1032, N'Image', 1, N'79ed4d07-254a-42cf-8fa9-ebe1c116a596')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (4, 1033, N'File', 1, N'50899f9c-023a-4466-b623-aba9049885fe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (5, 1031, N'Contents', 1, N'79995fa2-63ee-453c-a29b-2e66f324cdbe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (11, 1044, N'Membership', 1, N'0756729d-d665-46e3-b84a-37aceaa614f8')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (14, 1057, N'Site Info', 0, N'c7843f22-509c-4ff6-8674-0f3897fd18da')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (15, 1057, N'External Config', 1, N'dd4a7615-e624-4732-9dd3-f5a04c774293')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (22, 1122, N'Navigation & SEO', 9, N'31cd4b82-b1fb-4403-a5b6-e8d65ff92c9e')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (23, 1123, N'Content', 10, N'fc0242c5-aa94-4268-ab4e-e328c1ff3556')
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] OFF
SET IDENTITY_INSERT [dbo].[cmsTaskType] ON 

INSERT [dbo].[cmsTaskType] ([id], [alias]) VALUES (1, N'toTranslate')
SET IDENTITY_INSERT [dbo].[cmsTaskType] OFF
SET IDENTITY_INSERT [dbo].[cmsTemplate] ON 

INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (3, 1062, N'Master', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = null;
}

@* the fun starts here *@

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (4, 1063, N'Home', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.Home>
@using ContentModels = Umbraco.Web.PublishedContentModels;
@{
	Layout = "Master.cshtml";
}

Hello')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (5, 1070, N'Account', N'@using UmbracoTemplate.Models.UmbracoIdentity
@inherits UmbracoTemplatePage
@{
    Layout = "Master.cshtml";
}

<div class="row">
    <div class="small-12 columns">
        <h2>Account</h2>
    </div>
</div>


@if (User.Identity.IsAuthenticated)
{
    <div class="row">
        <div class="small-12 columns">
            @Html.Partial("~/Views/UmbracoIdentityAccount/LoginStatus.cshtml", Model)
        </div>
    </div>

    <div class="row">
        <div class="small-12 columns">
            @Html.Partial("~/Views/UmbracoIdentityAccount/Profile.cshtml", Model)
        </div>
    </div>
}
else
{
    <div class="row">
        <div class="small-6 columns">
            @Html.Partial("~/Views/UmbracoIdentityAccount/Login.cshtml", Model)
        </div>
        <div class="small-6 columns">
            @Html.Partial("~/Views/UmbracoIdentityAccount/ExternalLoginsList.cshtml", new ExternalLoginListViewModel { Action = "ExternalLogin" })
        </div>
    </div>
    <div class="row">
        <div class="small-12 columns">
            @Html.Partial("~/Views/UmbracoIdentityAccount/Register.cshtml", Model)
        </div>
    </div>
}
')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (7, 1077, N'Register', N'@{
	Layout = "Master.cshtml";
}

                ')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (8, 1082, N'Login', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@* the fun starts here *@

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (9, 1083, N'Contact', N'@{
	Layout = "Master.cshtml";
}')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (10, 1119, N'ConfirmEmail', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@* the fun starts here *@

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (11, 1143, N'ForgotPassword', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@* the fun starts here *@

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (12, 1146, N'ResetPassword', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@* the fun starts here *@

')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (13, 1154, N'ExternalLoginConfirmation', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "Master.cshtml";
}

@* the fun starts here *@

')
SET IDENTITY_INSERT [dbo].[cmsTemplate] OFF
SET IDENTITY_INSERT [dbo].[ExternalLogins] ON 

INSERT [dbo].[ExternalLogins] ([ExternalLoginId], [UserId], [LoginProvider], [ProviderKey]) VALUES (4, 1157, N'Facebook', N'1405811139537361')
SET IDENTITY_INSERT [dbo].[ExternalLogins] OFF
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] ON 

INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (243, CAST(N'2017-09-17 01:36:17.520' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1123,\"PropertyTypeIds\":[69],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P5676/D2] 401DFA50244E422A9E3492CCE7806A8E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (244, CAST(N'2017-09-17 01:45:00.833' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1128]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1128]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P5676/D6] B5EF62818B784BDAA3FCE397611A16F9')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (245, CAST(N'2017-09-17 01:45:13.010' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1158]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1158]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P5676/D6] B5EF62818B784BDAA3FCE397611A16F9')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (246, CAST(N'2017-09-17 03:02:03.683' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1158,1159,1166,1160,1161,1162,1163,1164,1165]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P2624/D2] A144D3B928F142A78BFE6ADBEB236471')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1243, CAST(N'2017-09-18 02:55:00.800' AS DateTime), N'[{"RefreshType":3,"RefresherId":"e057af6d-2ee6-41f4-8045-3694010f0aa6","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1]","JsonPayload":null},{"RefreshType":3,"RefresherId":"e057af6d-2ee6-41f4-8045-3694010f0aa6","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P5500/D4] E4640C9478AB4623BF7DD165D2E95C81')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1244, CAST(N'2017-09-18 03:20:09.673' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1123,\"PropertyTypeIds\":[69],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1245, CAST(N'2017-09-18 03:20:54.180' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1066]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1066]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1246, CAST(N'2017-09-18 03:21:42.833' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1167]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1247, CAST(N'2017-09-18 03:21:48.763' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1167]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1248, CAST(N'2017-09-18 03:22:28.957' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"settings\",\"Id\":1057,\"PropertyTypeIds\":[39,40,41,42,50],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1249, CAST(N'2017-09-18 03:22:44.500' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1066]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1066]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1250, CAST(N'2017-09-18 03:22:58.657' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1167]","JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1167]","JsonPayload":null}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P15140/D2] 6EBAC8D0C7C84079B0BED5DC10B8117E')
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated]) VALUES (1251, CAST(N'2017-09-18 03:27:06.280' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonPayload":"[{\"Alias\":\"settings\",\"Id\":1057,\"PropertyTypeIds\":[39,40,41,42,50],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT [P7916/D2] 7335C60FF65547D3A6DCCACCDE67BF0D')
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] OFF
SET IDENTITY_INSERT [dbo].[umbracoDomains] ON 

INSERT [dbo].[umbracoDomains] ([id], [domainDefaultLanguage], [domainRootStructureID], [domainName]) VALUES (1, 2, 1158, N'*1158')
SET IDENTITY_INSERT [dbo].[umbracoDomains] OFF
SET IDENTITY_INSERT [dbo].[umbracoLanguage] ON 

INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (1, N'en-US', N'en-US')
INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (2, N'vi-VN', N'Vietnamese (Vietnam)')
SET IDENTITY_INSERT [dbo].[umbracoLanguage] OFF
SET IDENTITY_INSERT [dbo].[umbracoLock] ON 

INSERT [dbo].[umbracoLock] ([id], [value], [name]) VALUES (-331, -1, N'Servers')
SET IDENTITY_INSERT [dbo].[umbracoLock] OFF
SET IDENTITY_INSERT [dbo].[umbracoLog] ON 

INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1, 0, 1051, CAST(N'2017-09-04 23:56:35.653' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (2, 0, 1051, CAST(N'2017-09-05 08:19:05.570' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (3, 0, 1051, CAST(N'2017-09-05 08:19:43.393' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (4, 0, 0, CAST(N'2017-09-05 08:19:48.473' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (5, 0, 0, CAST(N'2017-09-05 08:20:01.340' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (6, 0, 0, CAST(N'2017-09-05 08:20:39.413' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (7, 0, 1051, CAST(N'2017-09-05 08:20:45.297' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (8, 0, 1052, CAST(N'2017-09-05 08:32:01.403' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (9, 0, 0, CAST(N'2017-09-05 08:43:15.717' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (10, 0, 1055, CAST(N'2017-09-05 08:43:15.920' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (11, 0, 1051, CAST(N'2017-09-05 08:43:32.517' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (12, 0, 1055, CAST(N'2017-09-05 08:44:04.000' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (13, 0, 0, CAST(N'2017-09-05 08:44:08.870' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (14, 0, 0, CAST(N'2017-09-05 08:44:13.473' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (15, 0, 1052, CAST(N'2017-09-05 08:59:30.607' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (16, 0, 1052, CAST(N'2017-09-05 08:59:30.630' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (17, 0, 1052, CAST(N'2017-09-05 08:59:31.077' AS DateTime), N'Delete', N'Trashed content with Id: ''1052'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (18, 0, 1056, CAST(N'2017-09-05 08:59:35.993' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (19, 0, 1056, CAST(N'2017-09-05 08:59:36.000' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (20, 0, 1056, CAST(N'2017-09-05 08:59:36.043' AS DateTime), N'Delete', N'Trashed content with Id: ''1056'' related to original parent content with Id: ''-1''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (21, 0, 1052, CAST(N'2017-09-05 08:59:48.227' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (22, 0, -1, CAST(N'2017-09-05 08:59:48.230' AS DateTime), N'Delete', N'Delete Content of Types 1051 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (23, 0, 1051, CAST(N'2017-09-05 08:59:48.343' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (24, 0, 1056, CAST(N'2017-09-05 08:59:53.327' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (25, 0, -1, CAST(N'2017-09-05 08:59:53.330' AS DateTime), N'Delete', N'Delete Content of Types 1055 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (26, 0, 1055, CAST(N'2017-09-05 08:59:53.337' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (27, 0, 1053, CAST(N'2017-09-05 09:00:06.880' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (28, 0, 1054, CAST(N'2017-09-05 09:00:09.983' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (29, 0, -1, CAST(N'2017-09-05 09:02:19.747' AS DateTime), N'PackagerInstall', N'Package ''Archetype'' installed. Package guid: c745c531-7205-4b57-8655-df22cfd0dec9')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (30, 0, -1, CAST(N'2017-09-05 09:02:36.640' AS DateTime), N'Save', N'Save ContentTypes performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (31, 0, 1057, CAST(N'2017-09-05 09:23:27.253' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (32, 0, 0, CAST(N'2017-09-05 09:46:35.000' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (33, 0, 1057, CAST(N'2017-09-05 09:46:50.593' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (34, 0, 0, CAST(N'2017-09-05 09:53:04.623' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (35, 0, 0, CAST(N'2017-09-05 09:53:48.187' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (36, 0, 1061, CAST(N'2017-09-05 09:57:44.750' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (37, 0, 0, CAST(N'2017-09-05 09:58:51.853' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (38, 0, 0, CAST(N'2017-09-05 10:03:07.073' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (39, 0, 1064, CAST(N'2017-09-05 10:03:07.233' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (40, 0, 1063, CAST(N'2017-09-05 10:03:26.590' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (41, 0, 1063, CAST(N'2017-09-05 10:03:35.373' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (42, 0, 1063, CAST(N'2017-09-05 10:03:35.523' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (43, 0, 1063, CAST(N'2017-09-05 10:03:37.783' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (44, 0, 1064, CAST(N'2017-09-05 10:03:51.343' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (45, 0, 0, CAST(N'2017-09-05 10:03:56.597' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (46, 0, 0, CAST(N'2017-09-05 10:04:30.600' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (47, 0, 0, CAST(N'2017-09-05 10:04:34.720' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (48, 0, 0, CAST(N'2017-09-05 10:04:41.597' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (49, 0, 1066, CAST(N'2017-09-05 10:40:06.933' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (50, 0, 1065, CAST(N'2017-09-05 15:46:00.223' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (51, 0, 0, CAST(N'2017-09-07 08:34:49.043' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (52, 0, 1067, CAST(N'2017-09-07 08:35:32.127' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (53, 0, 0, CAST(N'2017-09-07 08:39:31.830' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (54, 0, 0, CAST(N'2017-09-07 08:40:39.730' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (55, 0, 1069, CAST(N'2017-09-07 08:41:02.393' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (56, 0, 0, CAST(N'2017-09-07 08:41:55.853' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (57, 0, 1071, CAST(N'2017-09-07 08:41:55.917' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (58, 0, 1064, CAST(N'2017-09-07 08:43:42.013' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (59, 0, 0, CAST(N'2017-09-07 08:43:48.133' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (60, 0, 0, CAST(N'2017-09-07 08:44:02.640' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (61, 0, 1072, CAST(N'2017-09-07 20:03:54.123' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (62, 0, 1072, CAST(N'2017-09-07 20:03:54.140' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (63, 0, 1072, CAST(N'2017-09-07 20:03:54.263' AS DateTime), N'Delete', N'Trashed content with Id: ''1072'' related to original parent content with Id: ''1065''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (64, 0, 1071, CAST(N'2017-09-07 20:04:14.830' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (65, 0, 1071, CAST(N'2017-09-07 20:06:17.627' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (66, 0, 1071, CAST(N'2017-09-07 20:06:25.887' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (67, 0, 0, CAST(N'2017-09-07 20:08:02.530' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (68, 0, 1076, CAST(N'2017-09-07 20:08:02.583' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (69, 0, 0, CAST(N'2017-09-07 20:11:30.550' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (70, 0, 1078, CAST(N'2017-09-07 20:11:30.597' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (71, 0, 1071, CAST(N'2017-09-07 20:11:54.293' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (72, 0, 0, CAST(N'2017-09-07 20:12:53.793' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (73, 0, 0, CAST(N'2017-09-07 20:13:04.650' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (74, 0, 0, CAST(N'2017-09-07 20:13:10.627' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (75, 0, 0, CAST(N'2017-09-07 20:13:14.930' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (76, 0, 0, CAST(N'2017-09-07 20:13:19.600' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (77, 0, 0, CAST(N'2017-09-07 20:13:30.763' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (78, 0, 1075, CAST(N'2017-09-08 08:33:25.617' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (79, 0, 0, CAST(N'2017-09-08 08:34:50.980' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (80, 0, 1076, CAST(N'2017-09-08 08:35:29.297' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (81, 0, 1080, CAST(N'2017-09-08 08:35:43.617' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (82, 0, 1057, CAST(N'2017-09-08 09:15:03.117' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (83, 0, 0, CAST(N'2017-09-08 16:45:15.863' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (84, 0, 1084, CAST(N'2017-09-08 16:45:15.983' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (85, 0, 1064, CAST(N'2017-09-08 16:45:33.597' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (86, 0, 1084, CAST(N'2017-09-08 16:46:12.813' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (87, 0, 0, CAST(N'2017-09-08 16:46:23.920' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (88, 0, 0, CAST(N'2017-09-08 16:47:37.227' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (89, 0, 0, CAST(N'2017-09-08 16:47:45.497' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (90, 0, 1083, CAST(N'2017-09-08 16:48:06.217' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (91, 0, 1083, CAST(N'2017-09-08 16:48:20.560' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (92, 0, 1083, CAST(N'2017-09-08 16:48:37.423' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (93, 0, 1079, CAST(N'2017-09-09 10:18:49.800' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (94, 0, 1079, CAST(N'2017-09-09 10:19:24.407' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (95, 0, 1079, CAST(N'2017-09-09 10:22:12.837' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (96, 0, 1079, CAST(N'2017-09-09 10:29:18.947' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (97, 0, 1088, CAST(N'2017-09-09 10:36:34.813' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (98, 0, 1088, CAST(N'2017-09-09 10:39:31.607' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (99, 0, 1088, CAST(N'2017-09-09 10:41:31.063' AS DateTime), N'Save', N'Save ContentType performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (100, 0, 1061, CAST(N'2017-09-09 10:43:53.193' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (101, 0, 1084, CAST(N'2017-09-09 10:44:36.697' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (102, 0, 1064, CAST(N'2017-09-09 10:44:49.563' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (103, 0, 1088, CAST(N'2017-09-09 10:45:02.017' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (104, 0, 1064, CAST(N'2017-09-09 10:45:28.793' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (105, 0, 1079, CAST(N'2017-09-09 10:45:49.883' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (106, 0, 1085, CAST(N'2017-09-09 10:45:54.997' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (107, 0, 1065, CAST(N'2017-09-09 10:45:59.643' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (108, 0, 1061, CAST(N'2017-09-09 10:55:02.277' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (109, 0, 1061, CAST(N'2017-09-09 10:55:14.113' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (110, 0, 1082, CAST(N'2017-09-09 10:57:52.730' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (111, 0, 1070, CAST(N'2017-09-09 10:58:00.320' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (112, 0, 1077, CAST(N'2017-09-09 10:58:06.643' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (113, 0, 0, CAST(N'2017-09-09 10:59:07.190' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (114, 0, 1071, CAST(N'2017-09-09 10:59:10.837' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (115, 0, 1071, CAST(N'2017-09-09 10:59:40.067' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (116, 0, 1072, CAST(N'2017-09-09 11:00:14.767' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (117, 0, 1079, CAST(N'2017-09-09 11:00:14.863' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (118, 0, 1080, CAST(N'2017-09-09 11:00:15.027' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (119, 0, 1080, CAST(N'2017-09-09 11:00:15.033' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (120, 0, 1081, CAST(N'2017-09-09 11:00:15.050' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (121, 0, 1081, CAST(N'2017-09-09 11:00:15.063' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (122, 0, 1079, CAST(N'2017-09-09 11:00:15.070' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (123, 0, 1080, CAST(N'2017-09-09 11:00:15.080' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (124, 0, 1081, CAST(N'2017-09-09 11:00:15.090' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (125, 0, -1, CAST(N'2017-09-09 11:00:15.090' AS DateTime), N'Delete', N'Delete Content of Types 1071,1076,1078 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (126, 0, 1071, CAST(N'2017-09-09 11:00:15.183' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (127, 0, 1090, CAST(N'2017-09-09 11:01:31.460' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (128, 0, 1090, CAST(N'2017-09-09 11:01:41.120' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (129, 0, 1091, CAST(N'2017-09-09 11:02:45.647' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (130, 0, 1092, CAST(N'2017-09-09 11:04:26.597' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (131, 0, 1064, CAST(N'2017-09-09 11:04:39.237' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (132, 0, 1090, CAST(N'2017-09-09 11:04:58.520' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (133, 0, 0, CAST(N'2017-09-09 11:05:06.730' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (134, 0, 0, CAST(N'2017-09-09 11:05:11.273' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (135, 0, 0, CAST(N'2017-09-09 11:05:14.040' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (136, 0, 0, CAST(N'2017-09-09 11:05:19.293' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (137, 0, 0, CAST(N'2017-09-09 11:05:32.340' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (138, 0, 0, CAST(N'2017-09-09 11:05:40.727' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (139, 0, 1095, CAST(N'2017-09-09 11:05:59.887' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (140, 0, 1095, CAST(N'2017-09-09 11:06:04.907' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (141, 0, 1093, CAST(N'2017-09-09 11:06:09.820' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (142, 0, 1093, CAST(N'2017-09-09 11:07:48.640' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (143, 0, 1093, CAST(N'2017-09-09 11:10:45.607' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (144, 0, 1094, CAST(N'2017-09-09 11:10:45.807' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (145, 0, 1094, CAST(N'2017-09-09 11:10:45.860' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (146, 0, 1095, CAST(N'2017-09-09 11:10:45.877' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (147, 0, 1095, CAST(N'2017-09-09 11:10:45.883' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (148, 0, 1093, CAST(N'2017-09-09 11:10:45.890' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (149, 0, 1094, CAST(N'2017-09-09 11:10:45.900' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (150, 0, 1095, CAST(N'2017-09-09 11:10:45.907' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (151, 0, -1, CAST(N'2017-09-09 11:10:45.907' AS DateTime), N'Delete', N'Delete Content of Types 1090,1091,1092 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (152, 0, 1090, CAST(N'2017-09-09 11:10:46.003' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (153, 0, 1096, CAST(N'2017-09-09 11:11:37.460' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (154, 0, 1097, CAST(N'2017-09-09 11:12:21.990' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (155, 0, 1096, CAST(N'2017-09-09 11:12:34.180' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (156, 0, 1097, CAST(N'2017-09-09 11:12:43.060' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (157, 0, 1064, CAST(N'2017-09-09 11:13:37.257' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (158, 0, 0, CAST(N'2017-09-09 11:13:43.293' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (159, 0, 0, CAST(N'2017-09-09 11:13:48.737' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (160, 0, 0, CAST(N'2017-09-09 11:13:51.710' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (161, 0, 0, CAST(N'2017-09-09 11:13:56.990' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (162, 0, 1098, CAST(N'2017-09-09 11:17:26.027' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (163, 0, 1097, CAST(N'2017-09-09 11:17:48.280' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (164, 0, 1099, CAST(N'2017-09-09 11:17:55.367' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (165, 0, 1099, CAST(N'2017-09-09 11:17:58.310' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (166, 0, 1100, CAST(N'2017-09-09 16:12:01.343' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (167, 0, 1070, CAST(N'2017-09-09 16:12:13.303' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (168, 0, 1064, CAST(N'2017-09-09 16:12:34.810' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (169, 0, 0, CAST(N'2017-09-09 16:12:40.613' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (170, 0, 0, CAST(N'2017-09-09 16:12:45.453' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (171, 0, 0, CAST(N'2017-09-10 20:39:33.157' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (172, 0, 1100, CAST(N'2017-09-10 22:14:12.303' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (173, 0, 1100, CAST(N'2017-09-10 22:14:27.087' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (174, 0, 1098, CAST(N'2017-09-10 22:15:27.713' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (175, 0, 1098, CAST(N'2017-09-10 22:15:27.813' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (176, 0, -1, CAST(N'2017-09-10 22:15:27.817' AS DateTime), N'Delete', N'Delete Content of Types 1096 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (177, 0, 1096, CAST(N'2017-09-10 22:15:27.947' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (178, 0, 1099, CAST(N'2017-09-10 22:15:34.210' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (179, 0, 1099, CAST(N'2017-09-10 22:15:34.223' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (180, 0, -1, CAST(N'2017-09-10 22:15:34.223' AS DateTime), N'Delete', N'Delete Content of Types 1097 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (181, 0, 1097, CAST(N'2017-09-10 22:15:34.230' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (182, 0, 1110, CAST(N'2017-09-10 22:16:24.403' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (183, 0, 1110, CAST(N'2017-09-10 22:16:36.457' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (184, 0, 1101, CAST(N'2017-09-10 22:22:59.287' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (185, 0, 1101, CAST(N'2017-09-10 22:22:59.360' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (186, 0, -1, CAST(N'2017-09-10 22:22:59.360' AS DateTime), N'Delete', N'Delete Content of Types 1100,1110 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (187, 0, 1100, CAST(N'2017-09-10 22:22:59.473' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (188, 0, 1111, CAST(N'2017-09-10 22:23:13.403' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (189, 0, 1112, CAST(N'2017-09-10 22:24:20.733' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (190, 0, 0, CAST(N'2017-09-10 22:38:31.767' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (191, 0, -1, CAST(N'2017-09-10 22:40:48.933' AS DateTime), N'Delete', N'Delete Content of Types 1088 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (192, 0, 1088, CAST(N'2017-09-10 22:40:49.043' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (193, 0, 1061, CAST(N'2017-09-10 22:40:55.333' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (194, 0, 1061, CAST(N'2017-09-10 22:41:22.537' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (195, 0, 1061, CAST(N'2017-09-10 22:41:26.507' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (196, 0, 1111, CAST(N'2017-09-10 22:42:18.743' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (197, 0, 1112, CAST(N'2017-09-10 22:42:27.853' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (198, 0, 1112, CAST(N'2017-09-10 22:42:37.960' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (199, 0, 1116, CAST(N'2017-09-10 22:43:04.373' AS DateTime), N'Save', N'Save ContentType performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (200, 0, 1117, CAST(N'2017-09-10 22:45:05.280' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (201, 0, 0, CAST(N'2017-09-10 22:51:40.840' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (202, 0, 1117, CAST(N'2017-09-10 22:51:49.733' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (203, 0, 1057, CAST(N'2017-09-10 23:06:47.483' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (204, 0, 1061, CAST(N'2017-09-10 23:17:18.270' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (205, 0, 0, CAST(N'2017-09-10 23:21:16.717' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (206, 0, 1122, CAST(N'2017-09-10 23:22:49.493' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (207, 0, 1065, CAST(N'2017-09-10 23:25:32.913' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (208, 0, 1085, CAST(N'2017-09-10 23:25:33.087' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (209, 0, 1085, CAST(N'2017-09-10 23:25:33.153' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (210, 0, 1065, CAST(N'2017-09-10 23:25:33.163' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (211, 0, 1085, CAST(N'2017-09-10 23:25:33.173' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (212, 0, -1, CAST(N'2017-09-10 23:25:33.173' AS DateTime), N'Delete', N'Delete Content of Types 1061,1111,1117,1112,1116,1084,1064 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (213, 0, 1061, CAST(N'2017-09-10 23:25:33.337' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (214, 0, 1123, CAST(N'2017-09-10 23:25:48.317' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (215, 0, 1123, CAST(N'2017-09-10 23:26:44.500' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (216, 0, 1124, CAST(N'2017-09-10 23:28:17.680' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (217, 0, 1125, CAST(N'2017-09-10 23:30:02.277' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (218, 0, 1126, CAST(N'2017-09-10 23:30:26.163' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (219, 0, 1127, CAST(N'2017-09-10 23:33:28.183' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (220, 0, 1125, CAST(N'2017-09-10 23:33:52.280' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (221, 0, 1123, CAST(N'2017-09-10 23:34:12.153' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (222, 0, 0, CAST(N'2017-09-10 23:34:19.110' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (223, 0, 0, CAST(N'2017-09-10 23:34:25.060' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (224, 0, 0, CAST(N'2017-09-10 23:35:27.447' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (225, 0, 0, CAST(N'2017-09-10 23:35:41.453' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (226, 0, 0, CAST(N'2017-09-10 23:35:47.057' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (227, 0, 0, CAST(N'2017-09-10 23:35:50.717' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (228, 0, 0, CAST(N'2017-09-10 23:35:59.890' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (229, 0, 0, CAST(N'2017-09-10 23:37:04.060' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (230, 0, 0, CAST(N'2017-09-10 23:37:13.060' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (231, 0, 0, CAST(N'2017-09-10 23:37:16.047' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (232, 0, 0, CAST(N'2017-09-10 23:37:22.250' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (233, 0, 1133, CAST(N'2017-09-10 23:38:37.840' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (234, 0, 1125, CAST(N'2017-09-10 23:38:46.763' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (235, 0, 0, CAST(N'2017-09-10 23:38:52.663' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (236, 0, 0, CAST(N'2017-09-10 23:38:58.197' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (237, 0, 0, CAST(N'2017-09-11 08:42:45.847' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (238, 0, 1144, CAST(N'2017-09-11 08:44:31.447' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (239, 0, 1125, CAST(N'2017-09-11 08:44:40.473' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (240, 0, 0, CAST(N'2017-09-11 08:44:49.187' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (241, 0, 0, CAST(N'2017-09-11 08:44:53.530' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (242, 0, 0, CAST(N'2017-09-11 09:06:21.663' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (243, 0, 1147, CAST(N'2017-09-11 09:07:12.663' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (244, 0, 1147, CAST(N'2017-09-11 09:07:37.347' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (245, 0, 1125, CAST(N'2017-09-11 09:07:54.940' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (246, 0, 0, CAST(N'2017-09-11 09:08:06.943' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (247, 0, 0, CAST(N'2017-09-11 09:08:13.450' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (248, 0, 1153, CAST(N'2017-09-12 11:58:48.990' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (249, 0, 0, CAST(N'2017-09-12 11:59:06.153' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (250, 0, 1153, CAST(N'2017-09-12 11:59:13.073' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (251, 0, 1125, CAST(N'2017-09-12 11:59:30.387' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (252, 0, 0, CAST(N'2017-09-12 11:59:37.307' AS DateTime), N'New', N'Content '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (253, 0, 0, CAST(N'2017-09-12 11:59:50.927' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (254, 0, 1129, CAST(N'2017-09-12 14:05:00.540' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (255, 0, 1131, CAST(N'2017-09-16 00:00:10.923' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (256, 0, 1132, CAST(N'2017-09-16 00:00:10.937' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (257, 0, 1134, CAST(N'2017-09-16 00:00:10.950' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (258, 0, 1145, CAST(N'2017-09-16 00:00:10.960' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (259, 0, 1148, CAST(N'2017-09-16 00:00:10.973' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (260, 0, 1155, CAST(N'2017-09-16 00:00:10.987' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (261, 0, 1129, CAST(N'2017-09-16 00:00:10.987' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (262, 0, 1130, CAST(N'2017-09-16 00:00:10.997' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (263, 0, 1128, CAST(N'2017-09-16 00:00:11.000' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (264, 0, 1160, CAST(N'2017-09-16 00:00:11.157' AS DateTime), N'Copy', N'Copied content with Id: ''1160'' related to original content with Id: ''1131''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (265, 0, 1161, CAST(N'2017-09-16 00:00:11.173' AS DateTime), N'Copy', N'Copied content with Id: ''1161'' related to original content with Id: ''1132''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (266, 0, 1162, CAST(N'2017-09-16 00:00:11.200' AS DateTime), N'Copy', N'Copied content with Id: ''1162'' related to original content with Id: ''1134''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (267, 0, 1163, CAST(N'2017-09-16 00:00:11.303' AS DateTime), N'Copy', N'Copied content with Id: ''1163'' related to original content with Id: ''1145''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (268, 0, 1164, CAST(N'2017-09-16 00:00:11.320' AS DateTime), N'Copy', N'Copied content with Id: ''1164'' related to original content with Id: ''1148''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (269, 0, 1165, CAST(N'2017-09-16 00:00:11.333' AS DateTime), N'Copy', N'Copied content with Id: ''1165'' related to original content with Id: ''1155''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (270, 0, 1159, CAST(N'2017-09-16 00:00:11.353' AS DateTime), N'Copy', N'Copied content with Id: ''1159'' related to original content with Id: ''1129''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (271, 0, 1166, CAST(N'2017-09-16 00:00:11.370' AS DateTime), N'Copy', N'Copied content with Id: ''1166'' related to original content with Id: ''1130''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (272, 0, 1158, CAST(N'2017-09-16 00:00:11.383' AS DateTime), N'Copy', N'Copied content with Id: ''1158'' related to original content with Id: ''1128''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (273, 0, 0, CAST(N'2017-09-16 00:00:27.420' AS DateTime), N'Sort', N'Sorting content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (274, 0, 0, CAST(N'2017-09-16 00:01:21.917' AS DateTime), N'Save', N'Save Language performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (275, 0, 1158, CAST(N'2017-09-16 00:01:36.233' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (276, 0, 1123, CAST(N'2017-09-17 08:36:17.213' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (277, 0, 1128, CAST(N'2017-09-17 08:45:00.460' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (278, 0, 1158, CAST(N'2017-09-17 08:45:12.923' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (279, 0, 1158, CAST(N'2017-09-17 10:02:01.543' AS DateTime), N'Publish', N'Publish with Children performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1277, 0, 1123, CAST(N'2017-09-18 10:20:09.250' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1278, 0, 1066, CAST(N'2017-09-18 10:20:53.490' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1279, 0, 1066, CAST(N'2017-09-18 10:20:53.590' AS DateTime), N'Move', N'Move Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1280, 0, 1066, CAST(N'2017-09-18 10:21:42.613' AS DateTime), N'Copy', N'Copy Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1281, 0, 1167, CAST(N'2017-09-18 10:21:42.780' AS DateTime), N'Copy', N'Copied content with Id: ''1167'' related to original content with Id: ''1066''')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1282, 0, 1167, CAST(N'2017-09-18 10:21:48.313' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1283, 0, 1057, CAST(N'2017-09-18 10:22:28.793' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1284, 0, 1066, CAST(N'2017-09-18 10:22:44.040' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1285, 0, 1167, CAST(N'2017-09-18 10:22:58.253' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1286, 0, 1057, CAST(N'2017-09-18 10:27:06.140' AS DateTime), N'Save', N'Save ContentType performed by user')
SET IDENTITY_INSERT [dbo].[umbracoLog] OFF
SET IDENTITY_INSERT [dbo].[umbracoMigration] ON 

INSERT [dbo].[umbracoMigration] ([id], [name], [createDate], [version]) VALUES (1, N'Umbraco', CAST(N'2017-09-04 13:13:59.800' AS DateTime), N'7.6.5')
SET IDENTITY_INSERT [dbo].[umbracoMigration] OFF
SET IDENTITY_INSERT [dbo].[umbracoNode] ON 

INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-97, 0, -1, 0, 1, N'-1,-97', 2, N'aa2c52a0-ce87-4e65-a47c-7df09358585d', N'List View - Members', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.870' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-96, 0, -1, 0, 1, N'-1,-96', 2, N'3a0156c4-3b8c-4803-bdc1-6871faa83fff', N'List View - Media', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.870' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-95, 0, -1, 0, 1, N'-1,-95', 2, N'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4', N'List View - Content', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-92, 0, -1, 0, 1, N'-1,-92', 35, N'f0bc4bfb-b499-40d6-ba86-058885a5178c', N'Label', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-90, 0, -1, 0, 1, N'-1,-90', 34, N'84c6b441-31df-4ffe-b67e-67d5bc3ae65a', N'Upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-89, 0, -1, 0, 1, N'-1,-89', 33, N'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3', N'Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.860' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-88, 0, -1, 0, 1, N'-1,-88', 32, N'0cc0eba1-9960-42c9-bf9b-60e150b429ae', N'Textstring', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.860' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-87, 0, -1, 0, 1, N'-1,-87', 4, N'ca90c950-0aff-4e72-b976-a30b1ac57dad', N'Richtext editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.860' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-51, 0, -1, 0, 1, N'-1,-51', 2, N'2e6d3631-066e-44b8-aec4-96f09099b2b5', N'Numeric', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.860' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-49, 0, -1, 0, 1, N'-1,-49', 2, N'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49', N'True/false', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-43, 0, -1, 0, 1, N'-1,-43', 2, N'fbaf13a8-4036-41f2-93a3-974f678c312a', N'Checkbox list', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-42, 0, -1, 0, 1, N'-1,-42', 2, N'0b6a45e7-44ba-430d-9da5-4e46060b9e03', N'Dropdown', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-41, 0, -1, 0, 1, N'-1,-41', 2, N'5046194e-4237-453c-a547-15db3a07c4e1', N'Date Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-40, 0, -1, 0, 1, N'-1,-40', 2, N'bb5f57c9-ce2b-4bb9-b697-4caca783a805', N'Radiobox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-39, 0, -1, 0, 1, N'-1,-39', 2, N'f38f0ac7-1d27-439c-9f3f-089cd8825a53', N'Dropdown multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-37, 0, -1, 0, 1, N'-1,-37', 2, N'0225af17-b302-49cb-9176-b9f35cab9c17', N'Approved Color', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-36, 0, -1, 0, 1, N'-1,-36', 2, N'e4d66c0f-b935-4200-81f0-025f7256b89a', N'Date Picker with time', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-21, 0, -1, 0, 0, N'-1,-21', 0, N'bf7c7cbc-952f-4518-97a2-69e9c7b33842', N'Recycle Bin', N'cf3d8e34-1c1c-41e9-ae56-878b57b32113', CAST(N'2017-09-04 13:13:58.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-20, 0, -1, 0, 0, N'-1,-20', 0, N'0f582a79-1e41-4cf0-bfa0-76340651891a', N'Recycle Bin', N'01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8', CAST(N'2017-09-04 13:13:58.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-1, 0, -1, 0, 0, N'-1', 0, N'916724a5-173d-4619-b97e-b9de133dd6f5', N'SYSTEM DATA: umbraco master root', N'ea7d8624-4cfe-4578-a871-24aa946bf34d', CAST(N'2017-09-04 13:13:58.847' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1031, 0, -1, 0, 1, N'-1,1031', 2, N'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d', N'Folder', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2017-09-04 13:13:58.870' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1032, 0, -1, 0, 1, N'-1,1032', 2, N'cc07b313-0843-4aa8-bbda-871c8da728c8', N'Image', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2017-09-04 13:13:58.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1033, 0, -1, 0, 1, N'-1,1033', 2, N'4c52d8ab-54e6-40cd-999c-7a5f24903e4d', N'File', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2017-09-04 13:13:58.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1041, 0, -1, 0, 1, N'-1,1041', 2, N'b6b73142-b9c1-4bf8-a16d-e1c23320b549', N'Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1043, 0, -1, 0, 1, N'-1,1043', 2, N'1df9f033-e6d4-451f-b8d2-e0cbc50a836f', N'Image Cropper', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1044, 0, -1, 0, 1, N'-1,1044', 7, N'd59be02f-1df9-4228-aa1e-01917d806cda', N'Member', N'9b5416fb-e72f-45a9-a07b-5a9a2709ce43', CAST(N'2017-09-04 13:13:58.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1046, 0, -1, 0, 1, N'-1,1046', 2, N'fd1e0da5-5606-4862-b679-5d0cf3a52a59', N'Content Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1047, 0, -1, 0, 1, N'-1,1047', 2, N'1ea2e01f-ebd8-4ce1-8d71-6b1149e63548', N'Member Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1048, 0, -1, 0, 1, N'-1,1048', 2, N'135d60e0-64d9-49ed-ab08-893c9ba44ae5', N'Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1049, 0, -1, 0, 1, N'-1,1049', 2, N'9dbbcbbb-2327-434a-b355-af1b84e5010a', N'Multiple Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1050, 0, -1, 0, 1, N'-1,1050', 2, N'b4e3535a-1753-47e2-8568-602cf8cfee6f', N'Related Links', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-04 13:13:58.880' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1057, 0, 1120, 0, 2, N'-1,1120,1057', 15, N'7ef6ed81-c1cf-4bcf-bd2f-e09e7b16cfe0', N'Settings', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-05 09:23:27.177' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1058, 0, -1, 0, 1, N'-1,1058', 24, N'070a05d3-1926-4cca-8636-ea1972d0df8c', N'Settings - Social network - Archetype', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-05 09:46:34.933' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1059, 0, -1, 0, 1, N'-1,1059', 25, N'4923510d-1c6b-4706-8153-1e1bff65b11d', N'Layout - Meta Keywords - Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-05 09:53:04.583' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1060, 0, -1, 0, 1, N'-1,1060', 26, N'5f895cc6-0181-4c04-b62f-5758d1ec8aa0', N'Layout - Meta Description - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-05 09:53:48.150' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1062, 0, -1, NULL, 1, N'-1,1062', 0, N'ff29709c-4a39-4092-9b93-8152fedd7d4c', N'Master', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-05 09:58:51.820' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1063, 0, 1062, NULL, 1, N'-1,1062,1063', 0, N'96a6327e-2719-498d-824e-428c1e565483', N'Home', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-05 10:03:07.043' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1066, 0, 1128, 0, 2, N'-1,1128,1066', 2, N'49f4b0f3-b21f-4dbc-89d4-645db8c9aae7', N'Settings', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-05 10:04:41.567' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1067, 0, -1, 0, 1, N'-1,1067', 27, N'3a4e92a4-9fde-49e7-935f-35b341df8fb8', N'Member - Security Stamp - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-07 08:34:48.957' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1068, 0, -1, 0, 1, N'-1,1068', 28, N'785cb8c8-a516-4cd1-9f59-ef5b83f09c21', N'Member - Security Stamp - Textbox (1)', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-07 08:39:31.807' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1069, 0, -1, 0, 1, N'-1,1069', 29, N'b959721e-0442-41c3-ac79-b6c8fbda066d', N'Member - Security Stamp - Textbox (2)', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-07 08:40:39.690' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1070, 0, 1062, NULL, 1, N'-1,1062,1070', 0, N'e66ae621-0a2a-486e-bee5-bf64ba910fcc', N'Account', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-07 08:41:55.817' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1077, 0, 1062, NULL, 1, N'-1,1062,1077', 0, N'1fc1e445-a616-4c5c-89e6-6d33270dd34b', N'Register', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-07 20:11:30.517' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1082, 0, 1062, NULL, 1, N'-1,1062,1082', 0, N'cd5a089c-e2e4-4553-a8be-6525b98c4846', N'Login', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-08 08:34:50.943' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1083, 0, 1062, NULL, 1, N'-1,1062,1083', 0, N'4262f179-fd07-45d4-b56e-f212c67e6034', N'Contact', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-08 16:45:15.810' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1087, 0, -1, 0, 1, N'-1,1087', 0, N'786bb195-f181-4845-908a-bf8fa78bd81e', N'Controls', N'2f7a2769-6b0b-4468-90dd-af42d64f7f16', CAST(N'2017-09-09 10:31:07.783' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1089, 0, -1, 0, 1, N'-1,1089', 30, N'42b814ec-c497-42d4-8898-765a554d46de', N'Account - sdgsdg - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-09 10:59:07.137' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1105, 0, -1, 0, 1, N'-1,1105', 31, N'42fafc14-3bf6-4f25-9bbf-da349ee48d8b', N'Member - Email Confirmation Token - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-10 20:39:33.083' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1115, 0, -1, 0, 1, N'-1,1115', 32, N'd5f90857-3180-4d23-9a3c-04dadb4e7230', N'Layout - seoMetaDescription - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-10 22:38:31.713' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1119, 0, 1062, NULL, 1, N'-1,1062,1119', 0, N'd5926303-97f9-4e18-9bc8-a5c747a14662', N'Confirm Email', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-10 22:51:40.800' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1120, 0, -1, 0, 1, N'-1,1120', 0, N'523d15c2-6e48-4bb7-aaee-8b296a375c55', N'Pages', N'2f7a2769-6b0b-4468-90dd-af42d64f7f16', CAST(N'2017-09-10 23:09:27.000' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1121, 0, -1, 0, 1, N'-1,1121', 33, N'c065a6d7-170f-4133-a337-dffcbba130cf', N'Navigation Controls - seoMetaDescription - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2017-09-10 23:21:16.687' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1122, 0, 1087, 0, 2, N'-1,1087,1122', 0, N'43732676-a8b8-40b0-8ae9-95bd44587453', N'Navigation Controls', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:22:49.453' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1123, 0, 1120, 0, 2, N'-1,1120,1123', 14, N'93bf80bf-43a5-4084-ab79-ebfe7a31b3af', N'Home', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:25:48.290' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1124, 0, 1120, 0, 2, N'-1,1120,1124', 1, N'b1622d71-5cba-4680-a121-cb11a8d6d7de', N'Contact', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:28:17.647' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1125, 0, 1120, 0, 2, N'-1,1120,1125', 12, N'a513717c-c221-499a-914b-5ebf20952ffc', N'Account', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:30:02.243' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1126, 0, 1120, 0, 2, N'-1,1120,1126', 3, N'e036f069-f705-4e04-bcd3-876a3844e566', N'Login', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:30:26.150' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1127, 0, 1120, 0, 2, N'-1,1120,1127', 4, N'7fdb61a5-269a-4342-a5c1-85bb1206bab8', N'Register', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:33:28.150' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1128, 0, -1, 0, 1, N'-1,1128', 0, N'01c2bb91-543e-4cf5-ab29-4409d80293af', N'Home', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:34:24.987' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1129, 0, 1128, 0, 2, N'-1,1128,1129', 0, N'549199dd-8963-4ccf-8c20-e1cee61fb601', N'Account', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:35:47.027' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1130, 0, 1128, 0, 2, N'-1,1128,1130', 1, N'd61ba0fb-2c5d-457e-86eb-c8ca945a69b5', N'Contact', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:35:59.873' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1131, 0, 1129, 0, 3, N'-1,1128,1129,1131', 0, N'cfa9e73d-eb82-46c0-8aca-2d041d3d8129', N'Login', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:37:13.010' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1132, 0, 1129, 0, 3, N'-1,1128,1129,1132', 1, N'd82dd4a3-04d8-4039-96b9-1e11cf991b4b', N'Register', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:37:22.200' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1133, 0, 1120, 0, 2, N'-1,1120,1133', 5, N'4d595055-cf4f-4601-8912-eb26b1f9f86e', N'Confirm Email', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-10 23:38:37.810' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1134, 0, 1129, 0, 3, N'-1,1128,1129,1134', 2, N'b0deabe2-d345-46fd-a754-f701281223d6', N'Confirm Email', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-10 23:38:58.157' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1143, 0, 1062, NULL, 1, N'-1,1062,1143', 0, N'46887983-6b21-4cb9-bfa0-d7d622781d4b', N'Forgot Password', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-11 08:42:45.803' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1144, 0, 1120, 0, 2, N'-1,1120,1144', 6, N'62560aae-e8d6-4222-8228-17f8ce043bfe', N'Forgot Password', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-11 08:44:31.383' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1145, 0, 1129, 0, 3, N'-1,1128,1129,1145', 3, N'ccb5204f-a0eb-466f-9d7b-4ed7525324bc', N'Forgot Password', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-11 08:44:53.387' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1146, 0, 1062, NULL, 1, N'-1,1062,1146', 0, N'e83f84b7-53d8-4901-a7eb-dad4708f653f', N'Reset Password', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-11 09:06:21.633' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1147, 0, 1120, 0, 2, N'-1,1120,1147', 9, N'a6337547-81b2-4019-9c0d-7431977862ef', N'Reset Password', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-11 09:07:12.607' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1148, 0, 1129, 0, 3, N'-1,1128,1129,1148', 4, N'32b97bec-67e1-4787-bb9a-370346241d93', N'Reset Password', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-11 09:08:13.363' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1153, 0, 1120, 0, 2, N'-1,1120,1153', 11, N'2519e87e-b069-4f50-93ca-c5f950082cb0', N'External Login Confirmation', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2017-09-12 11:58:48.677' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1154, 0, 1062, NULL, 1, N'-1,1062,1154', 0, N'2d68028c-25f9-469e-be07-1e567e48b31b', N'External Login Confirmation', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2017-09-12 11:59:06.027' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1155, 0, 1129, 0, 3, N'-1,1128,1129,1155', 5, N'e321ab20-eba5-4b58-be38-896a3e283d61', N'External Login Confirmation', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-12 11:59:50.220' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1157, 0, -1, 0, 1, N'-1,1157', 0, N'30f91007-10d2-4770-954a-a3b3f2f20912', N'Vũ Nguyễn', N'39eb0f98-b348-42a1-8662-e7eb18487560', CAST(N'2017-09-12 14:02:03.920' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1158, 0, -1, 0, 1, N'-1,1158', 1, N'0e784f9d-7059-4046-8761-19374529c976', N'Vi', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.640' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1159, 0, 1158, 0, 2, N'-1,1158,1159', 0, N'e9f80fb8-27c2-4bdc-bcda-36bb88d21d5e', N'Account', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.893' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1160, 0, 1159, 0, 3, N'-1,1158,1159,1160', 0, N'104ba2f0-f06a-4381-9b2d-0275458cad0d', N'Login', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.913' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1161, 0, 1159, 0, 3, N'-1,1158,1159,1161', 1, N'cbf0a7b9-7b29-42e6-875c-22aa5cc0fef6', N'Register', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.927' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1162, 0, 1159, 0, 3, N'-1,1158,1159,1162', 2, N'f656b38c-44e0-4977-b7b5-5ad1f3009799', N'Confirm Email', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.940' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1163, 0, 1159, 0, 3, N'-1,1158,1159,1163', 3, N'2962ec17-a9f5-43f1-a582-55cbe6de462d', N'Forgot Password', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.950' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1164, 0, 1159, 0, 3, N'-1,1158,1159,1164', 4, N'f51d9f91-40c9-4237-8ca3-6a08c926fa03', N'Reset Password', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.960' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1165, 0, 1159, 0, 3, N'-1,1158,1159,1165', 5, N'ad6383b7-e6be-4ef9-bef0-e422f2679694', N'External Login Confirmation', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.973' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1166, 0, 1158, 0, 2, N'-1,1158,1166', 1, N'7e9c876e-99dd-4b50-a689-6ab1aebd2a66', N'Contact', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-16 00:00:10.987' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1167, 0, 1158, 0, 2, N'-1,1158,1167', 2, N'bfb38c72-6017-4958-8bc4-ad80c80930bf', N'Settings', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2017-09-18 10:21:42.033' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoNode] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelation] ON 

INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (4, 1131, 1160, 1, CAST(N'2017-09-16 00:00:11.143' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (5, 1132, 1161, 1, CAST(N'2017-09-16 00:00:11.173' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (6, 1134, 1162, 1, CAST(N'2017-09-16 00:00:11.190' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (7, 1145, 1163, 1, CAST(N'2017-09-16 00:00:11.207' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (8, 1148, 1164, 1, CAST(N'2017-09-16 00:00:11.317' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (9, 1155, 1165, 1, CAST(N'2017-09-16 00:00:11.327' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (10, 1129, 1159, 1, CAST(N'2017-09-16 00:00:11.350' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (11, 1130, 1166, 1, CAST(N'2017-09-16 00:00:11.367' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (12, 1128, 1158, 1, CAST(N'2017-09-16 00:00:11.383' AS DateTime), N'')
INSERT [dbo].[umbracoRelation] ([id], [parentId], [childId], [relType], [datetime], [comment]) VALUES (13, 1066, 1167, 1, CAST(N'2017-09-18 10:21:42.740' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[umbracoRelation] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelationType] ON 

INSERT [dbo].[umbracoRelationType] ([id], [typeUniqueId], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (1, N'4cbeb612-e689-3563-b755-bf3ede295433', 1, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Document On Copy', N'relateDocumentOnCopy')
INSERT [dbo].[umbracoRelationType] ([id], [typeUniqueId], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (2, N'0cc3507c-66ab-3091-8913-3d998148e423', 0, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Parent Document On Delete', N'relateParentDocumentOnDelete')
SET IDENTITY_INSERT [dbo].[umbracoRelationType] OFF
SET IDENTITY_INSERT [dbo].[umbracoServer] ON 

INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (1, N'http://localhost/umbraco', N'DESKTOP-RERGFIA//LM/W3SVC/2/ROOT', CAST(N'2017-09-04 13:14:28.023' AS DateTime), CAST(N'2017-09-18 10:31:45.877' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[umbracoServer] OFF
SET IDENTITY_INSERT [dbo].[umbracoUser] ON 

INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (0, 0, 0, 1, -1, -1, N'admin', N'vnvipper@gmail.com', N'sYUer9UxfMi3/BxKYjI72A==DEMIxzV9/SgbHGFmBHYL1/qUneYNpdZTQVcAtnihckc=', N'vnvipper@gmail.com', N'en', N'14972fce-1232-40d8-8da1-9993d6113e14', 0, NULL, CAST(N'2017-09-18 10:19:39.370' AS DateTime), CAST(N'2017-09-18 10:30:27.050' AS DateTime))
INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userType], [startStructureID], [startMediaID], [userName], [userLogin], [userPassword], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate]) VALUES (1, 0, 0, 2, -1, -1, N'nguyenpv', N'nguyenpv', N'3NHgWvFL4+6KceG5pbVIpw==5JEJO4/a0gvqmpRFVxFW17y+22dA6f4+HQxiEYjFiwg=', N'nguyenpvdtu@gmail.com', N'en', N'd5714fce-7c75-43a9-aaf3-60797b647309', 0, NULL, CAST(N'2017-09-18 09:55:00.773' AS DateTime), CAST(N'2017-09-18 09:55:00.773' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoUser] OFF
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'developer')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'forms')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'media')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'member')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'settings')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (0, N'users')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'content')
INSERT [dbo].[umbracoUser2app] ([user], [app]) VALUES (1, N'media')
SET IDENTITY_INSERT [dbo].[umbracoUserType] ON 

INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (1, N'admin', N'Administrators', N'CADMOSKTPIURZ:5F7')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (2, N'writer', N'Writer', N'CAH:F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (3, N'editor', N'Editors', N'CADMOSKTPUZ:5F')
INSERT [dbo].[umbracoUserType] ([id], [userTypeAlias], [userTypeName], [userTypeDefaultPermissions]) VALUES (4, N'translator', N'Translator', N'AF')
SET IDENTITY_INSERT [dbo].[umbracoUserType] OFF
/****** Object:  Index [IX_cmsContent]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContent] ON [dbo].[cmsContent]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentType]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentType] ON [dbo].[cmsContentType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsContentType_icon]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentType_icon] ON [dbo].[cmsContentType]
(
	[icon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_ContentId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentVersion_ContentId] ON [dbo].[cmsContentVersion]
(
	[ContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_VersionId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentVersion_VersionId] ON [dbo].[cmsContentVersion]
(
	[VersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDataType_nodeId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDataType_nodeId] ON [dbo].[cmsDataType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDictionary_id]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDictionary_id] ON [dbo].[cmsDictionary]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDocument] ON [dbo].[cmsDocument]
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_newest]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_newest] ON [dbo].[cmsDocument]
(
	[newest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_published]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_published] ON [dbo].[cmsDocument]
(
	[published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsMacro_UniqueId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacro_UniqueId] ON [dbo].[cmsMacro]
(
	[uniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroPropertyAlias]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroPropertyAlias] ON [dbo].[cmsMacro]
(
	[macroAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroProperty_Alias]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_Alias] ON [dbo].[cmsMacroProperty]
(
	[macro] ASC,
	[macroPropertyAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsMacroProperty_UniquePropertyId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_UniquePropertyId] ON [dbo].[cmsMacroProperty]
(
	[uniquePropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMember_LoginName]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsMember_LoginName] ON [dbo].[cmsMember]
(
	[LoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_1]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyData_1] ON [dbo].[cmsPropertyData]
(
	[contentNodeId] ASC,
	[versionId] ASC,
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_2]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_2] ON [dbo].[cmsPropertyData]
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_3]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_3] ON [dbo].[cmsPropertyData]
(
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeUniqueID]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeUniqueID] ON [dbo].[cmsPropertyType]
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeGroupUniqueID]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeGroupUniqueID] ON [dbo].[cmsPropertyTypeGroup]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTags]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTags] ON [dbo].[cmsTags]
(
	[tag] ASC,
	[group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTaskType_alias]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTaskType_alias] ON [dbo].[cmsTaskType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsTemplate_nodeId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsTemplate_nodeId] ON [dbo].[cmsTemplate]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoAccess_nodeId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccess_nodeId] ON [dbo].[umbracoAccess]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoAccessRule]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccessRule] ON [dbo].[umbracoAccessRule]
(
	[ruleValue] ASC,
	[ruleType] ASC,
	[accessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoLanguage_languageISOCode]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoLanguage_languageISOCode] ON [dbo].[umbracoLanguage]
(
	[languageISOCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoLog]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoLog] ON [dbo].[umbracoLog]
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoMigration]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoMigration] ON [dbo].[umbracoMigration]
(
	[name] ASC,
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeObjectType]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeObjectType] ON [dbo].[umbracoNode]
(
	[nodeObjectType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeParentId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeParentId] ON [dbo].[umbracoNode]
(
	[parentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoNodePath]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodePath] ON [dbo].[umbracoNode]
(
	[path] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeTrashed]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeTrashed] ON [dbo].[umbracoNode]
(
	[trashed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeUniqueID]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoNodeUniqueID] ON [dbo].[umbracoNode]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRedirectUrl]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRedirectUrl] ON [dbo].[umbracoRedirectUrl]
(
	[urlHash] ASC,
	[contentKey] ASC,
	[createDateUtc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoRelation_parentChildType]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelation_parentChildType] ON [dbo].[umbracoRelation]
(
	[parentId] ASC,
	[childId] ASC,
	[relType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRelationType_alias]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_alias] ON [dbo].[umbracoRelationType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRelationType_name]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_name] ON [dbo].[umbracoRelationType]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoRelationType_UniqueId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_UniqueId] ON [dbo].[umbracoRelationType]
(
	[typeUniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_computerName]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_computerName] ON [dbo].[umbracoServer]
(
	[computerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoServer_isActive]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoServer_isActive] ON [dbo].[umbracoServer]
(
	[isActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUser_userLogin]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser_userLogin] ON [dbo].[umbracoUser]
(
	[userLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoUser2NodePermission_nodeId]    Script Date: 9/18/2017 10:32:42 AM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser2NodePermission_nodeId] ON [dbo].[umbracoUser2NodePermission]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroUseInEditor]  DEFAULT ('0') FOR [macroUseInEditor]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroRefreshRate]  DEFAULT ('0') FOR [macroRefreshRate]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCacheByPage]  DEFAULT ('1') FOR [macroCacheByPage]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCachePersonalized]  DEFAULT ('0') FOR [macroCachePersonalized]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroDontRender]  DEFAULT ('0') FOR [macroDontRender]
GO
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_cmsMacroProperty_macroPropertySortOrder]  DEFAULT ('0') FOR [macroPropertySortOrder]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_closed]  DEFAULT ('0') FOR [closed]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoExternalLogin] ADD  CONSTRAINT [DF_umbracoExternalLogin_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_cmsContentType_nodeId] FOREIGN KEY([contentType])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType] CHECK CONSTRAINT [FK_cmsContentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child] FOREIGN KEY([childContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent] FOREIGN KEY([parentContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY([Id])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY([AllowedId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1]
GO
ALTER TABLE [dbo].[cmsContentVersion]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY([ContentId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentVersion] CHECK CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsContentXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentXml] CHECK CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDataType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDataType] CHECK CONSTRAINT [FK_cmsDataType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDataTypePreValues]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY([datatypeNodeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDataTypePreValues] CHECK CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsDictionary]  WITH CHECK ADD  CONSTRAINT [FK_cmsDictionary_cmsDictionary_id] FOREIGN KEY([parent])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsDictionary] CHECK CONSTRAINT [FK_cmsDictionary_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId] FOREIGN KEY([templateId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId] FOREIGN KEY([templateNodeId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id] FOREIGN KEY([UniqueId])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY([languageId])
REFERENCES [dbo].[umbracoLanguage] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id]
GO
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY([macro])
REFERENCES [dbo].[cmsMacro] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY([Member])
REFERENCES [dbo].[cmsMember] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY([MemberGroup])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId] FOREIGN KEY([NodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY([NodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY([versionId])
REFERENCES [dbo].[cmsContentVersion] ([VersionId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY([propertytypeid])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY([contentNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId] FOREIGN KEY([contentTypeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId] FOREIGN KEY([dataTypeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY([propertyTypeGroupId])
REFERENCES [dbo].[cmsPropertyTypeGroup] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id]
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId] FOREIGN KEY([contenttypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup] CHECK CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsContent]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY([propertyTypeId])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY([tagId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsTags_id]
GO
ALTER TABLE [dbo].[cmsTags]  WITH CHECK ADD  CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY([ParentId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTags] CHECK CONSTRAINT [FK_cmsTags_cmsTags]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_cmsTaskType_id] FOREIGN KEY([taskTypeId])
REFERENCES [dbo].[cmsTaskType] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_cmsTaskType_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY([parentUserId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser1]
GO
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY([loginNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id1]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY([noAccessNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id2]
GO
ALTER TABLE [dbo].[umbracoAccessRule]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY([accessId])
REFERENCES [dbo].[umbracoAccess] ([id])
GO
ALTER TABLE [dbo].[umbracoAccessRule] CHECK CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id]
GO
ALTER TABLE [dbo].[umbracoDomains]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY([domainRootStructureID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoDomains] CHECK CONSTRAINT [FK_umbracoDomains_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY([parentID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoNode] CHECK CONSTRAINT [FK_umbracoNode_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoRedirectUrl]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID] FOREIGN KEY([contentKey])
REFERENCES [dbo].[umbracoNode] ([uniqueID])
GO
ALTER TABLE [dbo].[umbracoRedirectUrl] CHECK CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY([parentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY([childId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode1]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY([relType])
REFERENCES [dbo].[umbracoRelationType] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id]
GO
ALTER TABLE [dbo].[umbracoUser]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser_umbracoUserType_id] FOREIGN KEY([userType])
REFERENCES [dbo].[umbracoUserType] ([id])
GO
ALTER TABLE [dbo].[umbracoUser] CHECK CONSTRAINT [FK_umbracoUser_umbracoUserType_id]
GO
ALTER TABLE [dbo].[umbracoUser2app]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2app_umbracoUser_id] FOREIGN KEY([user])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2app] CHECK CONSTRAINT [FK_umbracoUser2app_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodePermission] CHECK CONSTRAINT [FK_umbracoUser2NodePermission_umbracoUser_id]
GO
USE [master]
GO
ALTER DATABASE [UmbracoTemplate] SET  READ_WRITE 
GO
