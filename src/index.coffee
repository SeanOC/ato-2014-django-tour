Backbone = require 'backbone'
$ = require 'jquery'

AppView = require './views/viewport'
AppRouter = require './router'

appView = new AppView

$('body').append appView.el
$('head').prepend '<link rel="stylesheet" type="text/css" href="static/css/main.css">'

appRouter = new AppRouter appView: appView

Backbone.history.start()