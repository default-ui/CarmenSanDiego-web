app.factory('Paises', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
    	'get': { method: 'GET', params: {dir:"pais"}},
    	'query': { method: 'GET', params: {dir:"paises"}, isArray: true}, 
        'update': { method: 'PUT', params: {dir:"pais"} },
        'save': { method: 'POST', params: {dir:"pais"} },
        'remove': { method:'DELETE', params: {dir: "pais"} }
    });
});