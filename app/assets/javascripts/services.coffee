# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#servicedatatable").DataTable({
  pagingType: "full_numbers",
  sPaginationType: "bootstrap",
  "aoColumnDefs": [
    { 'bSortable': false, 'aTargets': [ -1 ] }
    ]
  });





  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $('.form-control').on('focus blur', (e) ->
      $(this).parents('.form-group').toggleClass 'focused', e.type == 'focus' or @value.length > 0
      return
      ).trigger 'blur'
    event.preventDefault()
