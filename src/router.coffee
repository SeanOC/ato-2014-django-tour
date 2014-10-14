Backbone = require 'backbone'
$ = require 'jquery'
_ = require 'lodash'



TitleView = require './views/title.coffee'
DocsView = require './views/docs.coffee'

module.exports = Backbone.Router.extend
    routes:
        "title": "title",
        "docs": "docs",
        "*actions": "defaultRoute"

    pages: [
        'title',
        'docs',
    ]

    initialize: (options) ->
        @.appView = options.appView
        $(document).keydown _.bind(@.handleKeyDown, @)
        @.currentPage = 0

    title: ->
        titleView = new TitleView()
        titleView.render()
        @.appView.update titleView.el
        @.currentPage = @.pages.indexOf 'title'
        console.log "title done"

    docs: ->
        docsView = new DocsView targetURL: 'django-docs/index.html'
        docsView.render()
        @.appView.update docsView.el
        @.currentPage = @.pages.indexOf 'docs'
        console.log "docs done"

    defaultRoute: (actions) ->
        console.log "Default Route"
        @.navigate "title", trigger: true

    handleKeyDown: (event) ->
        console.log "Keypress!"
        console.log event.which
        

        pageDn = 34
        right = 39
        space = 32
        pageUp = 33
        up = 38
        left = 37
        esc = 27

        switch event.which
            when pageDn, right, space then @.next()
            when pageUp, up, left then @.prev()
            when esc
                @.navigate "title", trigger: true
                break
            else return

    next: ->
        console.log 'next!'
        @.currentPage++

        if @.currentPage >= @.pages.length
            @.currentPage = 0

        console.log "Navigating to #{ @.pages[@.currentPage] }"
        @.navigate(@.pages[@.currentPage],  trigger: true)

    prev: ->
        console.log 'prev!'
        @.currentPage--

        if @.currentPage < 0
            @.currentPage = @.pages.length - 1

        console.log "Navigating to #{ @.pages[@.currentPage] }"
        @.navigate(@.pages[@.currentPage],  trigger: true)
