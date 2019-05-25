<template lang="pug">
  div
    .search-heading
      .main.ui.container
        h1 Search results for: <em>{{ $route.params.query }}</em>

        .ui.hidden.divider
        .ui.three.item.stackable.tabs.menu
          router-link.item(:to="{ name: 'search' }" exact) Upcoming
          router-link.item(:to="{ name: 'searchPast' }") Past
          router-link.item(:to="{ name: 'searchSaved' }") Saved

    .main.ui.container
      router-view
</template>

<script>
export default {
}
</script>

<style>
.search-heading {
  text-align: center;
  background: #f9f9f9;
  padding: 2em 0;
  margin-bottom: 2em;
  margin-top: -1.5em;
  box-shadow: 0 1px 3px 0 #d4d4d5;
}
</style>
