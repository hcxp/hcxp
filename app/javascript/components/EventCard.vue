<template lang="pug">
  router-link.card(:to="{ name: 'event', params: { id: event.id } }")
    .image
      img(src="https://beta.hcxp.co/media/W1siZiIsIjIwMTcvMTIvMzAvaWxicXFwZGhpXzI2MTEzODY2XzEwMTU2MTI3MTA4OTk4NDQ3XzM3Mzc4MDMxNTMxNTkxNDk5MTVfbi5qcGciXSxbInAiLCJ0aHVtYiIsIjgyNXgzMDAjIl1d?sha=f7593a12ba545279")
    .content
      a.header {{ event.attributes.name }}
      .meta
        | {{ event.attributes.start_at | moment("from", "now") }} · <router-link :to="{ name: 'search', params: { query: event.attributes.city } }">{{ event.attributes.city }}, {{ event.attributes.country_code }}</router-link>
</template>

<script>
export default {
  props: {
    event: {
      type: Object,
      default: () => { return {} }
    }
  }
}
</script>
