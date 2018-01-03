<template lang="pug">
  .main.ui.container
    .ui.loader.active(v-if="isLoadingCurrentEvent")
    .ui.grid(v-else)
      .column.ten.wide
        p
          img.rounded.image.ui(src="https://beta.hcxp.co/media/W1siZiIsIjIwMTcvMTIvMzEvNzkzODdnczltal8yNjExMzg2Nl8xMDE1NjEyNzEwODk5ODQ0N18zNzM3ODAzMTUzMTU5MTQ5OTE1X24uanBnIl0sWyJwIiwidGh1bWIiLCI4MjV4MzAwIyJdXQ?sha=21461ccfb02143fe" width="100%")

        .ui.sub.header.text-muted
          | {{ event.attributes.start_at | moment("from", "now") }}
        h1.ui.header.large.mt-0
          .content
            | {{ event.attributes.name }}
            .sub.header {{ event.attributes.city }}, {{ event.attributes.country_code }}

        h3.ui.header More details

        article
          p Kolejny koncert hard core w klubie Mózg. Schizma jak co roku w doborowym towarzystwie. Tym razem zaprosiliśmy Seek Nothing z Berlina oraz The Dog z Wrocławia. Tak jak w poprzednich latach są to bandy starannie wyselekcjonowane, które mają coś do zagrania i wykrzyczenia, więc rzecz jasna nalegamy na punktualne przybycie i sprawdzenie wszystkich kapel bo tu nikt z łapanki nie gra. Zwyczajowo prosimy o wszelką pomoc w promocji gigu.
          p Jako że albumowi Unity2000 stuknie w tym roku XXlat, postanowiliśmy zagrać go w całości na tym koncercie. Zapraszamy wszystkich, którzy mają ochotę na nostalgiczną wycieczkę w koniec lat dziewięćdziesiątych kiedy z załogą U2KC robiliśmy szum... Odpaliliśmy również nasz bandcamp - możecie sobie tam przypomnieć ten album coby przygotować singalongi!!! Mamy nadzieje zobaczyć parę starych mord, niekoniecznie z Bydgoszczy - zapraszamy!!!

      .column.six.wide
        h4 Bands playing

        .ui.styled.accordion
          div(v-for="band in bands")
            .title(:class="{ active: band.active }" @click="handleBandClicked(band)")
              i.dropdown.icon
              | {{ band.name }}
              sub  {{ band.country_code }}

            .content(:class="{ active: band.active }")
              p A dog is a type of domesticated animal. Known for its loyalty and faithfulness, it can be found as a welcome guest in many households across the world.

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
    }
  },

  computed: {
    ...mapGetters([
      'event', 'isLoadingCurrentEvent'
    ])
  }
}
</script>
