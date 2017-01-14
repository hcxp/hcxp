Vue.component('textarea-mde', Vue.extend({
  props: {
    uniqueId: String,
    value: String
  },

  data () {
  },

  ready () {
    this.simplemde = new SimpleMDE({
      element: this.$el,
      spellChecker: false,
      autosave: {
        enabled: true, uniqueId: this.uniqueId
      }
    })
  },

  template: `
    <textarea>{{ value }}</textarea>
  `
}))