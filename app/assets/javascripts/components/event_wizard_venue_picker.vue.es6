Vue.component('event-wizard-venue-picker', Vue.extend({
  props: {
    inputName: String,
    inputValue: {
      type: String,
      value: ''
    }
  },

  data () {
    return {
      venue: {},
      venues: [],
      query: '',
      isSaving: false,
      isLoadingVenue: false,
      isLoadingVenues: false,
      newVenueFormVisible: false,
      newVenue: { name: '', address: '' },
      errors: []
    }
  },

  watch: {
    query (val, oldVal) {
      this.fetchVenues()
    },

    inputValue (val, oldVal) {
      this.fetchVenue()
    }
  },

  ready () {
    this.fetchVenue()
    this.fetchVenues()
  },

  methods: {
    fetchVenues () {
      this.isLoadingVenues = true

      let req = this.$http.get('/venues.json', {
        params: { limit: 4, q: this.query }
      })

      req.then((resp) => {
        this.venues          = resp.data
        this.isLoadingVenues = false
      })
    },

    fetchVenue () {
      if (this.inputValue === '') return false
      this.isLoadingVenue = true

      let req = this.$http.get(`/venues/${this.inputValue}.json`)

      req.then((resp) => {
        this.venue          = resp.data
        this.isLoadingVenue = false
      })
    },

    handleQueryChange () {
      this.fetchVenues()
    },

    handleVenueClicked (venue) {
      this.inputValue = venue.id
    },

    showNewVenueForm () {
      this.newVenue = { name: '', address: '' }
      this.errors = []
      this.newVenueFormVisible = true
    },

    doSaveVenue () {
      if (this.isSaving) return false
      this.isSaving = true

      let req = this.$http.post('/venues.json', this.newVenue)
      req.then((resp) => {
        this.venues.push(resp.data)
        this.inputValue = resp.data.id
        this.newVenueFormVisible = false
        this.isSaving = false
      })

      req.catch((resp) => {
        this.errors = resp.data.full_error_messages
        this.isSaving = false
      })
    },

    handleValueChanged (value) {
      this.newVenue.address = value
    }
  },

  computed: {
    isPickedVenueVisible () {
      return this.inputValue !== ''
    },

    eventsSearchVisible () {
      return !this.newVenueFormVisible && this.inputValue === ''
    }
  },

  template: '#event-wizard-venue-picker-tpl'
}))