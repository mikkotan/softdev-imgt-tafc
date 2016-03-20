# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  t = $("#transactions-datatable").DataTable({
    pagingType: "full_numbers",
    sPaginationType: "bootstrap"
    })

  $('#transactions').collapse 'show'

  $select = $('#selectize').selectize
    plugins: [ 'remove_button' ]
    delimiter: ','
    persist: false
    create: (input) ->
      {
        value: input
        text: input
      }
