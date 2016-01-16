# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#window.onload = () ->
#  H5F.setup(document.getElementById("forms"))

jQuery ->
  $("#datatable").DataTable({
    autoWidth:"false",
  pagingType: "full_numbers",
  sPaginationType: "bootstrap",
  "aoColumnDefs": [
    { 'bSortable': false, 'aTargets': [ -1 ] }
    ]
    })
