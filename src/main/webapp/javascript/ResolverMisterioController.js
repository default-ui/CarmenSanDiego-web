mostrarMensaje = function(claseDelMensajero ,mensaje) {
    var alerta = $(claseDelMensajero);
    alerta.text(mensaje);
    alerta.show(300);
    setTimeout(function(){ alerta.hide(2000); }, 3000);
}

mostrarError = function(error) { mostrarMensaje('.alert-danger', error); };
mostrarExito = function(exito) { mostrarMensaje('.alert-success', exito); };

app.controller("ResolverMisterioController", function($scope, $resource, ResolverMisterio) {
    'use strict';

    var self = this;

    function errorHandler(error) {
        mostrarError(error.data);
    };

    self.juego = null;
    self.villanos = [];
    self.paisActual = null;
    self.destinosFallidos = [];
    self.paisAViajar = null;
    self.pistaActual = null;
    self.paisesVisitados = [];
    self.lugarActual = null;
    self.titulo = null;

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
        self.paisesVisitados = data.recorrido;
        self.titulo = data.reporte;
    };

    this.iniciarJuego = function() {
        ResolverMisterio.iniciarJuego(function(data) {
            self.actualizarTodo(data);
            self.iniciarPartida();
            mostrarExito('El juego ha iniciado');
        }, errorHandler);
    };

    this.iniciarPartida = function() {
        self.obtenerVillanos();
        $('.pantalla-de-inicio').hide(300, function() {
            $('.pantalla-de-juego').show(300);
        });
    }

    this.seleccionarPaisAViajar = function(inputSeleccionado) {
        self.paisAViajar = (inputSeleccionado.pais);
    };

    this.viajar = function() {
        var viajarRequest = { destinoId: self.paisAViajar.id, casoId: self.juego.id };
        ResolverMisterio.viajar(viajarRequest, function(data) {
            self.actualizarTodo(data);
            mostrarExito('Ha viajado a ' + data.pais.nombre);
        }, errorHandler);
    };

    this.pedirPista = function(lugar) {
        ResolverMisterio.pedirPista({id: self.juego.id, lugar: lugar}, function(data) {
            var pistaString = _.reduce(data, function(memo, char) {return memo + char}, "");
            self.pistaActual = pistaString.slice(0, -19);
            self.lugarActual = lugar;
            mostrarExito('Ha pedido una pista para ' + lugar);
        }, errorHandler);
    };

    this.obtenerVillanos = function() {
        ResolverMisterio.obtenerVillanos( function(data) {
            self.villanos = data;
        }, errorHandler);
    };

    this.villanoSeleccionado = null;
    this.ordenEmitida = null;

    this.ordenYaEmitida = function(data) {
        self.ordenEmitida = self.villanoSeleccionado.nombre;
        mostrarExito('Orden emitida correctamente');
    }

    this.emitirOrden = function() {
        var ordenRequest = { casoId: self.juego.id, villanoId: self.villanoSeleccionado.id };

        ResolverMisterio.emitirOrden(ordenRequest, function(data){ self.ordenYaEmitida(data)},
            function(data){ self.ordenYaEmitida(data)});
    };

    this.obtenerVillano = function(villanoId) {
        ResolverMisterio.obtenerVillano({id: villanoId}, function(data) {
            self.villanoSeleccionado = data;
        }, errorHandler);
    };

    this.seleccionarVillano = function() {
        self.obtenerVillano($scope.ordenSelector);
    };
});
