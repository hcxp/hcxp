Vue.component('bands-picker-input', Vue.extend({
  props: {
    beforeListLabel: String,
    createNewLabel: String,
    inputId: String,
    placeholder: String,
    modalTitle: String,
    modalNameLabel: String,
    modalLocationLabel: String,
    modalSaveLabel: String,
  },

  events: {
    'showNewBandModal': function() {
      this.newBand = { name: '', location: '' }
      this.$broadcast('show::modal', 'newBandModal')
    },
  },

  components: {
    'vs-modal':  vuestrapBase.modal
  },

  data () {
    return {
      isLoading: false,
      isLoadingFirst: true,
      isLoadingBands: false,
      isLoadingBandsFirst: true,
      bands: [],
      selectedBands: [],
      bandErrors: [],
      newBand: {
        name: '',
        location: ''
      }
    }
  },

  ready () {
    let bandIds = $(`#${this.inputId}`).val()

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
      $(`#${this.inputId}`).val(this.mappedBandIds)
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
    },
  },

  computed: {
    mappedBandIds () {
      return this.selectedBands.map((b) => { return b.id }).join(',')
    }
  },

  template: `
    <multiselect
      v-if="!isLoadingBandsFirst"
      @search-change="findBands"
      @update="updateBands"
      :options="bands"
      :loading="isLoadingBands"
      :local-search="false"
      label="search_label"
      key="id"
      :selected="selectedBands"
      :placeholder="placeholder"
      :multiple="true"
    >
      <span slot="beforeList">
        <div class="p-1 text-xs-center">
          <p class="text-muted" style="margin-bottom:0.5rem">
            {{ beforeListLabel }}
          </p>

          <a class="btn btn-success btn-sm" style="width: 150px" href="#" @click.prevent="$emit('showNewBandModal')">
            + {{ createNewLabel }}
          </a>
        </div>
      </span>
    </multiselect>

    <slot></slot>

    <vs-modal id="newBandModal" size="md" :fade="false">
      <div slot="modal-header">
        <h3>
          {{ modalTitle }}
        </h3>
      </div>

      <div slot="modal-body">
        <form>
          <div class="alert alert-danger" v-if="bandErrors.length > 0">
            <ul class="mb-0">
              <li v-for="error in bandErrors">
                {{ error }}
              </li>
            </ul>
          </div>

          <div class="form-group">
            <label>{{ modalNameLabel }}</label>
            <input class="form-control" type="text" v-model="newBand.name" required>
          </div>

          <div class="form-group">
            <label>{{ modalLocationLabel }}</label>
            <input class="form-control" type="text" v-model="newBand.location" required>
          </div>
        </form>
      </div>

      <div slot="modal-footer" @click.prevent="doSaveBand">
        <button class="btn btn-primary">{{ modalSaveLabel }}</button>
      </div>
    </div>
  `
}))