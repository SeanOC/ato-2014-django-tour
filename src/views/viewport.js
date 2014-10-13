var Backbone = require('backbone');
var $ = require('jquery');

Backbone.$ = $;

module.exports = Backbone.View.extend({
    id: 'viewport',

    update: function(content) {
        console.log('Updating!!!')
        var $children = this.$el.children();
        console.log($children);
        if ($children.length > 0) {
            this.$el.empty();
        }
        this.$el.html(content);
    }
});