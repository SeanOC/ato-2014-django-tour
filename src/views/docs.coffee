Backbone = require 'backbone'
_ = require 'lodash'
$ = require 'jquery'
template = require '../templates/docs.hbs'

module.exports = Backbone.View.extend 
    className: 'docs-slide',

    initialize: (options) ->
        console.log "Initialize docsview"
        console.log options
        @.targetURL = options.targetURL

    render: ->
        console.log "Render docs"
        @.$el.html template targetURL: @.targetURL

        # $docsContainer = @.$('#docs-container')
        # $docsContainer.load "django-docs/index.html", ->
        #     console.log $docsContainer.find '#s-the-model-layer'
        $iframe = @.$('iframe')

        $iframe.load _.bind @.onIFrameLoad, @

    onIFrameLoad: ->
        console.log 'here'
        console.log @
        $iframe = @.$('iframe')
        iframe = $iframe[0]
        example = iframe.contentWindow.$('#s-getting-help')
        example.zoomTo()