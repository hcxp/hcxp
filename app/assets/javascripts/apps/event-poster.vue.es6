$(document).on('turbolinks:load', function() {
  new Vue({
    el: '.event-poster',
    ready () {
      new Luminous(this.$el)
    },
  })
})