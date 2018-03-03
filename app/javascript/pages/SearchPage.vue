<template lang="pug">
  div
    .search-heading
      .main.ui.container
        h1.title.mb-5 Search results for: <em>{{ $route.params.query }}</em>

        div.tabs.is-toggle.is-fullwidth
          ul
            router-link(:to="{ name: 'search' }" exact tag="li")
              a
                trending-up-icon
                | Upcoming
            router-link(:to="{ name: 'searchPast' }" tag="li")
              a
                arrow-down-right-icon
                | Past
            router-link(:to="{ name: 'searchSaved' }" tag="li")
              a
                bookmark-icon
                | Saved

    .main.ui.container
      router-view
</template>

<script>
import { TrendingUpIcon, ArrowDownRightIcon, BookmarkIcon } from 'vue-feather-icons'

export default {
  components: {
    TrendingUpIcon,
    ArrowDownRightIcon,
    BookmarkIcon
  },
}
</script>

<style>
.search-heading {
  text-align: center;
  background: #fff;
  padding: 2em 0;
  margin-bottom: 2em;
  margin-top: -2em;
  box-shadow: 0 1px 3px 0 #d4d4d5;
}
</style>
