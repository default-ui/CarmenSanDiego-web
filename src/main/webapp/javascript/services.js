app.factory('OrdenDeArresto', function($resource) {
    return $resource('/emitirOrdenPara', {
        'save': { method: 'POST' }
    });
});

