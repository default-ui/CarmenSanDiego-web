app.controller('VillanosController', function($resource, Villanos) {
    'use strict';

    var self = this;

    self.villanos = [];


    this.actualizarLista = function() {
        Villanos.query(function(data) {
        console.log(data);
            self.villanos = data.villanos;
        });
    };
    
    this.actualizarLista();
   
});