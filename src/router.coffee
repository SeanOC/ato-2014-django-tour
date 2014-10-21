Backbone = require 'backbone'
$ = require 'jquery'
_ = require 'lodash'



SimpleTemplateView = require './views/simpleTemplate.coffee'
DocsView = require './views/docs.coffee'

TEMPLATES = 
    title: require './templates/title.hbs'
    who: require './templates/who.hbs'
    django: require './templates/django.hbs'

module.exports = Backbone.Router.extend
    routes:
        "docs": "docs",
        "docs/:step": "docs",
        "*action": "defaultRoute"

    pages: [
        'title',
        'who',
        'django',
        'docs/1',
        'docs/2',
        'docs/3',
        'docs/4',
        'docs/5',
        'docs/6',
    ]

    initialize: (options) ->
        @.appView = options.appView
        $(document).keydown _.bind(@.handleKeyDown, @)
        @.currentPage = 0

        @.views = {}
        for templateName, template of TEMPLATES
            @.views[templateName] = new SimpleTemplateView id: "#{ templateName }-slide", template: template

        @.docsView = new DocsView targetURL: 'django-docs/index.html'

    docs: (step) ->
        if step != null
            @.appView.update @.docsView
            @.docsView.goTo(step - 1)
            @.currentPage = @.pages.indexOf "docs/#{ step }"
        else
            @.navigate "docs/1", trigger: true

    defaultRoute: (action) ->

        if action of TEMPLATES
            @.appView.update @.views[action]

            @.currentPage = @pages.indexOf action
        else
            @.navigate "title", trigger: true

    handleKeyDown: (event) ->
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
        @.currentPage++

        if @.currentPage >= @.pages.length
            @.currentPage = 0

        @.navigate(@.pages[@.currentPage],  trigger: true)

    prev: ->
        @.currentPage--

        if @.currentPage < 0
            @.currentPage = @.pages.length - 1

        @.navigate(@.pages[@.currentPage],  trigger: true)
