var Backbone = require('backbone');
var $ = require('jquery');

Backbone.$ = $;


var AppView = require('./app/views/viewport');
var AppRouter = require('./app/router');

var appView = new AppView();

$('body').append(appView.el);
$('head').prepend('<link rel="stylesheet" type="text/css" href="static/css/main.css">');

var appRouter = new AppRouter({appView: appView});

Backbone.history.start();