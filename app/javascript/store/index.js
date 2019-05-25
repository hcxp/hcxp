import Vue from 'vue'
import Vuex from 'vuex'
import * as actions from './actions'
import * as getters from './getters'
import mutations from './mutations'
// import cart from './modules/cart'
// import products from './modules/products'
// import createLogger from '../../../src/plugins/logger'

Vue.use(Vuex)

const state = {
  newEventFormOpened: false,
  createEventErrors: [],
  isSavingEvent: false,
  events: {},
  isLoadingAllEvents: false,
  isLoadingCurrentEvent: true,
  currentEventId: null,
  eventBands: [],
  currentUser: {},
}

export default new Vuex.Store({
  state,
  actions,
  getters,
  mutations
  // modules: {
  //   cart,
  //   products
  // }
})