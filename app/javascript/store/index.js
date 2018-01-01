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
  events: {},
  isLoadingAllEvents: false,
  currentUser: {}
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
