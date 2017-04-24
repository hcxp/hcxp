Vue.component('vue-google-autocomplete', Vue.extend({
  name: 'VueGoogleAutocomplete',
  props: {
    id: {
      type: String,
      required: true
    },
    classname: String,
    placeholder: {
      type: String,
      default: 'Start typing'
    },
    types: {
      type: String,
      default: 'address'
    },
    country: {
      type: String,
      default: null
    },
    enableGeolocation: {
      type: Boolean,
      default: false
    }
  },

  data: function () {
    return {
      /**
       * The Autocomplete object.
       *
       * @type {Autocomplete}
       * @link https://developers.google.com/maps/documentation/javascript/reference#Autocomplete
       */
      autocomplete: null,
      value: ''
    }
  },

  watch: {
    value (val, oldVal) {
      this.$emit('valuechanged', val)
    }
  },

  ready: function() {
    this.value = ''

    const options = {
      types: [this.types]
    }

    if (this.country) {
      options.componentRestrictions = {
        country: this.country
      }
    }

    this.autocomplete = new google.maps.places.Autocomplete(
      document.getElementById(this.id),
      options
    )

    this.autocomplete.addListener('place_changed', () => {
          let place = this.autocomplete.getPlace();
          this.value = place.formatted_address

          let addressComponents = {
              street_number: 'short_name',
              route: 'long_name',
              locality: 'long_name',
              administrative_area_level_1: 'short_name',
              country: 'long_name',
              postal_code: 'short_name'
          };
          let returnData = {};
          if (place.address_components !== undefined) {
              // Get each component of the address from the place details
              for (let i = 0; i < place.address_components.length; i++) {
                let addressType = place.address_components[i].types[0];
                if (addressComponents[addressType]) {
                  let val = place.address_components[i][addressComponents[addressType]];
                      returnData[addressType] = val;
                }
              }
              returnData['latitude'] = place.geometry.location.lat();
              returnData['longitude'] = place.geometry.location.lng();
              // return returnData object and PlaceResult object
              this.$emit('placechanged', returnData, this.autocomplete.getPlace());
          }
     });
  },

  methods: {
      // Bias the autocomplete object to the user's geographical location,
      // as supplied by the browser's 'navigator.geolocation' object.
      geolocate() {
          if (this.enableGeolocation) {
              if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                  let geolocation = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                  };
                  let circle = new google.maps.Circle({
                    center: geolocation,
                    radius: position.coords.accuracy
                  });
                  this.autocomplete.setBounds(circle.getBounds());
                });
              }
          }
      },

      handleKeyupEnter () {
        return false
      }
  },

  template: `
    <input
        :class="classname"
        :id="id"
        :placeholder="placeholder"
        v-model="value"
        @focus = "geolocate()"
        @keydown.enter.prevent="handleKeyupEnter"
    />
  `
}))