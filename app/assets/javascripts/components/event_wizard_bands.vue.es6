Vue.component('event-wizard-bands', Vue.extend({
  props: {
    eventId: Number
  },

  components: {
    'vs-modal': vuestrapBase.modal
  },

  data () {
    return {
      bandables: [],
      bands: [],
      bandIds: [],
      query: '',
      isSaving: false,
      isLoadingBands: false,
      isLoadingBandables: true,
      newBandFormVisible: false,
      newBand: { name: '', location: '' },
      errors: []
    }
  },

  watch: {
    query (val, oldVal) {
      this.fetchBands()
    },

    // bandables (val, oldVal) {
    //   console.log(val)
    //   this.bandIds = val.map((b) => { return b.band_id })
    // }
  },

  events: {
    'showNewBandModal': function() {
      this.$emit('hideBandsSearchModal')
      this.newBand = { name: this.query, location: '' }
      this.errors  = []
      this.$broadcast('show::modal', 'newBandModal')
      this.$els.newbandname.focus()
    },

    'showBandsSearchModal': function() {
      this.fetchBands()
      this.$broadcast('show::modal', 'searchBandsModal')
      this.$els.queryinput.focus()
    },

    'hideBandsSearchModal': function () {
      this.$broadcast('hide::modal', 'searchBandsModal')
    }
  },

  ready () {
    this.fetchBandables()
  },

  methods: {
    fetchBandables () {
      this.isLoadingBandables = true
      let req = this.$http.get(`/api/v1/events/${this.eventId}/bandables`)

      req.then((resp) => {
        let bandables = resp.data

        bandables.forEach((b) => {
          b._destroy = false
        })

        this.bandables = bandables
        this.isLoadingBandables = false
      })
    },

    fetchBands () {
      this.isLoadingBands = true

      let req = this.$http.get(`/bands.json`, {
        params: { q: this.query, limit: 5 }
      })

      req.then((resp) => {
        this.bands       = resp.data
        this.isLoadingBands = false
      })
    },

    doRemoveBandable (bandable) {
      bandable._destroy = true
    },

    doAddBand (band) {
      this.bandables.push({
        band_id: band.id,
        band: band,
        _destroy: false
      })
    },

    doRemoveBand (band) {
      let bandable = this.bandables.find((b) => { return b.band_id === band.id })
      this.bandables.$remove(bandable)
    },

    isBandAssigned (band) {
      let existing = this.bandables.findIndex((b) => {
        return b.band_id === band.id
      })

      return existing !== -1
    },

    handleLocationValueChanged (value) {
      this.newBand.location = value
    },

    doCancelNewBand () {
      this.$broadcast('hide::modal', 'newBandModal')
      this.$emit('showBandsSearchModal')
    },

    doSaveBand () {
      if (this.isSaving) return false

      this.isSaving = true
      let req = this.$http.post('/api/v1/bands', this.newBand)

      req.then((resp) => {
        this.isSaving = false
        this.bands.push(resp.data)
        this.doAddBand(resp.data)
        this.doCancelNewBand()
        this.query = resp.data.name
      })

      req.catch((resp) => {
        this.isSaving = false
        this.errors = resp.data.full_error_messages
      })
    }
  },

  computed: {
    bandIds () {
      return this.bandables.map((b) => { return b.band_id })
    },

    hasNoBandsAssigned () {
      return this.bandables.filter((b) => {
        return b._destroy !== true
      }).length === 0
    }
  },

  template: '#event-wizard-bands-tpl'
}))