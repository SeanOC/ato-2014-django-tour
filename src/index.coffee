Backbone = require 'backbone'
$ = require 'jquery'

Backbone.$ = $

AppView = require './views/viewport.coffee'
AppRouter = require './router.coffee'

appView = new AppView

$('body').append appView.el

appRouter = new AppRouter appView: appView

Backbone.history.start()