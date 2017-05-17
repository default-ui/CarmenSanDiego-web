package server

import carmenSanDiego.Juego
import carmenSanDiego.Pais
import carmenSanDiego.Villano
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import miniModel.EstadoJuego
import miniModel.MiniExpediente
import miniModel.MiniMapamundi
import miniModel.MiniVillano
import org.uqbar.commons.model.UserException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils
import server.requestData.EmitirOrdenRequest

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
    
    @Post("/emitirOrdenPara")
    def emitirOrdenDeArresto(@Body String body) {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val EmitirOrdenRequest ordenRequest = body.fromJson(EmitirOrdenRequest)
	        try {
	        	// TODO: usar juegoID
	        	var villano = juego.expediente.getVillano(ordenRequest.villanoId)
	        	juego.emitirOrdenDeArresto(villano)
				ok("Orden emitida correctamente")
	        } 
	        catch (UserException exception) {
	        	badRequest(getErrorJson(exception.message))
	        }
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un VillanoID"))
        }
    }
    
    @Get("/paises")
    def getPaises() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.juego.mapa).toJson)

    }

	//req tiene la forma /paises/Argentina
	// estaria funcionando
  	@Get("/pais/:nomb")	
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
	@Delete('/pais/:id')
	def eliminarPais(){
		response.contentType = ContentType.APPLICATION_JSON
		new MiniMapamundi(this.juego.mapa).eliminarPaisMapamundi(id)
		ok()
	}
	
	// ERROR: no puede instanciar lugares porque es una clase abstracta
	// como deberia actulizar el dominio? y el minimapamundi?
	@Post('/pais')
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
    
    @Get('/villano/:id')
	def buscarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = this.juego.expediente.getVillanoById(Integer.parseInt(id))
		ok(new MiniVillano(villano).toJson)
	}
    
    @Delete('/villano/:id')
	def eliminarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		this.juego.expediente.eliminarVillanoConId(Integer.parseInt(id))
		ok()
	}
	
	@Post('/villano')
	def agregarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		this.juego.expediente.agregarVillano(villano)
		ok()
	}
	
	@Put('/villano/:id')
	def editarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		this.juego.expediente.reemplazarVillanoConId(Integer.parseInt(id), villano)
		ok()
	}
   
 }
   