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
  }
}
</script>

<style>
</style>
