<template lang="pug">
  #app
    main-header
    router-view
</template>

<script>
import VueNotifications from 'vue-notifications'
import MainHeader from 'components/Header.vue'

export default {
  components: {
    MainHeader
  },

  mounted () {
    this.$bus.$on('notification::show', (props) => {
      if (props.type === 'signedOut') { this.signedOutMsg() }
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

  notifications: {
    signedOutMsg: {
      type: VueNotifications.types.success,
      title: 'Signed out',
      message: 'You have been successfully signed out!'
    },

    eventCreatedMsg: {
      type: VueNotifications.types.success,
      title: '',
      message: 'Event successfully created!'
    }
  },

  methods: {
    handleEventCreatedMutation (event) {
      this.$store.dispatch('setCurrentEvent', event.id)
      this.eventCreatedMsg()
      this.$router.push({ name: 'event', params: { id: event.id } })
    }
  }
}
</script>

<style>
</style>
