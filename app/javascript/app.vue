<template lang="pug">
  #app
    main-header
    router-view
</template>

<script>
import MainHeader from 'components/Header.vue'

export default {
  components: {
    MainHeader
  },

  mounted () {
    this.$bus.$on('notification::show', (props) => {
      if (props.type === 'signedOut') {
        this.$toast.open({
          message: 'You have been successfully signed out!',
          type: 'is-success',
          position: 'is-bottom-right'
        })
      }
    })

    this.$store.subscribe((mutation, state) => {
      if (mutation.type === 'EVENT_CREATED') {
        this.handleEventCreatedMutation(mutation.payload.event)
      }
    })

    this.$cable.subscriptions.create('EventsChannel', {
      received: (resp) => {
        this.$store.dispatch('updateExistingEvent', resp.data)
      }
    })
  },

  methods: {
    handleEventCreatedMutation (event) {
      this.$store.dispatch('setCurrentEvent', event.id)
      this.$toast.open({
        message: 'Event successfully created!',
        type: 'is-success',
        position: 'is-bottom-right'
      })
      this.$router.push({ name: 'event', params: { id: event.id } })
    }
  }
}
</script>

<style>
</style>
