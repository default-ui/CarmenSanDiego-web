app.controller('ExpedienteController', function($resource, $timeout, Villanos) {
    'use strict';

    var self = this;
    self.villanos = [];
    self.villanoActual = null;
    self.nombreVillanoAEditar = " ";
    self.nuevoHobbie = " ";
    self.nuevaSena = " ";

    // GET todos los villanos
    this.actualizarLista = function() {
        Villanos.query(function(data) {
            self.villanos = data;
            
        });
    };
    
    this.actualizarLista();

    // GET villano by ID
    this.verVillano = function(idVillano) {
    	if(!angular.isUndefined(idVillano)){ 
    	Villanos.get({id: idVillano}, function(data) {
    	//	console.log(self.villanoActual);
    	//	console.log(data);
    		self.villanoActual = data;
    	//	console.log(self.villanoActual.id)
    		//self.nuevoHobbie = "fgfdg";
    //	console.log(self.villanoActual);
    	
            });
    	}
    	//console.log(self.villanoActual);
    };
    
    // DELETE villano by ID
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
    
    // Utilizado en el boton Nuevo
    this.limpiarCampos = function(){
    	self.villanoActual = null;
    	self.actualizarLista();
    };
    
    // si el villano no existia, lo crea. Si el villano ya existia, lo edita.
    this.agregarVillano = function() {
    	 var result = ($.grep(self.villanos, function(e){ return e.id === self.villanoActual.id;}));
    	 var noExisteVillano = result.length == 0;
    	if(noExisteVillano){
    		Villanos.save(this.villanoActual, function(data) {
    			self.actualizarLista();
    			self.villanoActual = null;
    		});
    	}
    	else{
    		Villanos.update(this.villanoActual, function(data) {
    			self.actualizarLista();
    			self.villanoActual = null;
    		});
    	}
    };
    
 
    // edicion de hobbies del villano
    this.agregarHobbie = function(){
    	// como la variable villano actual puede ser null, no puedo definirla arriba. Entonces, tengo que definirla aca (solo una primera vez).
    	if(typeof(self.villanoActual.hobbies) == 'undefined'){
    	self.villanoActual.hobbies = []
    	}
    	// para que no puedan agregarse hobbies vacios
    	if(self.nuevoHobbie != null){
    	self.villanoActual.hobbies.push(self.nuevoHobbie);
    	self.nuevoHobbie = null;
    	self.actualizarLista();
    	}
    	else{
    		this.notificarMensaje("Introduce un hobbie.")
    	}
    };
    
   this.eliminarHobbie = function(elem){
	  // console.log(self.villanoActual);
    	// obtengo el index y borro un solo elemento de la lista
    	var index = self.villanoActual.hobbies.indexOf(elem);
    	self.villanoActual.hobbies.splice(index, 1); 
 
    };
    
    // edicion de senas particulares
    this.agregarSena = function(){
    	// como la variable villano actual puede ser null, no puedo definirla arriba. Entonces, tengo que definirla aca (solo una primera vez).
    	if(typeof(self.villanoActual.senasParticulares) == 'undefined'){
    	self.villanoActual.senasParticulares = []
    	}
    	// para que no puedan agregarse hobbies vacios
    	if(self.nuevaSena != null){
    	self.villanoActual.senasParticulares.push(self.nuevaSena);
    	self.nuevaSena = null;
    	self.actualizarLista();
    	}
    	else{
    		this.notificarMensaje("Introduce una seña.")
    	}
    };
    
   this.eliminarSena = function(elem){
    	// obtengo el index y borro un solo elemento de la lista
    	var index = self.villanoActual.senasParticulares.indexOf(elem);
    	self.villanoActual.senasParticulares.splice(index, 1); 
 
    };
    
    // FEEDBACK & ERRORES
    
    function errorHandler(error) {
        self.notificarError(error.data);
    }
    
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
    	
    
  
