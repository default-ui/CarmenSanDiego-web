app.factory('ResolverMisterio', function($resource) {
    return $resource('/:dir/:id', {'id': '@iid'}, {
        'iniciarJuego': { method: 'POST', params: {dir: "iniciarJuego"}},
        'viajar': { method: 'POST', params: {dir: "viajar"}},
        'obtenerPais': { method: 'GET', params: {dir:"pais"}},
        'pedirPista': { method: 'GET', params: {dir:"pistaDelLugar"}},
        'emitirOrden': { method: 'POST', params: {dir:"emitirOrdenPara"}},
        'obtenerVillano': { method: 'GET', params: {dir: "villano"}},
        'obtenerVillanos': { method: 'GET', params: {dir: "villanos"}, isArray: true}
    });
});

app.factory('Paises', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
        'get': { method: 'GET', params: {dir:"pais"}},
        'getL': {method: 'GET', params: {dir:"lugares"}, isArray: true},
        'getC': {method: 'GET', params: {dir:"conexiones"}, isArray: true},
        'query': { method: 'GET', params: {dir:"paises"}, isArray: true},
        'update': { method: 'PUT', params: {dir:"pais"}},
        'save': { method: 'POST', params: {dir:"pais"}},
        'remove': { method:'DELETE', params: {dir: "pais"}}
    });
});

app.factory('Villanos', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
        'get': { method: 'GET', params: {dir: "villano"}},
        'query': { method: 'GET', params: {dir:"villanos"}, isArray: true},
        'update': { method: 'PUT', params: {dir: "villano"}},
        'save': { method: 'POST', params: {dir: "villano"}},
        'remove': { method:'DELETE', params: {dir: "villano"}}
    });
});