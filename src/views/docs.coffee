Backbone = require 'backbone'
_ = require 'lodash'
$ = require 'jquery'
template = require '../templates/docs.hbs'

module.exports = Backbone.View.extend 
    className: 'docs-slide'

    initialize: (options) ->
        @.targetURL = options.targetURL
        @.isLoaded = false
        @.currentStep = -1
        @.postLoadQueue = []
        @.steps = options.steps

    render: ->
        console.log "Render docs"
        @.$el.html template targetURL: @.targetURL

        # $docsContainer = @.$('#docs-container')
        # $docsContainer.load "django-docs/index.html", ->
        #     console.log $docsContainer.find '#s-the-model-layer'
        @.$iframe = @.$('iframe')

        @.$iframe.load _.bind @.onIFrameLoad, @

    onIFrameLoad: ->
        console.log 'onIFrameLoad'
        @.isLoaded = true
        @.inner$ = @.$iframe[0].contentWindow.$
        
        func() for func in @.postLoadQueue
        @.postLoadQueue = []

    goTo: (step) ->
        if @.isLoaded
            target = @.steps[step]
            console.log 'target'
            console.log target
            @.$('iframe')[0].contentWindow.$(target)
            $node =  @.inner$(target)
            console.log $node
            $node.zoomTo()
            if target != 'body'
                @.inner$('.talk-highlight').removeClass('talk-highlight')
                $node.addClass('talk-highlight')
        else
            @.postLoadQueue.push _.bind(@.goTo, @, step)
