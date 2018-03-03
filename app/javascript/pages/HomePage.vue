<template lang="pug">
  .container
    b-loading(:active.sync="isLoadingAllEvents")

    //- .heading.mb-3 Popular bands
    //- div.mb-4.tags
    //-   a.button.is-rounded.mr-2.mb-2 Regres
    //-   a.button.is-rounded.mr-2.mb-2 Vicious X Reality
    //-   a.button.is-rounded.mr-2.mb-2 Good Lookin Out
    //-   a.button.is-rounded.mr-2.mb-2 Eye for an Eye

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
      this.$store.dispatch('getAllEvents', {})
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
