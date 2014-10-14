Backbone = require 'backbone'
$ = require 'jquery'
template = require '../templates/title.hbs'

module.exports = Backbone.View.extend 
    id: 'title-slide'
    render: ->
        this.$el.html template()
