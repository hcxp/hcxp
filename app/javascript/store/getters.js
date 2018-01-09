import _groupBy from 'lodash.groupby'
import moment from 'moment'

export const currentUser = state => {
  return state.currentUser
}

export const userSignedIn = state => {
  return typeof(state.currentUser.id) !== 'undefined'
}

export const events = state => {
  let events = []
  let eventsArray = Object.keys(state.events).map(id => state.events[id])

  let grouped = _groupBy(eventsArray, (e) => {
    return moment(e.attributes.start_at).startOf('month').format()
  })

  Object.keys(grouped).forEach((key) => {
    events.push({
      date:   key,
      events: grouped[key]
    })
  })

  return events
}

export const event = state => {
  return state.events[state.currentEventId]
}

export const eventBands = state => {
  return state.eventBands
}

export const isLoadingAllEvents = state => {
  return state.isLoadingAllEvents
}

export const isLoadingCurrentEvent = state => {
  return state.isLoadingCurrentEvent
}

export const newEventFormOpened = state => {
  return state.newEventFormOpened
}

export const createEventErrors = state => {
  return state.createEventErrors
}

export const isSavingEvent = state => {
  return state.isSavingEvent
}
