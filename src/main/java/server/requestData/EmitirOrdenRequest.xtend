package server.requestData

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class EmitirOrdenRequest {
	
  Integer villanoId
  Integer casoId
  
  new () {
  	villanoId = null
  	casoId = null
  }
  
}
