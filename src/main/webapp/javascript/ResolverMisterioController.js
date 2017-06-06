app.controller("ResolverMisterioController", function($scope, $resource, ResolverMisterio) {
    'use strict';

    var self = this;

    function errorHandler(error) {
        self.notificarError(error.data);
    };
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
    self.juego = null;
    self.villanos = [];
    self.paisActual = null;
    self.paisAViajar = null;

    this.actualizarPais = function(id) {
        ResolverMisterio.obtenerPais({id: id}, function(data) {
            self.paisActual = data;
        }, errorHandler);
    };

    this.obtenerPaisAViajar = function(id) {
        ResolverMisterio.obtenerPais({id: id}, function(data) {
            self.paisAViajar = data;
        }, errorHandler);
    };

    this.iniciarJuego = function() {
        ResolverMisterio.iniciarJuego(function(data) {
            self.juego = data;
            self.actualizarPais(data.pais.id);
        }, errorHandler);
    }();

    this.seleccionarPaisAViajar = function(inputSeleccionado) {
        self.obtenerPaisAViajar(inputSeleccionado.pais.id);
    };

    this.viajar = function() {
        ResolverMisterio.viajar(self.paisAViajar, function(data) {

        }, errorHandler);
    };

    this.obtenerVillanos = function() {
        ResolverMisterio.obtenerVillanos( function(data) {
            self.villanos = data;
        }, errorHandler);
    }();

    this.seleccionado = null; //self.villanos[0];
    this.ordenEmitida = null;
    this.villanoParaEmitir = null;

    this.obtenerVillano = function(id) {
        ResolverMisterio.obtenerVillano({id: id}, function(data) {
            self.villanoParaEmitir = data;
        }, errorHandler);
    };

    this.emitirOrden = function(){
        self.obtenerVillano(self.seleccionado);
        ResolverMisterio.emitirOrden(self.villanoParaEmitir, function(data) {
            self.ordenEmitida = self.villanoParaEmitir.nombre;
        }, errorHandler);
    };

    this.seleccionarVillano = function() {
        self.seleccionado = $scope.ordenSelector;
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
    };

});
