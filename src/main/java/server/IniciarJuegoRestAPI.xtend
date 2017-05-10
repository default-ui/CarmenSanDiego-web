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

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils

	Juego juego

    new(Juego juego) {
        this.juego = juego
    }
    
    @Get("/inicio-juego")
    //TODO: tiene que devolver un juego. nuestro JUEGO es su CASO
    def getCaso() {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(this.juego.crearCaso.objeto.toJson)
    }
    
    @Get("/pista-de-lugar")
    def getPistaDelLugar(String lugar, String juego) {
    	response.contentType = ContentType.APPLICATION_JSON
    	val lugar2 = new Banco().toJson
    	val parsedLugar = lugar2.fromJson(Banco)
    	ok(this.juego.pedirPista(parsedLugar))
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
    
    @Post("/viajar")
    def viajar(String destinoId, String juego) {
    	val destino = this.juego.getPais(destinoId)
    	this.juego.viajar(destino)
    }
    
    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }
   
 }
   