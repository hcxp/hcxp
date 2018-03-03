<template lang="pug">
  .mb-5
    template(v-for="month in events")
      .events-list-month
        h2.title.is-5.mb-4
          | {{ month.date | moment("MMMM YYYY") }}

        .columns(v-for="row in chunkedEvents(month.events)")
          .column.is-6(v-for="event in row" :key="event.id")
            event-card(:event="event")
</template>

<script>
import _chunk from 'lodash/chunk'

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
  },

  methods: {
    chunkedEvents (events) {
      return _chunk(events, 2)
    }
  }
}
</script>

<style>
.events-list-month {
  margin-bottom: 3rem;
}
</style>
