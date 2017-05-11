package server

import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import carmenSanDiego.Juego
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.annotation.Controller
import carmenSanDiego.Villano
import org.uqbar.xtrest.api.annotation.Post
import miniModel.EstadoJuego

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils

	Juego juego

    new(Juego juego) {
        this.juego = juego
        this.juego.crearCaso
    }
    
    @Post("/inicio-juego")
    def getCaso() {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(new EstadoJuego(this.juego).toJson)
    }
    
    @Get("/pista-de-lugar")
    def getPistaDelLugar(String lugar) {
    	response.contentType = ContentType.APPLICATION_JSON
    	val lugarActual = this.juego.paisActual.getLugar(lugar)
    	//ok(lugarActual.toJson)
    	ok(this.juego.pedirPista(lugarActual).toJson)
    }
    
    @Get("/paises")
    //TODO: hay recursion infinita aca jajaja ;_;
    def getPaises() {
    	ok(this.juego.mapa.paises.toJson)
    }

	//req tiene la forma /paises?nomb="Argentina"
  	@Get("/paises/:nombre")		
   	def getPaisesById(String nomb) {
    	ok(this.juego.mapa.getPaisFromName(nomb).toJson)
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
   