Backbone = require 'backbone'
$ = require 'jquery'
template = require '../templates/docs.hbs'

module.exports = Backbone.View.extend 
    id: 'docs-slide',

    render: ->
        console.log "Render docs"
        @.$el.html template()

        # $docsContainer = @.$('#docs-container')
        # $docsContainer.load "django-docs/index.html", ->
        #     console.log $docsContainer.find '#s-the-model-layer'
        $iframe = @.$('iframe')

        $iframe.load ->
            iframe = $iframe[0]

            example = iframe.contentWindow.$('#s-forms')

            console.log example

            example.zoomTo()