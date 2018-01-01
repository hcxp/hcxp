export const currentUser = state => {
  return state.currentUser
}

export const userSignedIn = state => {
  return typeof(state.currentUser.id) !== 'undefined'
}

export const events = state => {
  return Object.keys(state.events).map(id => state.events[id])
}

export const isLoadingAllEvents = state => {
  return state.isLoadingAllEvents
}
