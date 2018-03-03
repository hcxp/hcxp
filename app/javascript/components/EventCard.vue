<template lang="pug">
  .card.event-card
    .card-image
      .card-image-bottom-right(v-if="event.attributes.band_names.length > 0")
        b-tooltip(:label="event.attributes.band_names.join(', ')" :animated="true" position="is-left" multilined)
          .tag.is-small.is-rounded.event-card-bands-count
            music-icon
            | {{ event.attributes.band_names.length }}

      router-link.card-image(:to="{ name: 'event', params: { id: event.id } }")
        img(:src="event.attributes.poster_medium_url")

    .card-content.p-3
      p
        a.title.is-5.text-truncate {{ event.attributes.name }}

      p.event-card-meta.has-text-grey-light.text-truncate
        | {{ event.attributes.start_at | moment("from", "now") }} · <router-link :to="{ name: 'search', params: { query: event.attributes.place_name } }" class="has-text-grey">{{ event.attributes.place_name }}</router-link>, <router-link :to="{ name: 'search', params: { query: event.attributes.city } }" class="has-text-grey">{{ event.attributes.city }}, {{ event.attributes.country_code }}</router-link>
</template>

<script>
import { MusicIcon } from 'vue-feather-icons'

export default {
  props: {
    event: {
      type: Object,
      default: () => { return {} }
    }
  },

  components: {
    MusicIcon
  }
}
</script>

<style lang="scss">
.event-card {
  border-radius: 3px;
  overflow: hidden;
  transition: .2s;

  &:hover {
    transform: translateY(-3px);
    transition: .2s;
  }
}

.event-card-meta {
  font-size: 0.9rem;
  display: block;
  margin-top: -0.2rem;
}

.card-image-bottom-right {
  bottom: 1rem;
  right: 0.5rem;
  position: absolute;
  z-index: 1;
}

.event-card-bands-count {
  opacity: 0.8;
}

.event-card-bands-count svg {
  height: 0.7rem;
  width: .7rem;
  margin-right: 0.4rem;
}
</style>
