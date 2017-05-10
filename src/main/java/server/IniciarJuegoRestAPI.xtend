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
    
    
    
    
    
}