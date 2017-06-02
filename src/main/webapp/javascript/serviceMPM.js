app.factory('Paises', 'Pais', function($resource) {
    return $resource('/:id1/:id', {'id': '@id'}, {
    	'query': { method: 'GET', params: {id1: "paises"}, isArray: true},
    	'query2': {method: 'GET', params: {id1:"pais"}}, 
        'update': { method: 'PUT' },
        'save': { method: 'POST' },
        'remove': { method:'DELETE', params: {id1: "pais"} }
    });
});