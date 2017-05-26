	'use strict';

var app = angular.module('mapamundiApp',[]);

app.controller('MapamundiCtrl', function() {
	
	this.mapa = [{
		"id":1,
		"nombre": "Argentina"
	}, {
		"id":2,
		"nombre": "Brasil"
	}, {
		"id":3,
		"nombre": "Peru"
	}, {
		"id":4,
		"nombre": "Colombia"
	}, {
		"id":5,
		"nombre": "Mexico"
	}, {
		"id":6,
		"nombre": "Canada"
	}, {
		"id":7,
		"nombre": "Kenia"
	}, {
		"id":8,
		"nombre": "Camerun"
	}, {
		"id":9,
		"nombre": "Egipto"
	}, {
		"id":10,
		"nombre": "Argelia"
	}, {
		"id":11,
		"nombre": "Alemania"
	}, {
		"id":12,
		"nombre": "Espana"
	}, {
		"id":13,
		"nombre": "Francia"
	}, {
		"id":14,
		"nombre": "Inglaterra"
	}, {
		"id":15,
		"nombre": "Holanda"
	}, {
		"id":16,
		"nombre": "China"
	}, {
		"id":17,
		"nombre": "Japon"
	}, {
		"id":18,
		"nombre": "India"
	}, {
		"id":19,
		"nombre": "Australia"
	}, {
		"id":20,
		"nombre": "Iran"
	}];

	this.textoBusqueda = '';	
	

	this.limpiarBusqueda = function() {
		this.textoBusqueda = ''
	};

});