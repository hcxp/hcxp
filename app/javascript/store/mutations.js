import Vue from 'vue'
import eventBus from '../eventbus'
import * as types from './mutation-types'

export default {
  // Current user
  [types.RECEIVE_CURRENT_USER] (state, { user }) {
    Vue.set(state, 'currentUser', user)
  },

  [types.SIGNED_OUT] (state) {
    eventBus.$emit('notification::show', { type: 'signedOut' })
    Vue.set(state, 'currentUser', {})
  },

  // Events
  [types.RECEIVE_ALL_EVENTS] (state, { events }) {
    events.forEach((e) => {
      Vue.set(state.events, e.id, e)
    })
  },

  [types.RECEIVE_EVENT] (state, { event }) {
    Vue.set(state.events, event.id, event)
  },

  [types.UPDATE_ALL_EVENTS_LOADING] (state, isLoading) {
    Vue.set(state, 'isLoadingAllEvents', isLoading)
  },

  [types.CLEAR_EVENTS] (state) {
    Vue.set(state, 'events', {})
  },

  [types.SET_CURRENT_EVENT_ID] (state, id) {
    Vue.set(state, 'currentEventId', id)
  },

  [types.SET_IS_LOADING_CURRENT_EVENT] (state, isLoading) {
    Vue.set(state, 'isLoadingCurrentEvent', isLoading)
  }
}
