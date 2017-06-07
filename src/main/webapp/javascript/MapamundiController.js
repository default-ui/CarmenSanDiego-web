app.controller('MapamundiController', function($resource, Paises) {
    'use strict';

    var self = this;
    self.paises = [];
    self.lugares = null;
    self.paisSeleccionado = null;
    self.caracteristicaAIngresar = null;
    self.conexionAIngresar = null;
    self.lugarAIngresar = null;
    self.conexionesPosibles = null;
    
    this.actualizarLista = function() {
        Paises.query(function(data) {
            self.paises = data;
        });
    };
    
    this.actualizarLista();
    
    this.actualizarConexiones = function(idPais){
    	Paises.getC({id: idPais}, function(data){
    		self.conexionesPosibles = data;
    	});
    };
    
 // EDITAR PAIS
    this.editarPais = function(idPais) {
    	if(!angular.isUndefined(idPais)){ 
    	Paises.get({id: idPais}, function(data) {
    		self.paisSeleccionado = data; 
    		//self.nuevoHobbie = "fgfdg";
    		console.log(self.paisSeleccionado);
            });
    	self.actualizarConexiones(idPais);
    	Paises.getL({id: idPais}, function(data){
        	self.lugares = data;
        });
    	}
    	
    };

//AGREGAR PAIS    
    this.agregarPais = function() {
        Paises.update(this.paisSeleccionado, function(data) {
            //self.notificarMensaje('Libro agregado con id:' + data.id);
            self.actualizarLista();
            //self.nuevoPais = null;
        });
    };
    
    this.limpiarCampos = function(){
    	self.paisSeleccionado = null;
    	self.actualizarLista();
    };
    
    
    function errorHandler(error) {
        self.notificarError(error.data);
    }
    

// ELIMINAR PAIS
    this.eliminarPais = function(pais) {
    	console.log(pais);
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
    
// ELIMINAR CARACTERISTICA
    this.eliminarCaracteristica = function(caracteristica) {
    	this.paisSeleccionado.caracteristicas.splice(this.paisSeleccionado.caracteristicas.indexOf(caracteristica),1);
    };

// AGREGAR CARACTERISTICA
    this.agregarCaracteristica = function(){
    	console.log(self.caracteristicaAIngresar);
        this.paisSeleccionado.caracteristicas.push(self.caracteristicaAIngresar);
        //$scope.newItem = null;
      };

// ELIMINAR CONEXION
    this.eliminarConexion = function(conexion) {
    	this.paisSeleccionado.conexiones.splice(this.paisSeleccionado.conexiones.indexOf(conexion),1);
    	self.conexionesPosibles.push(conexion);
    };

// AGREGAR CONEXION
    this.agregarConexion = function(){
        this.paisSeleccionado.conexiones.push(self.conexionAIngresar);
        self.conexionesPosibles.splice(this.conexionesPosibles.indexOf(self.conexionAIngresar),1);
        self.conexionAIngresar = this.conexionesPosibles[0];
        //$scope.newItem = null;
      };
   
// ELIMINAR LUGAR
    this.eliminarLugar = function(lugar) {
      	this.paisSeleccionado.lugares.splice(this.paisSeleccionado.lugares.indexOf(lugar),1);
      	self.lugares.push(lugar);
      };
      
// AGREGAR LUGAR
    this.agregarLugar = function(){
        this.paisSeleccionado.lugares.push(self.lugarAIngresar.nombre);
        self.lugares.splice(this.lugares.indexOf(self.lugarAIngresar),1);
        //$scope.newItem = null;
      };
    
    this.agregarPais = function() {
        Paises.save(this.paisSeleccionado, function(data) {
            //self.notificarMensaje('Libro agregado con id:' + data.id);
            self.actualizarLista();
            self.paisSeleccionado = null;
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