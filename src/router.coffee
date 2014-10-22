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
    'shameless-plug': require './templates/shameless-plug.hbs'
    'thanks': require './templates/thanks.hbs'

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
    'segway-1': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-the-model-layer li:nth-child(5)',
            '#s-the-model-layer li:nth-child(6)',
            '#s-the-view-layer',
        ]
    'urls': new DocsView
        targetURL: 'django-docs/topics/http/urls.html'
        steps: [
            'body',
            '#s-example .highlight-python',
            '#s-specifying-defaults-for-view-arguments .highlight-python',
            '#s-reverse-resolution-of-urls .highlight-python:first',
            '#s-reverse-resolution-of-urls .highlight',
            '#s-including-other-urlconfs .highlight-python:first',
        ]
    'views': new DocsView
        targetURL: 'django-docs/topics/http/views.html',
        steps: [
            'body',
            '#s-a-simple-view .highlight-python',
            '#s-returning-errors .highlight-python:first',
            '#s-the-http404-exception .highlight-python',
        ]
    'view-shortcuts': new DocsView
        targetURL: 'django-docs/topics/http/shortcuts.html'
        steps: [
            'body',
            '#s-render-to-response .highlight-python'
        ]
    'cbv': new DocsView
        targetURL: 'django-docs/topics/class-based-views/index.html'
        steps: [
            'body',
            '#s-simple-usage-in-your-urlconf .highlight-python',
            '#s-subclassing-generic-views .highlight-python:first',
            '#s-subclassing-generic-views .highlight-python',
        ]
    'segway-2': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-the-view-layer li:nth-child(4)',
            '#s-the-view-layer li:nth-child(3)',
            '#s-the-view-layer li:nth-child(6)',
            '#s-the-template-layer',
        ]
    'templates': new DocsView
        targetURL: 'django-docs/topics/templates.html'
        steps: [
            'body',
            '#s-the-django-template-language .highlight:first',
        ]
    'segway-3': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-the-template-layer li:nth-child(1)',
            '#s-the-template-layer li:nth-child(2)',
            '#s-forms',
        ]
    'forms': new DocsView
        targetURL: 'django-docs/topics/forms/index.html'
        steps: [
            'body',
            '#s-the-form-class .highlight:first',
            '#s-the-form-class .highlight',
            '#s-the-view .highlight-python:first',
            '#s-the-template .highlight',
        ]
    'model-forms': new DocsView
        targetURL: 'django-docs/topics/forms/modelforms.html'
        steps: [
            'body',
            '#s-modelform .highlight:first',
        ]
    'segway-4': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-forms li:nth-child(1)',
            '#s-forms li:nth-child(2)',
            '#s-forms li:nth-child(3)',
            '#s-the-development-process',
            '#s-the-admin',
        ]
    'admin': new DocsView
        targetURL: 'django-docs/ref/contrib/admin/index.html'
        steps: [
            'body',
            '#s-modeladmin-options img:first',
            '#s-modeladmin-options img:nth(1)',
        ]
    'segway-5': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-the-admin',
            '#s-security',
            '#s-internationalization-and-localization',
            '#s-performance-and-optimization',
            '#s-python-compatibility',
            '#s-geographic-framework',
        ]
    'geo-django': new DocsView
        targetURL: 'django-docs/ref/contrib/gis/tutorial.html'
        steps: [
            'body',
            '#s-spatial-lookups .highlight:nth(2)',
        ]
    'segway-6': new DocsView 
        targetURL: 'django-docs/index.html'
        steps: [
            '#s-geographic-framework',
            '#s-common-web-application-tools',
            '#s-common-web-application-tools li:nth-child(1)',
            '#s-common-web-application-tools li:nth-child(2)',
            '#s-common-web-application-tools li:nth-child(3)',
            '#s-common-web-application-tools li:nth-child(4)',
            '#s-common-web-application-tools li:nth-child(5)',
            '#s-common-web-application-tools li:nth-child(6)',
            '#s-common-web-application-tools li:nth-child(7)',
            '#s-common-web-application-tools li:nth-child(8)',
            '#s-common-web-application-tools li:nth-child(9)',
            '#s-common-web-application-tools li:nth-child(10)',
            '#s-common-web-application-tools li:nth-child(11)',
            '#s-common-web-application-tools li:nth-child(12)',
            '#s-other-core-functionalities',
            '#s-the-django-open-source-project'
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
        'docs/segway-1/*',
        'docs/urls/*',
        'docs/views/*',
        'docs/view-shortcuts/*',
        'docs/cbv/*',
        'docs/segway-2/*',
        'docs/templates/*',
        'docs/segway-3/*',
        'docs/forms/*',
        'docs/model-forms/*',
        'docs/segway-4/*',
        'docs/admin/*',
        'docs/segway-5/*',
        'docs/geo-django/*',
        'docs/segway-6/*',
        'shameless-plug',
        'thanks',
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
