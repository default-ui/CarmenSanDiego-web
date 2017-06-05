app.controller("ResolverMisterioController", function($scope, $http) {

    var self = this;

    function errorHandler(error) {
        self.notificarError(error.data);
    }
    
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

    this.obtenerVillanos = function() {
        Libros.query(function(data) {
            self.villanos = data;
        }, errorHandler);
    };

    this.titulo = 'Lalala';
    this.villanoId = this.villanos[0].villanoId;
    this.seleccionado = self.villanos[0];
    this.ordenEmitida = null;

    this.emitirOrden = function() {
        self.ordenEmitida = self.seleccionado;
    };

    this.seleccionarVillano = function () {
        self.seleccionado = $scope.selector;
    };
    
    // this.ordenEmitida = null;
    
    // this.emitirOrden = function() {
    //     self.ordenEmitida = self.seleccionado.nombre;
    // };

    // this.seleccionarVillano = function () {
    //     self.seleccionado = $scope.selector;
    // };

    this.msgs = [];
    this.notificarMensaje = function(mensaje) {
        this.msgs.push(mensaje);
        this.notificar(this.msgs);
    };

    this.errors = [];
    this.notificarError = function(mensaje) {
        this.errors.push(mensaje);
        this.notificar(this.errors);
    };

    this.notificar = function(mensajes) {
        $timeout(function() {
            while (mensajes.length > 0) mensajes.pop();
        }, 3000);
    }

});
