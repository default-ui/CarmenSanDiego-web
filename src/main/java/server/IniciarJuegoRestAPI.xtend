package server

import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import carmenSanDiego.Juego
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.annotation.Controller
import carmenSanDiego.Villano
import org.uqbar.xtrest.api.annotation.Post
import miniModel.EstadoJuego
import miniModel.MiniPais
import miniModel.MiniMapamundi
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.api.annotation.Delete

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils

	Juego juego
	EstadoJuego estado
	MiniMapamundi mapamundi

    new(Juego juego) {
        this.juego = juego
        this.juego.crearCaso
        this.estado = new EstadoJuego(juego)
        this.mapamundi = new MiniMapamundi(juego)
        
    }
    
    @Post("/inicio-juego")
    def getCaso() {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(new EstadoJuego(this.juego).toJson)
       //	ok(this.estado.toJson)
    }
    
    
    //la request tiene la forma http://localhost:3000/pista-de-lugar?lugar=Banco
    @Get("/pista-de-lugar")
    def getPistaDelLugar(String lugar) {
    	response.contentType = ContentType.APPLICATION_JSON
    	val lugarActual = this.juego.paisActual.getLugar(lugar)
    	ok(this.juego.pedirPista(lugarActual).toJson)
    }
    
    @Get("/paises")
    def getPaises() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(this.mapamundi.mapa.toJson)
    }

	//req tiene la forma /paise/Argentina
	// estaria funcionando
  	@Get("/paises/:nomb")	
  	def getPaisesById() {	
   	//def getPaisesById(String nomb) {
   		response.contentType = ContentType.APPLICATION_JSON
    	ok(this.mapamundi.getPaisById(nomb).toJson)
    }    
    
//    @Put("paises/:id")
//    def actualizarPais(){
//    	ok()
//		//TODO: consultar no tengo ideaaa
//    }
	//request de la forma http://localhost:3000/paises/Brasil
	//falta mensaje de ok 
	// consultar: y con el dominio que pasa?
	@Delete('/paises/:id')
	def eliminarPais(){
		response.contentType = ContentType.APPLICATION_JSON
		this.mapamundi.eliminarPaisMapamundi(id)
		ok()
	}
    
    @Get("/orden-de-arresto")
    def emitirOrdenPara(String villano, String juego) {
    	response.contentType = ContentType.APPLICATION_JSON
        var parsedVillano = villano.fromJson(Villano)
        if (parsedVillano == null) {
			notFound(getErrorJson("No existe libro con ese id"))
		} else {
		 	ok(this.juego.emitirOrdenDeArresto(parsedVillano).toJson)
        }
    }
    
//    @Post("/viajar")
//    def viajar(String destinoId, String juego) {
//    	val destino = this.juego.getPais(destinoId)
//    	this.juego.viajar(destino)
//    }
    
    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }
   
 }
   