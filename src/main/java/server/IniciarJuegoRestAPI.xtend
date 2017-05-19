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
import miniModel.EmitirOrdenRequest
import miniModel.DataPais
import utils.CarmenSanDiegoRepoWeb

@Controller
class IniciarJuegoRestAPI {
	
    extension JSONUtils = new CarmenSonUtils
//
//	Juego juego
//
//    new(Juego juego) {
//        this.juego = juego
//        this.juego.crearCaso
//    }

	CarmenSanDiegoRepoWeb repo
    
        new(CarmenSanDiegoRepoWeb carmenRepo) {
        this.repo = carmenRepo
    }
    
//    @Post("/inicio-juego")
//    def getCaso() {
//        response.contentType = ContentType.APPLICATION_JSON
//       	ok(new EstadoJuego(this.juego).toJson)
//       //	ok(this.estado.toJson)
//    }
    
    ////http://localhost:3000/iniciarJuego
    @Post("/iniciarJuego")
    def getPartida() {
        response.contentType = ContentType.APPLICATION_JSON
           var juego = new Juego(repo.juegoID, repo.mapa, repo.expediente)
        	repo.actualizarJuego(juego)
       	ok(new EstadoJuego(juego).toJson)
    }
    /////
    
    //la request tiene la forma http://localhost:3000/pista-de-lugar/1?lugar=Banco
    @Get("/pistaDelLugar/:id")
    def getPistaDelLugar(String lugar) {
    	response.contentType = ContentType.APPLICATION_JSON
    	var Juego caso = repo.getCaso(Integer.valueOf(id)) as Juego
    	val lugarActual = caso.paisActual.getLugar(lugar)
    	ok(caso.pedirPista(lugarActual).toJson)
    }
    
    /*
     * Request con la forma http://localhost:3000/emitirOrdenPara (hay que pasarle un body)
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
	        	//ok(ordenRequest.toJson)
	        	//ok(villano.toJson)
				//ok(caso.ordenDeArresto.toJson)
				//ok(repo.partidas.get(0).ordenDeArresto.toJson)
				// postman me tira un error rarisimo ??: Unexpected 'O' pero probe todo lo anterior
				// y es correcto.
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
     * req tiene la forma http://localhost:3000/paises
     */
    @Get("/paises")
    def getPaises() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.repo.mapa).mapa.toJson)

    }

	/*
	 * req tiene la forma http://localhost:3000/pais/1
	 * 
	 */
  	@Get("/pais/:id")	
  	def getPaisesById() {	
   		response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniMapamundi(this.repo.mapa).getPaisById(Integer.valueOf(id)).toJson)

    }    
//    
//    @Put("/paises/:id")
//    def actualizarPais(@Body String body){
//  		var DataPais paisTemp = body.fromJson(DataPais)
//    	ok(paisTemp.toJson)
//		//TODO: consultar no tengo ideaaa
//    }
//
//	//request de la forma http://localhost:3000/paises/Brasil
//	//falta mensaje de ok (strign dicendo ok)
//	// consultar: y con el dominio que pasa?
//	@Delete('/pais/:id')
//	def eliminarPais(){
//		response.contentType = ContentType.APPLICATION_JSON
//		new MiniMapamundi(this.juego.mapa).eliminarPaisMapamundi(id)
//		ok()
//	}
//	
//	// ERROR: no puede instanciar lugares porque es una clase abstracta
//	// como deberia actulizar el dominio? y el minimapamundi?
//	@Post('/pais')
//	def crearPais(@Body String body){
//		response.contentType = ContentType.APPLICATION_JSON
//		val Pais nuevoPais = body.fromJson(Pais)
//		ok(nuevoPais.toJson)
//		
//	}
//    


//    
////    @Post("/viajar")
////    def viajar(String destinoId, String juego) {
////    	val destino = this.juego.getPais(destinoId)
////    	this.juego.viajar(destino)
////    }
//    
    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }
    
    /*
     * Request con la forma http://localhost:3000/villanos
     */
    
    @Get("/villanos")
    def getVillanos() {
    	response.contentType = ContentType.APPLICATION_JSON
    	ok(new MiniExpediente(this.repo.expediente).toJson)
    }
    
    /*
     * Request con la forma http://localhost:3000/villano/0
     */
    @Get('/villano/:id')
	def buscarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = this.repo.expediente.getVillanoById(Integer.parseInt(id))
		ok(new MiniVillano(villano).toJson)
	}
	
	/*
     * Request con la forma http://localhost:3000/villano/0
     */
    
    @Delete('/villano/:id')
	def eliminarVillano() {
		response.contentType = ContentType.APPLICATION_JSON
		this.repo.expediente.eliminarVillanoConId(Integer.parseInt(id))
		ok()
	}
	
	/*
     * Request con la forma http://localhost:3000/villano + un body
     */
	
	@Post('/villano')
	def agregarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		villano.id = repo.villanoId
		this.repo.expediente.agregarVillano(villano)
		ok(new MiniVillano(villano).toJson)
	}
	
	 /*
     * Request con la forma http://localhost:3000/villano/0 + un body
     */
	
	@Put('/villano/:id')
	def editarVillano(@Body String body) {
		response.contentType = ContentType.APPLICATION_JSON
		val villano = body.fromJson(Villano)
		this.repo.expediente.reemplazarVillanoConId(Integer.parseInt(id), villano)
		ok()
	}
   
 }
   