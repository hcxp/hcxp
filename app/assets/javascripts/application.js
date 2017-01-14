// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require moment.min
//= require moment.pl
//= require bootstrap-datetimepicker.min
//= require google-analytics-turbolinks
//= require Luminous.min
//= require simplemde.min
//= require_tree .
//= require_self

$(document).on('turbolinks:load', function(){
  window.csrf_token = $('meta[name="csrf-token"]')[0].content

  Vue.config.debug = true
  Vue.config.devtools = true
  Vue.http.headers.common['X-CSRF-Token'] = csrf_token

  Vue.component('Multiselect', VueMultiselect.default)

  new Vue({el: 'body'})
})