Vue.component('band-play-btn', Vue.extend({
  props: {
    bandId: Number,
    class: String,
    label: {
      type: String,
      default: 'Listen'
    },
    loadingLabel: {
      type: String,
      default: 'Loading...'
    },
    errorMessage: {
      type: String,
      default: 'Something went wrong. Please try again later.'
    }
  },

  data () {
    return {
      isLoading: false,
      code: null
    }
  },

  ready () {
  },

  methods: {
    handleClick () {
      this.isLoading = true
      let req = this.$http.get(`/bands/${this.bandId}/player_code`)

      req.then((resp, b, c) => {
        this.code = resp.data.code
        this.isLoading = false
      })

      req.catch((resp) => {
        console.warn('Something went wrong', resp)
        alert(this.errorMessage)
        this.isLoading = false
      })
    }
  },

  computed: {
    iconClass () {
      return (this.isLoading) ? 'fa-circle-o-notch fa-spin' : 'fa-play'
    },

    btnLabel () {
      return (this.isLoading) ? this.loadingLabel : this.label
    },
  },

  template: `
    <template v-if="code === null">
      <a @click.prevent="handleClick" :class="class">
        <i class="fa fa-fw {{ iconClass }}"></i> {{ btnLabel }}
      </a>
    </template>

    <template v-else>
      {{{ code }}}
    </template>
  `
}))