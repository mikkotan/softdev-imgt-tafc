# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 t = $("#transactions-datatable").DataTable({
  pagingType: "full_numbers",
  sPaginationType: "bootstrap"
  })

 $('#addRow').on 'click', () ->
        t.row.add( [
          "haha",
          "hehe",
          "lala"
        ] ).draw( false );
