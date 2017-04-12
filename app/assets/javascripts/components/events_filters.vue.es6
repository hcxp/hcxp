$(document).on('turbolinks:load', function() {
  new Vue({
    el: '.events-filters',

    watch: {
      // query: function(val, oldVal) {
      //   if (oldVal === '') return true
      //   this.submitForm()
      // },

      // scope: function(val, oldVal) {
      //   if (oldVal === '') return true
      //   this.submitForm()
      // }
    },

    data () {
      return {
        query: '',
        scope: ''
      }
    },

    ready () {
    },

    methods: {
      scopeBtnClass (scope) {
        return (scope == this.scope) ? 'btn btn-primary' : 'btn btn-secondary'
      },

      searchPath (scope) {
        let url = `${this.$el.getAttribute('action')}?q=${this.query}&s=${scope}`
        return url
      }
    },

    computed: {
    },
  })
})