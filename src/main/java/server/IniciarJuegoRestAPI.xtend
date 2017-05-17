package server

import carmenSanDiego.Juego
import carmenSanDiego.Pais
import carmenSanDiego.Villano
import miniModel.EstadoJuego
import miniModel.MiniMapamundi
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Post
import miniModel.MiniExpediente

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
    	ok(new MiniMapamundi(this.juego.mapa).toJson)

    }

	//req tiene la forma /paises/Argentina
	// estaria funcionando
  	@Get("/paises/:nomb")	
  	def getPaisesById() {	
   	//def getPaisesById(String nomb) {
   		response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.juego.mapa).getPaisById(nomb).toJson)

    }    
    
//    @Put("paises/:id")
//    def actualizarPais(){
//    	ok()
//		//TODO: consultar no tengo ideaaa
//    }

	//request de la forma http://localhost:3000/paises/Brasil
	//falta mensaje de ok (strign dicendo ok)
	// consultar: y con el dominio que pasa?
	@Delete('/paises/:id')
	def eliminarPais(){
		response.contentType = ContentType.APPLICATION_JSON
		new MiniMapamundi(this.juego.mapa).eliminarPaisMapamundi(id)
		ok()
	}
	
	// ERROR: no puede instanciar lugares porque es una clase abstracta
	// como deberia actulizar el dominio? y el minimapamundi?
	@Post('/paises')
	def crearPais(@Body String body){
		response.contentType = ContentType.APPLICATION_JSON
		val Pais nuevoPais = body.fromJson(Pais)
		ok(nuevoPais.toJson)
		
	}
    
    @Get("/orden-de-arresto")
    def emitirOrdenPara(String villano, String juego) {
    	response.contentType = ContentType.APPLICATION_JSON
        var parsedVillano = villano.fromJson(Villano)
        if (parsedVillano === null) {
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
    
    @Get("/villanos")
    def getVillanos() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniExpediente(this.juego.expediente).toJson)
    }
   
 }
   