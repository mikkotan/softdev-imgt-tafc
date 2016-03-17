jQuery ->
  $('.form-control').on 'focus', ->
    $('.form-control').on 'blur', ->
      judge.validate this, {
        valid: (element) ->
          x = $(element)
          x.popover('destroy')
          x.parent().removeClass('has-error')
          x.parent().addClass('has-success')
        invalid: (element, messages) ->
          x = $(element)
          x.parent().removeClass('has-success')
          x.parent().addClass('has-error')
          x.attr('data-content', messages.join(','))
          x.attr('data-placement', 'right')
          x.attr('data-container', 'body')
          x.popover('show')
      }
