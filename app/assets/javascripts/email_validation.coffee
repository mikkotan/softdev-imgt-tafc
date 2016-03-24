jQuery ->
  $('.form-control').on 'focus', ->
    $('.form-control').on 'blur', ->
      if !$(this).val()
      else
        return judge.validate(this,
          valid: (element) ->
            x = undefined
            x = $(element)
            x.popover 'destroy'
            x.parent().removeClass 'has-error'
            x.parent().addClass 'has-success'
          invalid: (element, messages) ->
            x = undefined
            x = $(element)
            x.parent().removeClass 'has-success'
            x.parent().addClass 'has-error'
            x.attr 'data-content', messages.join(',')
            x.attr 'data-placement', 'right'
            x.attr 'data-container', 'body'
            x.popover 'show'
        )
      return
#judge.eachValidators.email = (options, messages) ->
#  emailPattern = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
#  errorMessages = []
#  # 'this' refers to the form element
#  if (!this.value.match( emailPattern ))
#    errorMessages.push('Please enter a valid email address.')
#  new judge.Validation(errorMessages)


$(document).ready (event) ->
  judge.eachValidators['email'] = (options, messages) ->
    validation = judge.pending()
    judge.get judge.urlFor(this, 'email'),
      success: (status, headers, text) ->
        validation.close text
        return
      error: (status, headers, text) ->
        validation.close [ 'Request error: ' + status ]
        return
    validation
  return

$(document).ready (event) ->
  judge.eachValidators['tin_num'] = (options, messages) ->
    validation = judge.pending()
    judge.get judge.urlFor(this, 'tin_num'),
      success: (status, headers, text) ->
        validation.close text
        return
      error: (status, headers, text) ->
        validation.close [ 'Request error: ' + status ]
        return
    validation
  return
