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
  },

  notifications: {
    signedOutMsg: {
      type: VueNotifications.types.success,
      title: 'Signed out',
      message: 'You have been successfully signed out!'
    }
  }
}
</script>

<style>
</style>
