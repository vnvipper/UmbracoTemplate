# Umbraco Template

Basic useful feature list:

 * Use gulp for managing front-end task
 * Integrate bower for manage front-end library
 * Decouple components by integrating Ninject Ioc container
 * Make query of node in umbraco more easily with IDataService
 * Use Identity for authentication and login third party
 
# Special things

Example: Get All page by document type

```
public HomeController(IDataService<Home> homeService)
{
	_homeService = homeService;
}

// GET: Home
public ActionResult Index()
{
  var homes = _homeService.GetAll();
  // or from my helper (Can use on view by Html.GetPages<Home> to get a page)
  // home = Helpers.GetPages();
  return CurrentTemplate(homes);
}
```

Example: Get if it have just one page by document type

```
public HomeController(IDataService<Home> homeService)
{
	_homeService = homeService;
}

// GET: Home
public ActionResult Index()
{
  var home = _homeService.Get();
  // or from my helper (Can use on view by Html.GetPage<Home> to get a page)
  // home = Helpers.GetPage();
  return CurrentTemplate(home);
}
```
Bring Link Helper on view Comback
```
 @(Html.UrlFor<ForgotPassword>("Forgot your password?"))
```
