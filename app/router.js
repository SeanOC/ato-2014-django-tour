var Backbone = require('backbone');
var $ = require('jquery');

Backbone.$ = $;


var TitleView = require('./views/title')

module.exports = Backbone.Router.extend({
    routes: {
        "title": "title",
        "*actions": "defaultRoute" // Backbone will try match the route above first
    },

    initialize: function(options) {
        this.appView = options.appView;
    },

    title: function() {
        var titleView = new TitleView();
        titleView.render();
        this.appView.update(titleView.el);
        console.log("title done");
    },

    defaultRoute: function(actions) {
        this.navigate("title");
    }
});