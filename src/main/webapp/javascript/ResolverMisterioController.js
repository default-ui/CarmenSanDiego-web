mostrarMensaje = function(error) {
    var alerta = $('.alert-success');
    alerta.text(error);
    alerta.show(300);
    setTimeout(function(){ alerta.hide(2000); }, 3000);
}

app.controller("ResolverMisterioController", function($scope, $resource, ResolverMisterio) {
    'use strict';

    var self = this;

    function errorHandler(error) {
        self.notificarError(error.data);
    };

    self.juego = null;
    self.villanos = [];
    self.paisActual = null;
    self.destinosFallidos = [];
    self.paisAViajar = null;
    self.pistaActual = null;

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

    this.actualizarTodo = function(data) {
        self.juego = data;
        self.actualizarPais(data.pais.id);
        self.destinosFallidos = data.paisesFallidos;
    };

    this.iniciarJuego = function() {
        ResolverMisterio.iniciarJuego(function(data) {
            self.actualizarTodo(data);
        }, errorHandler);
    }();

    this.seleccionarPaisAViajar = function(inputSeleccionado) {
        self.paisAViajar = (inputSeleccionado.pais);
    };

    this.viajar = function() {
        var viajarRequest = { destinoId: self.paisAViajar.id, casoId: self.juego.id };
        ResolverMisterio.viajar(viajarRequest, function(data) {
            self.actualizarTodo(data);
        }, errorHandler);
    };

    this.pedirPista = function(lugar) {
        ResolverMisterio.pedirPista({casoId: self.juego.id, lugar: lugar}, function(data){
            self.pistaActual = data;
        });
    };

    this.obtenerVillanos = function() {
        ResolverMisterio.obtenerVillanos( function(data) {
            self.villanos = data;
        }, errorHandler);
    }();

    this.villanoSeleccionado = null;
    this.ordenEmitida = null;

    this.emitirOrden = function() {
        var ordenRequest = { villanoId: self.villanoSeleccionado, casoId: self.juego.id };

        ResolverMisterio.emitirOrden(ordenRequest, function(data) {
            self.ordenEmitida = self.villanoSeleccionado;
            mostrarMensaje(data);
        }, errorHandler);
    };

    this.seleccionarVillano = function() {
        self.villanoSeleccionado = $scope.ordenSelector;
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
    };

});
