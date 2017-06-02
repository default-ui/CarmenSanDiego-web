appExp.factory('Villanos', function($resource) {
    return $resource('/:dir/:id', {'id': '@id'}, {
    	'get': { method: 'GET', params: {dir: "villano"}},
        'query': { method: 'GET', params: {dir:"villanos"}, isArray: true},
        'update': { method: 'PUT' },
        'save': { method: 'POST', params: {dir: "villano"} },
        'remove': { method:'DELETE', params: {dir: "villano"}}
    });
});