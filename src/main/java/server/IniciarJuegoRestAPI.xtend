package server

import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import carmenSanDiego.Juego
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.api.annotation.Controller
import carmenSanDiego.Lugar
import carmenSanDiego.Banco

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils

	Juego juego

    new(Juego juego) {
        this.juego = juego
    }
    
    @Get("/inicio-juego")
    def getCaso(String string) {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(this.juego.crearCaso.objeto.toJson)
    }
    
    @Get("/pista-de-lugar")
    def getPistaDelLugar(String lugar, String caso) {
    	val lugar2 = new Banco().toJson
    	val parsedLugar = lugar2.fromJson(Banco)
    	ok(this.juego.pedirPista(parsedLugar))
    }
    
}