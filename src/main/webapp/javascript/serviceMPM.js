app.factory('Paises', function($resource) {
    return $resource('/paises/:id', {'id': '@id'}, {
    	'query': { method: 'GET', isArray: true},
        'update': { method: 'PUT' },
        'save': { method: 'POST' },
        'remove': { method:'DELETE' }
    });
});