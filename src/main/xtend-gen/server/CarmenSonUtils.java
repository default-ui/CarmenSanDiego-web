package server;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.uqbar.xtrest.json.JSONUtils;

@SuppressWarnings("all")
public class CarmenSonUtils extends JSONUtils {
  private ObjectMapper mapper = new ObjectMapper();
  
  @Override
  public String toJson(final Object obj) {
    try {
      String _xblockexpression = null;
      {
        this.mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        _xblockexpression = this.mapper.writeValueAsString(obj);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
