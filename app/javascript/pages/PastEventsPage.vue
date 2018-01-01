<template lang="pug">
  .main.ui.container
    .ui.loader.active(v-if="isLoadingAllEvents")
    events-list(:events="events" v-else)
</template>

<script>
import { mapGetters } from 'vuex'
import EventsList from '../components/EventsList.vue'

export default {
  components: {
    EventsList
  },

  watch: {
    '$route': 'fetchData'
  },

  data () {
    return {
    }
  },

  created () {
    this.fetchData()
  },

  methods: {
    fetchData () {
      this.$store.dispatch('getAllEvents', { s: 'past' })
    }
  },

  computed: {
    ...mapGetters([
      'events', 'isLoadingAllEvents'
    ])
  }
}
</script>
