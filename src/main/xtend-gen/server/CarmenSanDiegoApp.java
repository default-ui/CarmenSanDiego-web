package server;

import carmenSanDiego.Expediente;
import carmenSanDiego.Juego;
import carmenSanDiego.Mapamundi;
import org.uqbar.xtrest.api.XTRest;
import server.IniciarJuegoRestAPI;
import utils.DummyData;

@SuppressWarnings("all")
public class CarmenSanDiegoApp {
  public static void main(final String[] args) {
    final Mapamundi mapa = DummyData.crearMapamundiDummy();
    final Expediente expediente = DummyData.crearExpedienteDummy();
    Juego juego = new Juego(mapa, expediente);
    IniciarJuegoRestAPI _iniciarJuegoRestAPI = new IniciarJuegoRestAPI(juego);
    XTRest.startInstance(_iniciarJuegoRestAPI, 3000);
  }
}
