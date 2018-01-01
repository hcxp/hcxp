import Vue from 'vue'
import * as types from './mutation-types'

export default {
  // Current user
  [types.RECEIVE_CURRENT_USER] (state, { user }) {
    state.currentUser = user
  },

  [types.SIGNED_OUT] (state) {
    state.currentUser = {}
  },

  // Events
  [types.RECEIVE_ALL_EVENTS] (state, { events }) {
    events.forEach((e) => {
      Vue.set(state.events, e.id, e)
    })
  },

  [types.UPDATE_ALL_EVENTS_LOADING] (state, isLoading) {
    state.isLoadingAllEvents = isLoading
  },

  [types.CLEAR_EVENTS] (state) {
    state.events = {}
  }
}
