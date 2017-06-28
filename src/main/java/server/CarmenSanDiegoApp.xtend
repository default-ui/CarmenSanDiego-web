package server

import carmenSanDiego.Juego
import utils.DummyData
import org.uqbar.xtrest.api.XTRest
import utils.CarmenSanDiegoRepoWeb
import server.IniciarJuegoRestAPI

class CarmenSanDiegoApp {
	
	def static void main(String[] args) {
		val mapa = DummyData.crearMapamundiDummy
		val expediente = DummyData.crearExpedienteDummy
		var juego = new Juego(mapa, expediente)
		
        XTRest.startInstance(new IniciarJuegoRestAPI(new CarmenSanDiegoRepoWeb), 3000)
    }
	
}
