'use strict';

app.controller('OrdenDeArrestoController', function($scope) {

    var self = this;

    function errorHandler(error) {
        self.notificarError(error.data);
    }

    this.obtenerVillanos = function() {
        Libros.query(function(data) {
            self.villanos = data;
        }, errorHandler);
    };

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

    this.agregarLibro = function() {
        Libros.save(this.nuevoLibro, function(data) {
            self.notificarMensaje('Libro agregado con id:' + data.id);
            self.actualizarLista();
            self.nuevoLibro = null;
        }, errorHandler);
    };

    this.seleccionado = self.villanos[0];
    this.ordenEmitida = null;

    this.emitirOrden = function() {
        self.ordenEmitida = self.seleccionado;
    };

    this.seleccionarVillano = function () {
        self.seleccionado = $scope.selector;
    };


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