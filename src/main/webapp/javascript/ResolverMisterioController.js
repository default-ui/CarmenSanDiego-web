app.controller("ResolverMisterioController", function($resource, Villanos) {
    'use strict';

    var self = this;

    function errorHandler(error) {
        self.notificarError(error.data);
    }
    /*
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
*/

    self.villanos = [];

    this.obtenerVillanos = function() {
        Villanos.query(function(data) {
            self.villanos = data;
        }, errorHandler);
    }();

    this.titulo = 'Lalala';
    this.villanoId = null //self.villanos[0].villanoId;

    this.seleccionado = null //self.villanos[0];
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
