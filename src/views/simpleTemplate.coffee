Backbone = require 'backbone'
$ = require 'jquery'

module.exports = Backbone.View.extend 
    initialize: (options) ->
        @.template = options.template

    render: ->
        this.$el.html @.template()
