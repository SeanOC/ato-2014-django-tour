Backbone = require 'backbone'
$ = require 'jquery'

module.exports = Backbone.View.extend
    id: 'viewport'

    update: (contentView) ->
        if contentView == @.currentContentView
            return

        $children = @.$el.children()
        if $children.length > 0
            @.$el.empty()

        @.currentContentView = contentView
        contentView.render()
        @.$el.html contentView.el