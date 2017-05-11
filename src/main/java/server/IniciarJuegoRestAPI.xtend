package server

import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import carmenSanDiego.Juego
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.annotation.Controller
import carmenSanDiego.Lugar
import carmenSanDiego.Banco
import carmenSanDiego.Villano
import org.uqbar.xtrest.api.annotation.Post
import miniModel.EstadoJuego
import miniModel.MiniPais

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils

	Juego juego
	EstadoJuego estado

    new(Juego juego) {
        this.juego = juego
        this.juego.crearCaso
        this.estado = new EstadoJuego(juego)
        
    }
    
    @Get("/inicio-juego")
    //TODO: tiene que devolver un juego. nuestro JUEGO es su CASO
    def getCaso() {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(this.juego.crearCaso.objeto.toJson)
    }
    
    @Get("/pista-de-lugar")
    def getPistaDelLugar(String lugar) {
    	response.contentType = ContentType.APPLICATION_JSON
    	val lugarActual = this.juego.paisActual.getLugar(lugar)
    	ok(this.juego.pedirPista(lugarActual).toJson)
    }
    
    @Get("/paises")
    def getPaises() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(this.estado.mapamundi.toJson)
    }

	//req tiene la forma /paises?nomb="Argentina"
	// TODO: Aca hay un error porque no puedo hacer que funcione con @Get("/paises/:nomb")
	// La query la hace asi como esta pero no es el nombre que corresponde ni la manera (el parametro
	// deberia estar en la annotation)
  	@Get("/paise")		
   	def getPaisesById(String nomb) {
   		response.contentType = ContentType.APPLICATION_JSON
    	ok(this.estado.getPaisById(nomb).toJson)
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
   