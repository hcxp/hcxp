$(document).on('ready', function(){
  new Vue({
    el: '.events-search-form',

    data () {
      return {
        isLoading: false
      }
    },

    ready () {

    },

    methods: {
      onSubmit () {
        this.isLoading = true
      }
    }
  })
})