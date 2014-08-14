$ -> 
  $('#user_search').submit (e) ->
    e.preventDefault()
    window.location = window.location + '/' + $('input', @).val()
    false
    