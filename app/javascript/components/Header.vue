<template lang="pug">
  header.header-master
    .container
      .columns
        .column.is-7
          h1.ui.header
            router-link.header-master-logo(:to="{ name: 'home' }")
              img(src="https://forum.hcxp.co/uploads/default/original/2X/d/df54d813733bf64e9a9826b4d0c628b787e30171.png" width="100")

            .header-master-slogan.has-text-grey
              | Independent hard-core punk events directory

        .column
          .level
            .level-left
              b-dropdown.header-master-add-event-dropdown(position="is-bottom-left" ref="addEventDropdown")
                button.button.is-success.is-outlined(slot="trigger")
                  span + Add event

                b-dropdown-item(custom paddingless)
                  form
                    .modal-card(style="width:400px;")
                      section.modal-card-body
                        p Past a link to Facebook event to add it to hcxp:
                        b-field
                          b-input(type="text" placeholder="https://facebook.com/events/..." v-model="newEventLink" required)

                        button(class="button is-primary" @click.prevent="createEvent" :class="{ 'is-loading': isSavingEvent }")
                          | Submit

              template(v-if="userSignedIn")
                b-dropdown(position="is-bottom-left")
                  img.is-circle(slot="trigger" :src="currentUser.attributes.avatar_url" width="35" heigh="35")

                  b-dropdown-item(@click="handleSignOutClicked")
                    | Sign out

              template(v-else)
                a.button(href="/users/auth/discourse")
                  | Join us

            .level-right
              form(@submit.prevent="handleSearchSubmit")
                .field
                  p.control.has-icons-right
                    input.input.is-rounded(type="search" placeholder="Search...")
                    span.icon.is-small.is-right
                      search-icon

      div.tabs.is-toggle.is-fullwidth(v-if="!$route.meta.hideHeaderFilters")
        ul
          router-link(:to="{ name: 'home' }" exact tag="li")
            a
              trending-up-icon
              | Upcoming
          router-link(:to="{ name: 'past' }" tag="li")
            a
              arrow-down-right-icon
              | Past
          router-link(:to="{ name: 'saved' }" tag="li")
            a
              bookmark-icon
              | Saved
</template>

<script>
import { mapGetters } from 'vuex'
import Dropdown from 'vue-my-dropdown'
import { TrendingUpIcon, ArrowDownRightIcon, BookmarkIcon, SearchIcon } from 'vue-feather-icons'

export default {
  components: {
    Dropdown,
    TrendingUpIcon,
    ArrowDownRightIcon,
    BookmarkIcon,
    SearchIcon
  },

  data () {
    return {
      query: '',
      dropdownAddEventVisible: false,
      dropdownVisible: false,
      newEventLink: ''
    }
  },

  mounted () {
    this.$store.dispatch('getCurrentUser')
  },

  methods: {
    showNewEventForm () {
      this.newEventLink = ''
      this.$store.dispatch('changeNewEventFormOpenState', true)
    },

    handleSearchSubmit () {
      this.$router.push({ name: 'search', params: { query: this.query }})
    },

    handleSignOutClicked () {
      this.$store.dispatch('signOut')
    },

    createEvent () {
      let req = this.$store.dispatch('createEvent', { link: this.newEventLink })

      req.then(() => {
        this.$refs.addEventDropdown.toggle()
      })
    }
  },

  computed: {
    ...mapGetters([
      'currentUser', 'userSignedIn', 'newEventFormOpened', 'createEventErrors',
      'isSavingEvent'
    ])
  }
}
</script>

<style lang="scss">
.header-master {
  background: #fff;
  margin-bottom: 2rem;
  padding-bottom: 1rem;
  padding-top: 1rem;
  border-bottom: 1px solid #eee;

  .icon svg {
    stroke-width: 2px;
    fill: none;
    width: 1.2rem;
    height: 1.5rem;
  }
}

.header-master-slogan {
  margin-top: -4px;
  font-size: .9rem;
}

.header-master-add-event-dropdown {
  .dropdown-content {
    padding: 0;
  }

  p {
    margin-bottom: 0.5rem;
    font-weight: 600;
  }
}

.header-master .tabs {
  margin-top: 1rem;
  margin-bottom: .5rem;

  svg {
    height: 16px;
  }
}

.header-master .tabs li.is-active {
  font-weight: 600;

  svg {
    stroke: #fff;
  }
}
</style>
