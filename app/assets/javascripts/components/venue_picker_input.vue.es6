
  Vue.component('venue-picker-input', Vue.extend({
    props: {
      beforeListLabel: String,
      createNewLabel: String,
      inputId: String,
      placeholder: String
    },

    data () {
      return {
        isLoading: false,
        isLoadingFirst: true,
        venue: {},
        venues: []
      }
    },

    ready () {
      let venueId = $(`#${this.inputId}`).val()

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
    },

    template: `
      <multiselect
        v-if="!isLoadingFirst"
        @search-change="findVenues"
        @update="updateVenue"
        :options="venues"
        :loading="isLoading"
        :local-search="false"
        label="search_label"
        key="id"
        :selected="venue"
        :placeholder="placeholder"
      >
        <span slot="beforeList">
          <div class="p-1 text-xs-center">
            <p class="text-muted" style="margin-bottom:0.5rem">
              {{ beforeListLabel }}
            </p>

            <a class="btn btn-success btn-sm" style="width: 150px" href="#" @click.prevent="$emit('showNewVenueModal')">
              + {{ createNewLabel }}
            </a>
          </div>
        </span>
      </multiselect>

      <slot></slot>
    `
  }))