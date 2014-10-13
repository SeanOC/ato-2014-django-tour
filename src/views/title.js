var Backbone = require('backbone');
var $ = require('jquery');
var template = require('../templates/title.hbs')

require('jquery.zoomooz');


module.exports = Backbone.View.extend({
    id: 'title-slide',
    render: function() {
        console.log("Render title")
        this.$el.html(template({}));
        this.$('.django-logo').zoomTarget();
    }
});