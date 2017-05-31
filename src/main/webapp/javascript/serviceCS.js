app.factory('Villanos', function($resource) {
    return $resource('/villano/:id', {'id': '@id'}, {
    	'query': { method: 'GET'},
        'update': { method: 'PUT' },
        'save': { method: 'POST' },
        'remove': { method:'DELETE' }
    });
});