app.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider


        .state('resolverMisterio', {
            url: "/resolverMisterio",
            templateUrl: "../views/resolverMisterio.html",
            controller: "ResolverMisterioController as ResolverMisterioController"
        })

        .state('expediente', {
            url: "/expediente",
            templateUrl: "../views/expediente.html",
            controller: "ExpedienteController as expedienteCtrl"
        })

        .state('mapamundi', {
            url: "/mapamundi",
            templateUrl: "../views/mapamundi.html",
            controller: "MapamundiController as mapamundiCtrl"
        })
});