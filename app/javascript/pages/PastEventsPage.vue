<template lang="pug">
  .main.ui.container
    b-loading(:active.sync="isLoadingAllEvents")
    events-list(:events="sortedEvents" v-if="!isLoadingAllEvents")
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
    ]),

    sortedEvents () {
      return this.events.sort((a, b) => {
        return new Date(a.date) - new Date(b.date)
      })
    }
  }
}
</script>
