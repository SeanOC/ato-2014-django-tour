var Backbone = require('backbone');
var $ = require('jquery');
var template = require('../templates/title.handlebars')

Backbone.$ = $;

module.exports = Backbone.View.extend({
    id: 'title-slide',
    className: 'top-level',

    render: function() {
        console.log("Render title")
        this.$el.html(template({}));
    }
});