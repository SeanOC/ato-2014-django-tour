var Backbone = require('backbone');
var $ = require('jquery');
var _ = require('lodash');



var TitleView = require('./views/title')
var DocsView = require('./views/docs.coffee')

module.exports = Backbone.Router.extend({
    routes: {
        "title": "title",
        "docs": "docs",
        "*actions": "defaultRoute" // Backbone will try match the route above first
    },

    pages: [
        'title',
        'docs',
    ],

    initialize: function(options) {
        this.appView = options.appView;
        $(document).keydown(_.bind(this.handleKeyDown, this));
        this.currentPage = 0;
    },

    title: function() {
        var titleView = new TitleView();
        titleView.render();
        this.appView.update(titleView.el);
        this.currentPage = this.pages.indexOf('title');
        console.log("title done");
    },

    docs: function() {
        var docsView = new DocsView();
        docsView.render();
        this.appView.update(docsView.el);
        this.currentPage = this.pages.indexOf('docs');
        console.log("docs done");
    },

    defaultRoute: function(actions) {
        console.log("Default Route")
        this.navigate("title", {trigger: true});
    },

    handleKeyDown: function(event) {
        console.log("Keypress!");
        console.log(event.which);
        switch(event.which) {
            case 34:  // pageDn
            case 39:  // right
            case 40:  // down
            case 32:  // space
                this.next();
                break;
            case 33:  // pageUp
            case 38:  // up
            case 37:  // left
                this.prev();
                break;
            case 27:  // esc
                this.navigate("title", {trigger: true});
                break;
            default:
                return;
        }
    },

    next: function() {
        console.log('next!');
        this.currentPage++;

        if (this.currentPage >= this.pages.length) {
            this.currentPage = 0;
        }
        console.log("Navigating to " + this.pages[this.currentPage]);
        this.navigate(this.pages[this.currentPage], {trigger: true});
    },

    prev: function() {
        console.log('prev!');
        this.currentPage--;

        if (this.currentPage < 0) {
            this.currentPage = this.pages.length - 1;
        }

        console.log("Navigating to " + this.pages[this.currentPage]);
        this.navigate(this.pages[this.currentPage], {trigger: true});
    }
});