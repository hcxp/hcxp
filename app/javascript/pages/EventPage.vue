<template lang="pug">
  .main.ui.container
    .ui.loader.active(v-if="isLoadingCurrentEvent")
    template(v-else)
      .ui.warning.icon.message.mb-4(v-if="event.attributes.state == 'new'")
        i.notched.circle.loading.icon
        .content
          .header
            | Just one second
          p We're fetching event details from facebook.

      template(v-else)
        .ui.grid
          .column.ten.wide
            .ui.card.card-full-width
              .image
                img(:src="event.attributes.poster_large_url" width="100%")

              .content
                .ui.sub.header.text-muted
                  | {{ event.attributes.start_at | moment("from", "now") }}
                h1.ui.header.large.mt-0
                  .content
                    | {{ event.attributes.name }}
                    .sub.header {{ event.attributes.city }}, {{ event.attributes.country_code }}

            .ui.card.card-full-width
              .content
                .header More details

              .content
                //- h3.ui.dividing.header More details

                article
                  p(v-html="event.attributes.description_html")

          .column.six.wide
            h4 Bands playing

            .ui.styled.accordion
              div(v-for="band in eventBands")
                .title(@click="handleBandClicked(band)")
                  i.dropdown.icon
                  | {{ band.attributes.name }}
                  sub  {{ band.attributes.country_code }}

                .content
                  p A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be found as a welcome guest in many households across the world.
                  <iframe style="border: 0; width: 100%; height: 42px;" src="https://bandcamp.com/EmbeddedPlayer/album=211332339/size=small/bgcol=ffffff/linkcol=0687f5/transparent=true/" seamless></iframe>

</template>

<script>
import { mapGetters } from 'vuex'

export default {
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

<style>
.ui.segment-poster {
  padding: 0;
  overflow: hidden;
}

.ui.segment-poster img {
  display: block;
}
</style>
