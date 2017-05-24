'use strict';


var app = angular.module('ordenDeArrestoApp', []);

app.controller('OrdenDeArrestoController', function () {

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

    this.villanoSeleccionado = function(select) {
        this.seleccionado = select.options[select.selectedIndex].text;
    };

    this.ordenEmitida = '';

    this.emitirOrden = function() {
        this.ordenEmitida = seleccionado;
        document.getElementById("orden-emitida-js").innerHTML=this.seleccionado;
    };
});

