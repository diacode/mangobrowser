#= require jquery
#= require bootstrap

$ -> 
  $('*[data-toggle="tooltip"]').tooltip
    placement: 'left'
  $('#user_search').submit (e) ->
    e.preventDefault()
    window.location = window.location + '/' + $('input', @).val()
    false
    