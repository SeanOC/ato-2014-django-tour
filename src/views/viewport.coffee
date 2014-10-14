Backbone = require 'backbone'
$ = require 'jquery'

module.exports = Backbone.View.extend
    id: 'viewport'

    update: (content) ->
        $children = @.$el.children()

        if $children.length > 0
            @.$el.empty()

        @.$el.html content