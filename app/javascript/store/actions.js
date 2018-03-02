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

export const getEventBands = ({ commit }, params) => {
  commit(types.UPDATE_EVENT_BANDS_LOADING, true)
  commit(types.CLEAR_EVENT_BANDS)

  let req = Vue.http.get(`/api/v1/events/${params.eventId}/bands`)

  req.then((resp) => {
    commit(types.RECEIVE_EVENT_BANDS, {
      bands: resp.data.data
    })
    commit(types.UPDATE_EVENT_BANDS_LOADING, false)
  })
}

export const updateExistingEvent = ({ commit, state }, event) => {
  if (typeof(state.events[event.id]) == 'undefined') { return false }

  commit(types.RECEIVE_EVENT, {
    event: event
  })
}

export const createEvent = ({ commit, state }, event) => {
  commit(types.SET_IS_SAVING_EVENT, true)
  let req = Vue.http.post('/api/v1/events', event)

  req.then((resp) => {
    commit(types.SET_IS_SAVING_EVENT, false)
    commit(types.SET_CREATE_EVENT_ERRORS, { errors: [] })

    commit(types.EVENT_CREATED, {
      event: resp.data.data
    })

    commit(types.CHANGE_NEW_EVENT_FORM_OPEN_STATE, false)
  })

  req.catch((resp) => {
    commit(types.SET_IS_SAVING_EVENT, false)
    commit(types.SET_CREATE_EVENT_ERRORS, {
      errors: resp.data
    })
  })

  return req
}

export const changeNewEventFormOpenState = ({ commit }, isOpened) => {
  commit(types.SET_CREATE_EVENT_ERRORS, { errors: [] })
  commit(types.CHANGE_NEW_EVENT_FORM_OPEN_STATE, isOpened)
}

export const changeIsSavingEvent = ({ commit }, isSaving) => {
  commit(types.SET_IS_SAVING_EVENT, isSaving)
}
