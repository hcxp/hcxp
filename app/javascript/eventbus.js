import Vue from 'vue'

const bus = new Vue()
Vue.prototype.$bus = bus

export default bus
