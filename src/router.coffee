Backbone = require 'backbone'
$ = require 'jquery'
_ = require 'lodash'



SimpleTemplateView = require './views/simpleTemplate.coffee'
DocsView = require './views/docs.coffee'

TEMPLATES = 
    'title': require './templates/title.hbs'
    'who': require './templates/who.hbs'
    'django': require './templates/django.hbs'
    'python': require './templates/python.hbs'
    'not-cms': require './templates/not-cms.hbs'
    'framework': require './templates/framework.hbs'
    'opinionated-framework': require './templates/opinionated-framework.hbs'

module.exports = Backbone.Router.extend
    routes:
        "docs": "docs",
        "docs/:step": "docs",
        "*action": "defaultRoute"

    pages: [
        'title',
        'who',
        'django',
        'python',
        'not-cms',
        'framework',
        'opinionated-framework',
        'docs/1',
        'docs/2',
        'docs/3',
        'docs/4',
        'docs/5',
        'docs/6',
        'docs/7',
        'docs/8',
        'docs/9',
        'docs/10',
        'docs/11',
        'docs/12',
        'docs/13',
        'docs/14',
        'docs/15',
        'docs/16',
        'docs/17',
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
            @.currentPage--
            return

        @.navigate(@.pages[@.currentPage],  trigger: true)

    prev: ->
        @.currentPage--

        if @.currentPage < 0
            @.currentPage++
            return

        @.navigate(@.pages[@.currentPage],  trigger: true)
