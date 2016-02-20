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
          x.attr('data-placement', 'left')
          x.popover('show')
      }

judge.eachValidators.email = (options, messages) ->
  emailPattern = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  errorMessages = []
  # 'this' refers to the form element
  if (!this.value.match( emailPattern ))
    errorMessages.push('not a valid email')
  new judge.Validation(errorMessages)
