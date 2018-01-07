import Vue from 'vue'
import ActionCable from 'actioncable'

let ActioncableApp = {}
ActioncableApp.cable = ActionCable.createConsumer()

Vue.prototype.$cable = ActioncableApp.cable

export default ActioncableApp
