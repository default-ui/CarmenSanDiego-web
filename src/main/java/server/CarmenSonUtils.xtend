package server

import org.uqbar.xtrest.json.JSONUtils
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature

class CarmenSonUtils extends JSONUtils {
	
	ObjectMapper mapper = new ObjectMapper();
	
	override toJson(Object obj) {
		mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
		mapper.writeValueAsString(obj)
	}
}