<template lang="pug">
  .ui.masthead.vertical.tab.segment.mb-4.pb-4(style="display:block")
    .ui.container
      .introduction
        .ui.grid
          .eight.wide.column
            h1.ui.header
              router-link.logo(:to="{ name: 'home' }") hcxp.co
              .sub.header
                | Independent hard-core punk events directory

          .eight.wide.column.right.aligned
            .text.menu.ui.right.compact
              dropdown.v-dropdown(:visible="dropdownAddEventVisible" animation="ani-slide-none" @clickout="dropdownAddEventVisible = false" :position="['right', 'bottom', 'right', 'top']")
                span.click(@click="dropdownAddEventVisible=!dropdownAddEventVisible")
                  a.ui.button.green.basic
                    | + Add event

                div(slot="dropdown")
                  .ui.dropdown.item.active.top.right.pointing
                    .menu.visible(style="display:block; padding: 15px;")
                      p Past a link to Facebook event to add it to hcxp:
                      .ui.input(style="margin-left:0;margin-right:0")
                        input(placeholder="https://facebook.com/event/...")

                      a.ui.button.green.small
                        | Add event

              dropdown.v-dropdown.user-menu(v-if="userSignedIn" :visible="dropdownVisible" animation="ani-slide-none" @clickout="dropdownVisible = false" :position="['right', 'bottom', 'right', 'top']")
                span.click(@click="dropdownVisible=!dropdownVisible")
                  img.ui.mini.avatar.image(:src="currentUser.attributes.avatar_url" width="35" height="35")
                  i.dropdown.icon

                div(slot="dropdown")
                  .ui.dropdown.item.active.top.right.pointing
                    .menu.visible(style="display:block")
                      //- a.item Your profile
                      //- a.item Your events
                      //- .divider
                      a.item(@click.prevent="handleSignOutClicked") Sign-out

              .item(v-else)
                a.ui.button.basic(href="/users/auth/discourse")
                  | Join

              .item.right.aligned
                form.item.ui.top.right.input.large(@submit.prevent="handleSearchSubmit")
                  .ui.search
                    .ui.icon.input
                      input.prompt(placeholder="Search..." v-model="query")
                      i.search.icon

      template(v-if="!$route.meta.hideHeaderFilters")
        .ui.hidden.divider
        .ui.three.item.stackable.tabs.menu.orange
          router-link.item(:to="{ name: 'home' }" exact) Upcoming
          router-link.item(:to="{ name: 'past' }") Past
          router-link.item(:to="{ name: 'saved' }") Saved
</template>

<script>
import { mapGetters } from 'vuex'
import Dropdown from 'vue-my-dropdown'

export default {
  components: {
    Dropdown
  },

  data () {
    return {
      query: '',
      dropdownAddEventVisible: false,
      dropdownVisible: false
    }
  },

  mounted () {
    this.$store.dispatch('getCurrentUser')
  },

  methods: {
    handleSearchSubmit () {
      this.$router.push({ name: 'search', params: { query: this.query }})
    },

    handleSignOutClicked () {
      this.$store.dispatch('signOut')
    }
  },

  computed: {
    ...mapGetters([
      'currentUser', 'userSignedIn'
    ])
  }
}
</script>

<style>
.v-dropdown {
  display: flex;
  margin-left: auto!important;
  padding: .35714286em .5em;
  align-self: center;
}

.masthead .dropdown .menu.visible {
  top: 0 !important;
}

.masthead .user-menu .click {
  cursor: pointer;
}

.masthead .ui.text.menu {
  margin: 0;
}

.masthead .logo {
  color: inherit;
}

.masthead .ui.compact.menu .item:last-child {
  padding-right: 0;
}

.masthead .ui.menu .item>i.dropdown.icon {
  margin-left: 0.3em;
}

.masthead form {
  padding-left: 0 !important;
  padding-right: 0 !important;
}
</style>
