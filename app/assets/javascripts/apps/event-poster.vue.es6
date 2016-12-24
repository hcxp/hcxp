$(document).on('turbolinks:load', function() {
  console.log('load')
  new Vue({
    el: '.event-poster',
    ready () {
      new Luminous(this.$el)
    },
  })
})