appExp.controller('ExpedienteController', function($resource, Villanos) {
    'use strict';

    var self = this;
    self.villanos = [];
    self.villanoActual = null;
    self.nuevoHobbie = " ";


    this.actualizarLista = function() {
        Villanos.query(function(data) {
        
            self.villanos = data;
            //self.nuevoHobbie = "gfdgfd";
            //console.log(self.villanoActual);
            
        });
    };
    
    this.actualizarLista();

    this.verVillano = function(idVillano) {
    	if(!angular.isUndefined(idVillano)){ 
    	Villanos.get({id: idVillano}, function(data) {
//    		console.log(data);
    		self.villanoActual = data;
    		//self.nuevoHobbie = "fgfdg";
    		//console.log(self.villanoActual);
    	
            });
    	}
    };

    this.eliminarVillano = function(idVillano) {
//        var mensaje = "¿Está seguro de eliminar: '" + libro.titulo + "'?";
//        bootbox.confirm(mensaje, function(confirma) {
//            if (confirma) {
                Villanos.remove({id: idVillano}, function() {
                  //  self.notificarMensaje('Libro eliminado!');
                	self.villanoActual = null;
                    self.actualizarLista();
                });
         //   }
    //    });
    };
    
    this.limpiarCampos = function(){
    	self.villanoActual = null;
    	self.actualizarLista();
    };
    
    this.agregarVillano = function() {
        Villanos.save(this.villanoActual, function(data) {
            //self.notificarMensaje('Libro agregado con id:' + data.id);
            self.actualizarLista();
            self.nuevoLibro = null;
        });
    };
    
    this.agregarHobbie = function(){
    	self.villanoActual.hobbies.push(self.nuevoHobbie)
    	console.log(self.nuevoHobbie);
    	self.actualizarLista();
    };
    



});
    	
    
  
