var Backbone = require('backbone');
var $ = require('jquery');

Backbone.$ = $;

module.exports = Backbone.View.extend({
    id: 'viewport',

    update: function(content) {
        var $children = this.$el.children();
        console.log($children);
        if ($children.length > 0) {
            $children.replace(content);
        } else {
            this.$el.html(content);
        }
    }
});