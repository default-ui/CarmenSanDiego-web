'use strict';

app.controller('OrdenDeArrestoController', function() {

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

    this.seleccionado = "Carmen SanDiego";

    this.villanoSeleccionado = function() {
        this.seleccionado = $(".select-villano-js option:selected").text()
    };

    this.agregarLibro = function() {
        Libros.save(this.nuevoLibro, function(data) {
            self.notificarMensaje('Libro agregado con id:' + data.id);
            self.actualizarLista();
            self.nuevoLibro = null;
        }, errorHandler);
    };

    this.emitirOrden = function() {
        self.villanoSeleccionado();
        $('.orden-emitida-js').text(this.seleccionado);
    };

    $(".btn-info").on("click", function () {
        self.emitirOrden();
    });

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