/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import VueMoment from 'vue-moment'
import store from '../store'
import VueNotifications from 'vue-notifications'
import iziToast from 'izitoast'// https://github.com/dolce/iziToast
import eventBus from '../eventbus'

import App from '../app.vue'
import HomePage from '../pages/HomePage.vue'
import PastEventsPage from '../pages/PastEventsPage.vue'
import SearchPage from '../pages/SearchPage.vue'
import SearchUpcomingPage from '../pages/SearchUpcomingPage.vue'
import SearchPastPage from '../pages/SearchPastPage.vue'
import SearchSavedPage from '../pages/SearchSavedPage.vue'
import EventPage from '../pages/EventPage.vue'

import 'izitoast/dist/css/iziToast.min.css'

// Vue-notifications plugin
function toast ({title, message, type, timeout, cb}) {
  if (type === VueNotifications.types.warn) type = 'warning'
  return iziToast[type]({title, message, timeout})
}
const notificationOptions = {
  success: toast,
  error: toast,
  info: toast,
  warn: toast
}

Vue.use(VueRouter)
Vue.use(VueResource)
Vue.use(VueMoment)
Vue.use(VueNotifications, notificationOptions)

// Vue-resource settings
Vue.http.options.root = '/api/v1'
Vue.http.interceptors.push(function(request, next) {
  request.headers.set('X-CSRF-TOKEN', document.querySelector('[name="csrf-token"]').getAttribute('content'))
  next()
})

const routes = [{
  path: '/',
  name: 'home',
  component: HomePage
}, {
  path: '/past',
  name: 'past',
  component: PastEventsPage
}, {
  path: '/saved',
  name: 'saved',
  component: HomePage
}, {
  path: '/e/:id',
  name: 'event',
  component: EventPage,
  meta: { hideHeaderFilters: true }
}, {
  path: '/s/:query',
  component: SearchPage,
  children: [{
    path: '',
    name: 'search',
    component: SearchUpcomingPage,
    meta: { hideHeaderFilters: true }
  }, {
    path: 'past',
    name: 'searchPast',
    component: SearchPastPage,
    meta: { hideHeaderFilters: true }
  }, {
    path: 'saved',
    name: 'searchSaved',
    component: SearchSavedPage,
    meta: { hideHeaderFilters: true }
  }]
}]

const router = new VueRouter({
  routes,
  linkActiveClass: 'active'
})

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount('hello')
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks';
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
