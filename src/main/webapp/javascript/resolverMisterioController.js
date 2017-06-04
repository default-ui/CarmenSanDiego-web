app.controller("ResolverMisterioController", function($scope, $http) {
 
    var self = this;

    this.villanos = [{
        "villanoId": "0",
        "nombre": "Carmen SanDiego"
    }, {
        "villanoId": "1",
        "nombre": "Mufasa"
    }, {
        "villanoId": "2",
        "nombre": "Moriarty"
    }];

    this.seleccionado = self.villanos[0];
    this.ordenEmitida = null;

    this.emitirOrden = function() {
        self.ordenEmitida = self.seleccionado.nombre;
    };

    this.seleccionarVillano = function () {
        self.seleccionado = $scope.selector;
    };

    var self = this;
});
