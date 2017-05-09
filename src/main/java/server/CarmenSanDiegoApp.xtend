package server

import carmenSanDiego.Juego
import utils.DummyData
import org.uqbar.xtrest.api.XTRest

class CarmenSanDiegoApp {
	
	def static void main(String[] args) {
		val mapa = DummyData.crearMapamundiDummy
		val expediente = DummyData.crearExpedienteDummy
		var juego = new Juego(mapa, expediente)
		
        XTRest.startInstance(new IniciarJuegoRestAPI(juego), 3000)
    }
	
}