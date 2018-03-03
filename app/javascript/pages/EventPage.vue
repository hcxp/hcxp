<template lang="pug">
  .container
    b-loading(:active.sync="isLoadingCurrentEvent")

    template(v-if="!isLoadingCurrentEvent")
      .notification.is-primary(v-if="event.attributes.state == 'new'")
        p.title.is-5.mb-1
          | Just one second
        p
          | We're currently fetching event details from facebook.

      template(v-else)
        .columns
          .column.is-8

            .card.mb-4.event-page-heading
              .card-image
                img(:src="event.attributes.poster_large_url" width="100%")

              .card-content
                p.heading.has-text-grey-light
                  | {{ event.attributes.start_at | moment("from", "now") }}

                h1.title.is-4.mb-2
                  .content
                    | {{ event.attributes.name }}

                p.event-page-heading-location
                  map-pin-icon
                  <router-link :to="{ name: 'search', params: { query: event.attributes.place_name } }" class="has-text-grey">{{ event.attributes.place_name }}</router-link>, <router-link :to="{ name: 'search', params: { query: event.attributes.city } }" class="has-text-grey">{{ event.attributes.city }}, {{ event.attributes.country_code }}</router-link>

              .card-footer
                a.card-footer-item Save
                a.card-footer-item Share
                p.card-footer-item
                  span See on <a href="#">facebook</a>

            .card
              header.card-header
                p.card-header-title More details

              .card-content
                .content
                  p(v-html="event.attributes.description_html")

          .column
            .mb-4
              h4.heading Bands playing
              b-collapse.card(v-for="band in eventBands" :open="false")
                .card-header(slot="trigger" slot-scope="props" @click="handleBandClicked(band)")
                  p.page-event-band-title
                    | {{ band.attributes.name || 'Unknown' }}
                    span.has-text-grey {{ band.attributes.location }}

                .card-content.p-3
                  .content.is-small
                    p(v-if="band.attributes.description")
                      | {{ band.attributes.description }}
                    <iframe style="border: 0; width: 100%; height: 42px;" src="https://bandcamp.com/EmbeddedPlayer/album=211332339/size=small/bgcol=ffffff/linkcol=0687f5/transparent=true/" seamless></iframe>

            h4.heading Other events in town

</template>

<script>
import { mapGetters } from 'vuex'
import { MapPinIcon } from 'vue-feather-icons'

export default {
  components: {
    MapPinIcon
  },

  data () {
    return {
      bands: [
        { name: 'Regres', country_code: 'PL', active: true },
        { name: 'Eye for an Eye', country_code: 'PL', active: false },
        { name: 'Trapped Under Ice', country_code: 'US', active: false },
      ]
    }
  },

  watch: {
    '$route': 'updateCurrentEvent'
  },

  mounted () {
    this.updateCurrentEvent()
  },

  methods: {
    handleBandClicked (band) {
      band.active = !band.active
    },

    updateCurrentEvent () {
      this.$store.dispatch('pingViewEvent', this.$route.params.id)
      this.$store.dispatch('setCurrentEvent', this.$route.params.id)
      this.$store.dispatch('getEventBands', { eventId: this.$route.params.id })
    }
  },

  computed: {
    ...mapGetters([
      'event', 'isLoadingCurrentEvent', 'eventBands'
    ])
  }
}
</script>

<style lang="scss">
.event-page-heading {
  .card-content {
    padding: 1rem;
  }

  .heading {
    margin-bottom: 3px;
  }
}

.event-page-heading-location {
  font-size: 0.9rem;

  svg {
    width: .9rem;
    height: .9rem;
    margin-bottom: -2px;
    margin-right: 6px;
    stroke: #777;
  }
}

.page-event-band-title {
  font-weight: 600;
  padding: 0.75rem;

  span {
    font-size: 0.9rem;
    display: block;
    font-weight: 500;
  }
}
</style>
