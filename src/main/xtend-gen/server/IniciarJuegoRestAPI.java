package server;

import carmenSanDiego.Banco;
import carmenSanDiego.Caso;
import carmenSanDiego.Juego;
import carmenSanDiego.Mapamundi;
import carmenSanDiego.OrdenDeArresto;
import carmenSanDiego.Pais;
import carmenSanDiego.Villano;
import com.google.common.base.Objects;
import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.eclipse.jetty.server.Request;
import org.eclipse.xtext.xbase.lib.Extension;
import org.uqbar.xtrest.api.Result;
import org.uqbar.xtrest.api.annotation.Controller;
import org.uqbar.xtrest.api.annotation.Get;
import org.uqbar.xtrest.http.ContentType;
import org.uqbar.xtrest.json.JSONUtils;
import org.uqbar.xtrest.result.ResultFactory;
import server.CarmenSonUtils;

@Controller
@SuppressWarnings("all")
public class IniciarJuegoRestAPI extends ResultFactory {
  @Extension
  private JSONUtils _jSONUtils = new CarmenSonUtils();
  
  private Juego juego;
  
  public IniciarJuegoRestAPI(final Juego juego) {
    this.juego = juego;
  }
  
  @Get("/inicio-juego")
  public Result getCaso(final String string, final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) {
    Result _xblockexpression = null;
    {
      response.setContentType(ContentType.APPLICATION_JSON);
      Caso _crearCaso = this.juego.crearCaso();
      String _objeto = _crearCaso.getObjeto();
      String _json = this._jSONUtils.toJson(_objeto);
      _xblockexpression = ResultFactory.ok(_json);
    }
    return _xblockexpression;
  }
  
  @Get("/pista-de-lugar")
  public Result getPistaDelLugar(final String lugar, final String caso, final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) {
    Result _xblockexpression = null;
    {
      response.setContentType(ContentType.APPLICATION_JSON);
      Banco _banco = new Banco();
      final String lugar2 = this._jSONUtils.toJson(_banco);
      final Banco parsedLugar = this._jSONUtils.<Banco>fromJson(lugar2, Banco.class);
      String _pedirPista = this.juego.pedirPista(parsedLugar);
      _xblockexpression = ResultFactory.ok(_pedirPista);
    }
    return _xblockexpression;
  }
  
  @Get("/paises")
  public Result getPaises(final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) {
    Mapamundi _mapa = this.juego.getMapa();
    List<Pais> _paises = _mapa.getPaises();
    String _json = this._jSONUtils.toJson(_paises);
    return ResultFactory.ok(_json);
  }
  
  @Get("/paises/:nombre")
  public Result getPaisesById(final String nomb, final String nombre, final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) {
    Mapamundi _mapa = this.juego.getMapa();
    Pais _paisFromName = _mapa.getPaisFromName(nomb);
    String _json = this._jSONUtils.toJson(_paisFromName);
    return ResultFactory.ok(_json);
  }
  
  @Get("/orden-de-arresto")
  public Result emitirOrdenPara(final String villano, final String caso, final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) {
    Result _xblockexpression = null;
    {
      response.setContentType(ContentType.APPLICATION_JSON);
      Villano parsedVillano = this._jSONUtils.<Villano>fromJson(villano, Villano.class);
      Result _xifexpression = null;
      boolean _equals = Objects.equal(parsedVillano, null);
      if (_equals) {
        String _errorJson = this.getErrorJson("No existe libro con ese id");
        _xifexpression = ResultFactory.notFound(_errorJson);
      } else {
        OrdenDeArresto _emitirOrdenDeArresto = this.juego.emitirOrdenDeArresto(parsedVillano);
        String _json = this._jSONUtils.toJson(_emitirOrdenDeArresto);
        _xifexpression = ResultFactory.ok(_json);
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
  
  private String getErrorJson(final String message) {
    return (("{ \"error\": \"" + message) + "\" }");
  }
  
  public void handle(final String target, final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) throws IOException, ServletException {
    {
    	Matcher matcher = 
    		Pattern.compile("/inicio-juego").matcher(target);
    	if (request.getMethod().equalsIgnoreCase("Get") && matcher.matches()) {
    		// take parameters from request
    		String string = request.getParameter("string");
    		
    		// take variables from url
    		
    		
    	    Result result = getCaso(string, target, baseRequest, request, response);
    	    result.process(response);
    	    
    		response.addHeader("Access-Control-Allow-Origin", "*");
    	    baseRequest.setHandled(true);
    	    return;
    	}
    }
    {
    	Matcher matcher = 
    		Pattern.compile("/pista-de-lugar").matcher(target);
    	if (request.getMethod().equalsIgnoreCase("Get") && matcher.matches()) {
    		// take parameters from request
    		String lugar = request.getParameter("lugar");
    		String caso = request.getParameter("caso");
    		
    		// take variables from url
    		
    		
    	    Result result = getPistaDelLugar(lugar, caso, target, baseRequest, request, response);
    	    result.process(response);
    	    
    		response.addHeader("Access-Control-Allow-Origin", "*");
    	    baseRequest.setHandled(true);
    	    return;
    	}
    }
    {
    	Matcher matcher = 
    		Pattern.compile("/paises").matcher(target);
    	if (request.getMethod().equalsIgnoreCase("Get") && matcher.matches()) {
    		// take parameters from request
    		
    		// take variables from url
    		
    		
    	    Result result = getPaises(target, baseRequest, request, response);
    	    result.process(response);
    	    
    		response.addHeader("Access-Control-Allow-Origin", "*");
    	    baseRequest.setHandled(true);
    	    return;
    	}
    }
    {
    	Matcher matcher = 
    		Pattern.compile("/paises/(\\w+)").matcher(target);
    	if (request.getMethod().equalsIgnoreCase("Get") && matcher.matches()) {
    		// take parameters from request
    		String nomb = request.getParameter("nomb");
    		
    		// take variables from url
    		String nombre = matcher.group(1);
    		
    		
    	    Result result = getPaisesById(nomb, nombre, target, baseRequest, request, response);
    	    result.process(response);
    	    
    		response.addHeader("Access-Control-Allow-Origin", "*");
    	    baseRequest.setHandled(true);
    	    return;
    	}
    }
    {
    	Matcher matcher = 
    		Pattern.compile("/orden-de-arresto").matcher(target);
    	if (request.getMethod().equalsIgnoreCase("Get") && matcher.matches()) {
    		// take parameters from request
    		String villano = request.getParameter("villano");
    		String caso = request.getParameter("caso");
    		
    		// take variables from url
    		
    		
    	    Result result = emitirOrdenPara(villano, caso, target, baseRequest, request, response);
    	    result.process(response);
    	    
    		response.addHeader("Access-Control-Allow-Origin", "*");
    	    baseRequest.setHandled(true);
    	    return;
    	}
    }
    this.pageNotFound(baseRequest, request, response);
  }
  
  public void pageNotFound(final Request baseRequest, final HttpServletRequest request, final HttpServletResponse response) throws IOException, ServletException {
    response.getWriter().write(
    	"<html><head><title>XtRest - Page Not Found!</title></head>" 
    	+ "<body>"
    	+ "	<h1>Page Not Found !</h1>"
    	+ "	Supported resources:"
    	+ "	<table>"
    	+ "		<thead><tr><th>Verb</th><th>URL</th><th>Parameters</th></tr></thead>"
    	+ "		<tbody>"
    	+ "			<tr>"
    	+ "				<td>GET</td>"
    	+ "				<td>/inicio-juego</td>"
    	+ "				<td>string</td>"
    	+ "			</tr>"
    	+ "			<tr>"
    	+ "				<td>GET</td>"
    	+ "				<td>/pista-de-lugar</td>"
    	+ "				<td>lugar, caso</td>"
    	+ "			</tr>"
    	+ "			<tr>"
    	+ "				<td>GET</td>"
    	+ "				<td>/paises</td>"
    	+ "				<td></td>"
    	+ "			</tr>"
    	+ "			<tr>"
    	+ "				<td>GET</td>"
    	+ "				<td>/paises/:nombre</td>"
    	+ "				<td>nomb, nombre</td>"
    	+ "			</tr>"
    	+ "			<tr>"
    	+ "				<td>GET</td>"
    	+ "				<td>/orden-de-arresto</td>"
    	+ "				<td>villano, caso</td>"
    	+ "			</tr>"
    	+ "		</tbody>"
    	+ "	</table>"
    	+ "</body>"
    );
    response.setStatus(404);
    baseRequest.setHandled(true);
  }
}
