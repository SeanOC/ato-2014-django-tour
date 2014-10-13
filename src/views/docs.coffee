Backbone = require 'backbone'
$ = require 'jquery'
template = require '../templates/docs.hbs'

module.exports = Backbone.View.extend 
    id: 'docs-slide',

    render: ->
        console.log "Render docs"
        @.$el.html template()

        $iframe = @.$('iframe')

        $iframe.load ->
            innerDoc = $iframe[0].contentDocument
            $innerDoc = $(innerDoc)
            example = $innerDoc.find('#s-forms')
            # example.zoomTo()