<template lang="pug">
  router-link.card(:to="{ name: 'event', params: { id: event.id } }")
    .image
      img(:src="event.attributes.poster_medium_url")
    .content
      a.header.text-truncate {{ event.attributes.name }}
      .meta
        | {{ event.attributes.start_at | moment("from", "now") }} · <router-link :to="{ name: 'search', params: { query: event.attributes.place_name } }">{{ event.attributes.place_name }}</router-link>, <router-link :to="{ name: 'search', params: { query: event.attributes.city } }">{{ event.attributes.city }}, {{ event.attributes.country_code }}</router-link>
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
