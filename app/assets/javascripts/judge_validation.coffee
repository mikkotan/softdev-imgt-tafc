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