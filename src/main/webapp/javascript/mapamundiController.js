	app.controller('MapamundiCtrl', function($resource, Paises) {
    'use strict';

    var self = this;

    self.paises = [];
    
    self.paisSeleccionado = null;
    
    this.actualizarLista = function() {
        Paises.query(function(data) {
        console.log(data);
            self.paises = data;
        });
    };
    
    this.actualizarLista();
    
 // EDITAR PAIS
    this.editarPais = function(pais) {
    	self.paisSeleccionado = pais;
    	console.log(pais);
    	//this.actualizarLista();
        //$("#editarLibroModal").modal({});
    };
    	
    
   
  });