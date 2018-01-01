<template lang="pug">
  .mb-5
    h2.ui.dividing.header.mb-4
      | Styczeń 2017

    .ui.link.two.cards
      event-card(:event="event" v-for="event in events")
</template>

<script>
import EventCard from './EventCard'

export default {
  props: {
    events: {
      type: Array,
      default: () => { [] }
    }
  },

  components: {
    EventCard
  }
}
</script>
