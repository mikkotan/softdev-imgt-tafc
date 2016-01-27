$(document).ready(function() {
  $('[data-toggle=offcanvas]').click(function() {
    $('.sidebar-offcanvas').toggleClass('active');
  });
});
//
$('.form-control').on('focus blur', function(e) {
  $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus' || this.value.length > 0));
}).trigger('blur');


//
