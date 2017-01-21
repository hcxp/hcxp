Vue.partial('customOptionPartial', `
  <p class="media-heading"><strong>{{ option.name_or_bands }}</strong></p>
  <ul class="list-inline mb-0">
    <li class="list-inline-item">{{ option.created_at | moment "from" }}</li>
    <li class="list-inline-item">•</li>
    <li class="list-inline-item">{{ option.venue.name }}, {{ option.venue.city }}</li>
  </ul>
`)

Vue.component('event-picker-input', Vue.extend({
  props: {
    inputId:     String,
    placeholder: String
  },

  data () {
    return {
      isLoading:      false,
      isLoadingFirst: true,
      event:          {},
      events:         []
    }
  },

  ready () {
    let eventId = $(`#${this.inputId}`).val()

    if (eventId) {
      let req = this.$http.get(`/events/${eventId}.json`)
      req.then((resp) => {
        this.events         = [resp.data]
        this.event          = resp.data
        this.isLoading      = false
        this.isLoadingFirst = false
      })
    } else {
      let req = this.$http.get('/events.json?s=all')
      req.then((resp) => {
        this.events         = resp.data
        this.isLoading      = false
        this.isLoadingFirst = false
      })
    }
  },

  methods: {
    findEvents (query) {
      if (query.length !== 0) {
        this.isLoading = true
        let req = this.$http.get('/events.json', { params: { s: 'all', q: query } })

        req.then((resp) => {
          this.events = resp.data
          this.isLoading = false
        })
      }
    },

    updateEvent (val) {
      this.event = val
      let eventId = $(`#${this.inputId}`).val(val == null ? '' : val.id)
    },
  },

  template: `
    <multiselect
      v-if="!isLoadingFirst"
      @search-change="findEvents"
      @update="updateEvent"
      :options="events"
      :loading="isLoading"
      :local-search="false"
      label="search_label"
      key="id"
      :selected="event"
      :placeholder="placeholder"
      option-partial="customOptionPartial"
    >
    </multiselect>

    <slot></slot>
  `
}))