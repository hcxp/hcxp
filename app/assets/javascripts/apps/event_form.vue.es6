$(document).on('turbolinks:load', function() {
  new Vue({
    el: '.event-form',

    components: {
      multiselect: VueMultiselect.Multiselect,
      'vs-modal':  vuestrapBase.modal
    },

    data: {
      venues: [],
      bands: [],
      venue: {},
      selectedBands: [],
      isLoading: false,
      isLoadingBands: false,
      isLoadingFirst: true,
      isLoadingBandsFirst: true,
      errors: [],
      bandErrors: [],
      newVenue: {
        name: '',
        address: ''
      },
      newBand: {
        name: '',
        location: ''
      }
    },

    events: {
      'showNewBandModal': function() {
        this.newBand = { name: '', location: '' }
        this.$broadcast('show::modal', 'newBandModal')
      },

      'showNewVenueModal': function() {
        this.newVenue = { name: '', address: '' }
        this.$broadcast('show::modal', 'newVenueModal')
      },
    },

    ready () {
      let venueId = $('#event_venue_id').val()
      let bandIds = $('#event_band_ids').val()

      if (venueId) {
        let req = this.$http.get(`/venues/${venueId}.json`)
        req.then((resp) => {
          this.venues         = [resp.data]
          this.venue          = resp.data
          this.isLoading      = false
          this.isLoadingFirst = false
        })
      } else {
        let req = this.$http.get('/venues.json')
        req.then((resp) => {
          this.venues         = resp.data
          this.isLoading      = false
          this.isLoadingFirst = false
        })
      }

      if (bandIds) {
        bandIds = bandIds.split(',')
        let req = this.$http.get('/bands.json', { params: { id_in: bandIds } })
        req.then((resp) => {
          this.bands               = resp.data
          this.selectedBands       = resp.data
          this.isLoadingBands      = false
          this.isLoadingBandsFirst = false
        })
      } else {
        let req = this.$http.get('/bands.json')
        req.then((resp) => {
          this.bands               = resp.data
          this.isLoadingBands      = false
          this.isLoadingBandsFirst = false
        })
      }
    },

    methods: {
      findVenues (query) {
        if (query.length === 0) {
          this.venues = []
        } else {
          this.isLoading = true
          let req = this.$http.get('/venues.json', { params: { q: query } })

          req.then((resp) => {
            this.venues = resp.data
            this.isLoading = false
          })
        }
      },

      updateVenue (val) {
        this.venue = val
      },

      findBands (query) {
        if (query.length === 0) {
          this.bands = []
        } else {
          this.isLoadingBands = true
          let req = this.$http.get('/bands.json', { params: { q: query } })

          req.then((resp) => {
            this.bands = resp.data
            this.isLoadingBands = false
          })
        }
      },

      updateBands (val) {
        this.selectedBands = val
      },

      doSaveVenue () {
        let req = this.$http.post('/venues.json', this.newVenue)
        req.then((resp) => {
          this.venue = resp.data
          this.venues.push(resp.data)
          this.$broadcast('hide::modal', 'newVenueModal')
        })

        req.catch((resp) => {
          this.errors = resp.data.full_error_messages
        })
      },

      doSaveBand () {
        let req = this.$http.post('/bands.json', this.newBand)
        req.then((resp) => {
          this.selectedBands.push(resp.data)
          this.bands.push(resp.data)
          this.$broadcast('hide::modal', 'newBandModal')
        })

        req.catch((resp) => {
          this.bandErrors = resp.data.full_error_messages
        })
      }
    },

    computed: {
      mappedBandIds () {
        return this.selectedBands.map((b) => { return b.id }).join(',')
      }
    }
  })
})