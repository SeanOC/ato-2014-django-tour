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

DOCSVIEWS =
    'index': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            'body',
            '#s-first-steps',
            '#s-the-model-layer',
            '#s-the-view-layer',
            '#s-the-template-layer',
            '#s-forms',
            '#s-the-development-process',
            '#s-the-admin',
            '#s-security',
            '#s-internationalization-and-localization',
            '#s-performance-and-optimization',
            '#s-python-compatibility',
            '#s-geographic-framework',
            '#s-common-web-application-tools',
            '#s-other-core-functionalities',
            '#s-the-django-open-source-project',
            '#s-the-model-layer',
        ]
    'models': new DocsView
        targetURL: 'django-docs/topics/db/models.html'
        steps: [
            'body',
            '#s-quick-example .highlight-python',
        ]
    'queries': new DocsView
        targetURL: 'django-docs/topics/db/queries.html'
        steps: [
            'body',
            '#queryset-model-example',
            '#s-creating-objects .highlight-python',
            '#s-saving-changes-to-objects .highlight-python:first',
            '#s-saving-changes-to-objects .highlight-python',
            '#s-deleting-objects .highlight-python:first',
            '#s-retrieving-all-objects .highlight-python',
            '#s-retrieving-specific-objects-with-filters .highlight-python:first',
            '#s-chaining-filters .highlight-python:first',
        ]
    'raw-queries': new DocsView
        targetURL: 'django-docs/topics/db/sql.html'
        steps: [
            'body',
            '#s-performing-raw-sql-queries .admonition:first'
            '#s-performing-raw-queries .highlight-python:first',
        ]
    'db-migrations': new DocsView
        targetURL: 'django-docs/topics/migrations.html'
        steps: [
            'body',
            '#s-workflow .highlight-python:first',
            '#s-workflow .highlight-python',
            '#s-migration-files .highlight-python',
        ]
    'models-bonus': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-the-model-layer li:nth-child(5)',
            '#s-the-model-layer li:nth-child(6)',
        ]

module.exports = Backbone.Router.extend
    routes:
        "docs/:viewName/:step": "docs",
        "*action": "defaultRoute"

    pages: [
        'title',
        'who',
        'django',
        'python',
        'not-cms',
        'framework',
        'opinionated-framework',
        'docs/index/*',
        'docs/models/*',
        'docs/queries/*',
        'docs/raw-queries/*',
        'docs/db-migrations/*',
        'docs/models-bonus/*',
    ]

    initialize: (options) ->
        @.appView = options.appView
        $(document).keydown _.bind(@.handleKeyDown, @)
        @.currentPage = 0

        @.templateViews = {}
        for templateName, template of TEMPLATES
            @.templateViews[templateName] = new SimpleTemplateView id: "#{ templateName }-slide", template: template

        newPages = []
        for page in @.pages
            match = page.match(/docs\/([\-\w]+)\/*/)
            if match != null
                view = match[1]
                stepNumber = 0
                for step in DOCSVIEWS[view].steps
                    stepNumber++
                    newPages.push "docs/#{ view }/#{ stepNumber }"
            else
                newPages.push page

        @.pages = newPages
        console.log @.pages


    docs: (viewName, step) ->
        view = DOCSVIEWS[viewName]

        if step != null
            @.appView.update view
            view.goTo(step - 1)
            @.currentPage = @.pages.indexOf "docs/#{ viewName }/#{ step }"
        else
            @.navigate "docs/#{ viewName }/1", trigger: true

    defaultRoute: (action) ->

        if action of TEMPLATES
            @.appView.update @.templateViews[action]

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
