var Backbone = require('backbone');
var $ = require('jquery');
var template = require('../templates/docs.handlebars')

Backbone.$ = $;

module.exports = Backbone.View.extend({
    id: 'docs-slide',

    render: function() {
        console.log("Render docs")
        this.$el.html(template({}));
    }
});