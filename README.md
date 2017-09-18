# Umbraco Template

Basic useful feature list:

 * Use gulp for managing front-end task
 * Integrate bower for manage front-end library
 * Decouple components by integrating Ninject Ioc container
 * Make query of node in umbraco more easily with IDataService ( support multi site language and you can inject your new logic if you want :) )
 * Use Identity for authentication and login third party
 * Dynamic menu

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
  var homes = _homeService.GetAllByCurrentCulture();
  // or from my helper (Can use on view by Helpers.GetPagesByCurrentCulture<Home> to get a page)
  // home = Helpers.GetPagesByCurrentCulture<Home>();
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
  var home = _homeService.GetByCurrentCulture();
  // or from my helper (Can use on view by Helps.GetPageByCurrentCulture<Home> to get a page)
  // home = Helpers.GetByCurrentCulture<Home>();
  return CurrentTemplate(home);
}
```
Bring Link Helper on view Comback
```
 @(Html.MultiSiteUrlFor<ForgotPassword>("Forgot your password?"))
```
