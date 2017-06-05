app.factory('OrdenDeArresto', function($resource) {
    return $resource('/emitirOrdenPara', {
        'save': { method: 'POST' }
    });
});

app.factory('Paises', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
        'get': { method: 'GET', params: {dir:"pais"}},
        'getL': {method: 'GET', params: {dir:"lugares"}, isArray: true},
        'query': { method: 'GET', params: {dir:"paises"}, isArray: true},
        'update': { method: 'PUT', params: {dir:"pais"} },
        'save': { method: 'POST', params: {dir:"pais"} },
        'remove': { method:'DELETE', params: {dir: "pais"} }
    });
});

app.factory('Villanos', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
        'get': { method: 'GET', params: {dir: "villano"}},
        'query': { method: 'GET', params: {dir:"villanos"}, isArray: true},
        'update': { method: 'PUT' },
        'save': { method: 'POST', params: {dir: "villano"} },
        'remove': { method:'DELETE', params: {dir: "villano"}}
    });
});