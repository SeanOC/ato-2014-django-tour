var Backbone = require('backbone');
var $ = require('jquery');
var _ = require('lodash');

Backbone.$ = $;


var TitleView = require('./views/title')

module.exports = Backbone.Router.extend({
    routes: {
        "title": "title",
        "*actions": "defaultRoute" // Backbone will try match the route above first
    },

    initialize: function(options) {
        this.appView = options.appView;
        $(document).keydown(_.bind(this.handleKeyDown, this))
    },

    title: function() {
        var titleView = new TitleView();
        titleView.render();
        this.appView.update(titleView.el);
        console.log("title done");
    },

    defaultRoute: function(actions) {
        this.navigate("title");
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
                this.navigate("title");
                break;
            default:
                return;
        }
    },

    next: function() {
        console.log('next!');
    },

    prev: function() {
        console.log('prev!');
    }
});