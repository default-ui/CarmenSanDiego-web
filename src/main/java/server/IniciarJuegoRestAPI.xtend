package main.java.server

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import utils.CarmenSanDiegoRepoWeb
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.http.ContentType
import carmenSanDiego.Juego
import miniModel.EstadoJuego
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Body
import miniModel.EmitirOrdenRequest
import org.uqbar.commons.model.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import miniModel.MiniMapamundi
import org.uqbar.xtrest.api.annotation.Put
import miniModel.DataPais
import carmenSanDiego.Pais
import org.uqbar.xtrest.api.annotation.Delete
import miniModel.MiniPais
import miniModel.ViajarRequest
import miniModel.MiniExpediente
import miniModel.MiniVillano
import carmenSanDiego.Villano
import miniModel.MiniPaisConConxYCarac
import miniModel.MiniLugar

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils
    
	CarmenSanDiegoRepoWeb repo
    
        new(CarmenSanDiegoRepoWeb carmenRepo) {
        this.repo = carmenRepo
    }
    
    /*
     * Request con la forma http://localhost:3000/iniciarJuego.
     * Inicia una partida (retorna su id)
     */
    @Post("/iniciarJuego")
    def getPartida() {
        response.contentType = ContentType.APPLICATION_JSON
           var juego = new Juego(repo.juegoID, repo.mapa, repo.expediente)
        	repo.actualizarJuego(juego)
       	ok(new EstadoJuego(juego).toJson)
    }
    
    /*
     * Request con la forma: http://localhost:3000/pista-de-lugar/1?lugar=Banco
     * Con la id del caso(partida) y el nombre del lugar obtiene la pista del pais actual
     */
    @Get("/pistaDelLugar/:id")
    def getPistaDelLugar(String lugar) {
    	response.contentType = ContentType.APPLICATION_JSON
    	var Juego caso = repo.getCaso(Integer.valueOf(id)) as Juego
    	val lugarActual = caso.paisActual.getLugar(lugar)
    	ok(new MiniLugar(caso.pedirPista(lugarActual)).toJson)
    }
    
    /*
     * Request con la forma http://localhost:3000/emitirOrdenPara (hay que pasarle un body)
     * Emite una orden de arresto para un villano en una partida determinada. 
     * La forma del body es:  { "villanoId": 6, "casoId": 1}
     */
    
    @Post("/emitirOrdenPara")
    def emitirOrdenDeArresto(@Body String body) {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val EmitirOrdenRequest ordenRequest = body.fromJson(EmitirOrdenRequest)
	        try {
	        	var Juego caso = repo.getCaso(ordenRequest.casoId)
	        	
	        	var villano = caso.expediente.getVillano(ordenRequest.villanoId)
	        	caso.emitirOrdenDeArresto(villano)
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
    
    /*
     * Request tiene la forma http://localhost:3000/paises
     * Muestra todos la id y el nombre de todos los paises del mapamundi
     */
    @Get("/paises")
    def getPaises() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.repo.mapa).mapa.toJson)

    }

	/*
	 * Request tiene la forma http://localhost:3000/pais/1
	 * Devuelve informacion especifica (conexiones, caracteristicas) del pais consultado
	 */
  	@Get("/pais/:id")	
  	def getPaisesById() {	
   		response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.repo.mapa).getPaisById(Integer.valueOf(id)).toJson)

    }
    
    /*
	 * Request tiene la forma http://localhost:3000/pais/1 + un body.
	 * Edita un pais en cuestion.
	 * La forma del body es: { "id": 7,"nombre": "Egipto", "lugares": [ "Embajada",...], "conexiones": [{"nombre": "Cuba",
      "id": 2}, ...]}
	 */
    @Put("/pais/:id")
    def actualizarPais(@Body String body){
  		var DataPais paisTemp = body.fromJson(DataPais)
  		repo.mapa.eliminarPaisById(paisTemp.id)
  		var paisEditado = new Pais(paisTemp, repo.mapa)
  		repo.mapa.agregarPais(paisEditado)
    	ok("Pais actualizado correctamente.")
    }

	/*
	 * Request tiene la forma: http://localhost:3000/pais/1
	 * Borra un pais en cuestion
	 */
	@Delete('/pais/:id')
	def eliminarPais(){
		response.contentType = ContentType.APPLICATION_JSON
		repo.mapa.eliminarPaisById(Integer.valueOf(id))
		ok("Pais eliminado correctamente.")
	}
	
	/*
	 * Request tiene la forma: http://localhost:3000/pais/ + un body
	 * Crea un pais y lo agrega al mapamundi
	 ** La forma del body es: {"nombre": "Egipto", "lugares": [ "Embajada",...], "conexiones": [{"nombre": "Cuba",
      "id": 2}, ...]}
	 */
	@Post('/pais')
	def crearPais(@Body String body){
		response.contentType = ContentType.APPLICATION_JSON
		var DataPais nuevoPaisTemp = body.fromJson(DataPais)
		nuevoPaisTemp.id = repo.nextIdPais
		var nuevoPais = new Pais(nuevoPaisTemp, repo.mapa)
		repo.mapa.agregarPais(nuevoPais)
		ok(new MiniPaisConConxYCarac(nuevoPais).toJson)
		
	}
    
 	
   /*
     * Request con la forma http://localhost:3000/viajar + un body
     * Viaja a un pais conectado al actual
     * La forma del body es: {"destinoId": 2, "casoId": 1}
     */
    
    @Post("/viajar")
    def viajar(@Body String body) {
    	var viajarRequest = body.fromJson(ViajarRequest)
    	var juego = this.repo.getCaso(viajarRequest.casoId)
    	val destino = this.repo.mapa.getPaisFromId(viajarRequest.destinoId)
    	juego.viajar(destino)
    	ok(new EstadoJuego(juego).toJson)
    }
    
    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }
    
    /*
     * Request con la forma http://localhost:3000/villanos
     * Retorna la lista de todos los villanos
     */
    
    @Get("/villanos")
    def getVillanos() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniExpediente(this.repo.expediente).villanos.toJson)
    }
    
    /*
     * Request con la forma http://localhost:3000/villano/0
     * Devuelve un villano en particular detalladamente
     */
    @Get('/villano/:id')
	def buscarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		ok(new MiniExpediente(this.repo.expediente).getVillanoById(Integer.valueOf(id)).toJson)
	}
	
	/*
     * Request con la forma http://localhost:3000/villano/0
     * Elimina un villano en cuestion
     */
    
    @Delete('/villano/:id')
	def eliminarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		this.repo.expediente.eliminarVillanoConId(Integer.parseInt(id))
		ok()
	}
	
	/*
     * Request con la forma http://localhost:3000/villano + un body
     * Agrega un villano sospechoso al expediente
     * La forma del body es: {"nombre": "Carmen San Diego","sexo": "Femenino", "senasParticulares": ["Pelo Rojo",...], "hobbies": ["Juega Tenis"]}
     */
	
	@Post('/villano')
	def agregarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		villano.id = repo.getNextIdVillano()
		this.repo.expediente.agregarVillano(villano)
		ok(new MiniVillano(villano).toJson)
	}
	
	 /*
     * Request con la forma http://localhost:3000/villano/0 + un body
     * Edita un villano existente
     * * La forma del body es: {"id": 1, "nombre": "Carmen San Diego","sexo": "Femenino", "senasParticulares": ["Pelo Rojo",...],
     *  "hobbies": ["Juega Tenis"]}
     */
	
	@Put('/villano/:id')
	def editarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		this.repo.expediente.reemplazarVillanoConId(Integer.parseInt(id), villano)
		ok()
	}
   
 }
   