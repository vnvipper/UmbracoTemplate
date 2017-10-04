angular.module("umbraco.resources")
    .factory("utilitiesResource", function ($http) {
        return {
            createConstant: function () {
                return $http.post("backoffice/UmbracoUtilities/UtilitiesApi/CreateConstants");
            }
        };
    });