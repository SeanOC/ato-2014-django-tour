var Backbone = require('backbone');


var AppView = require('./views/viewport');
var AppRouter = require('./router');

var appView = new AppView();

$('body').append(appView.el);
$('head').prepend('<link rel="stylesheet" type="text/css" href="static/css/main.css">');

var appRouter = new AppRouter({appView: appView});

Backbone.history.start();