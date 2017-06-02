app.controller('MapamundiCtrl', function($resource, Paises, Pais) {
    'use strict';

    var self = this;

    self.paises = [];
    
    self.paisSeleccionado = null;
    
    function errorHandler(error) {
        self.notificarError(error.data);
    }
    
    this.actualizarLista = function() {
        Paises.query(function(data) {
        console.log(data);
            self.paises = data;
        });
    };
    
    this.actualizarLista();
    
// EDITAR PAIS
    this.editarPais = function(pais) {
    	console.log(pais)
    	Paises.query2(pais);
    	self.paisSeleccionado = pais;
    	
    	};
    
// 
    

// ELIMINAR PAIS
    this.eliminarPais = function(pais) {
    	console.log(pais)
        var mensaje = "¿Está seguro de eliminar: '" + pais.nombre + "'?";
        bootbox.confirm(mensaje, function(confirma) {
            if (confirma) {
                Paises.remove(pais, function() {
                    self.notificarMensaje('Pais eliminado!'); 
                }, errorHandler);
                self.actualizarLista();
            }
        });
    };

 // FEEDBACK & ERRORES
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