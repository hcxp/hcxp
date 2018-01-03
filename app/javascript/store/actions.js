import Vue from 'vue'
import * as types from './mutation-types'

export const getCurrentUser = ({ commit }, params) => {
  let req = Vue.http.get('/api/v1/users/me', { params: params })

  req.then((resp) => {
    commit(types.RECEIVE_CURRENT_USER, {
      user: resp.data.data
    })
  })
}

export const signOut = ({ commit }) => {
  let req = Vue.http.delete('/api/v1/users/signout')

  req.then((resp) => {
    commit(types.SIGNED_OUT)
  })
}

export const getAllEvents = ({ commit }, params) => {
  commit(types.UPDATE_ALL_EVENTS_LOADING, true)
  commit(types.CLEAR_EVENTS)

  let req = Vue.http.get('/api/v1/events', { params: params })

  req.then((resp) => {
    commit(types.RECEIVE_ALL_EVENTS, {
      events: resp.data.data
    })
    commit(types.UPDATE_ALL_EVENTS_LOADING, false)
  })
}

export const setCurrentEvent = ({ commit, state }, id) => {
  let eventLoaded = typeof(state.events[id]) !== 'undefined'
  commit(types.SET_CURRENT_EVENT_ID, id)

  if (eventLoaded) {
    commit(types.SET_IS_LOADING_CURRENT_EVENT, false)
  } else {
    let req = Vue.http.get(`/api/v1/events/${id}`)

    req.then((resp) => {
      commit(types.RECEIVE_EVENT, {
        event: resp.data.data
      })
      commit(types.SET_IS_LOADING_CURRENT_EVENT, false)
    })
  }
}
