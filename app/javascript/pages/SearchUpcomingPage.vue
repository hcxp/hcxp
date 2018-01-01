<template lang="pug">
  div
    .ui.loader.active(v-if="isLoadingAllEvents")
    events-list(:events="sortedEvents" v-else)
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
      this.$store.dispatch('getAllEvents', {
        q: this.$route.params.query
      })
    }
  },

  computed: {
    ...mapGetters([
      'events', 'isLoadingAllEvents'
    ]),

    sortedEvents () {
      return this.events.sort((a, b) => {
        return new Date(a.attributes.start_at) - new Date(b.attributes.start_at)
      })
    }
  }
}
</script>

<style>
.search-heading {
  text-align: center;
  background: #f9f9f9;
  padding: 2em 0;
  margin-bottom: 2em;
  margin-top: -1.5em;
}
</style>
