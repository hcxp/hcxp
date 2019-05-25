<template lang="pug">
  .mb-5
    template(v-for="month in events")
      h2.ui.dividing.header.mb-4
        | {{ month.date | moment("MMMM YYYY") }}

      .ui.link.two.cards
        event-card(:event="event" v-for="event in month.events" :key="event.id")
</template>

<script>
import EventCard from './EventCard'

export default {
  props: {
    events: {
      type: Array,
      default: () => { return [] }
    }
  },

  components: {
    EventCard
  }
}
</script>
