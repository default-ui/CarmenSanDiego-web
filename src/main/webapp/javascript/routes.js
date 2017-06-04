app.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider

        .state('ordenDeArresto', {
            url: "/orden-de-arresto",
            templateUrl: "../views/ordenDeArresto.html",
            controller: "OrdenDeArrestoController as ordenCtrl"
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