angular.module("umbraco").controller("UtilitiesController",
    function ($scope, utilitiesResource, notificationsService) {
        var vm = this;
        $scope.createFile = function () {
            utilitiesResource.createConstant().then(function (response) {
                if (response.data) {
                    notificationsService.success("Success! File Contstant.cs have just recreate on Infracstructor folder.");
                }
            });
        };
});