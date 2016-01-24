# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#datatable").DataTable({
  pagingType: "full_numbers",
  sPaginationType: "bootstrap",
  "aoColumnDefs": [
    { 'bSortable': false, 'aTargets': [ -1 ] }
    ]
  });

  $('#employees').collapse 'show'
    

  $('.form-control').blur( ->
    judge.validate(this, {
      valid: (element) ->
        x = $("##{element.id}") # $('#element_id')
        x.parent().removeClass('has-error')
        x.parent().addClass('has-success')
      invalid: (element, messages) ->
        x = $("##{element.id}")
        x.parent().removeClass('has-success')
        x.parent().addClass('has-error')
        x.attr('data-content', messages.join(','))
        x.attr('data-placement', 'top')
        x.popover('show')
    })
  );
