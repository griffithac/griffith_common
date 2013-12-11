jQuery ->
  if $('a#submit-button').length
    $('a#submit-button').on 'click', ->
      $('form:first').submit()

jQuery ->
  if $('#submit-button').length
    $('#submit-button').on 'enter', ->
      $('form:first').submit()

jQuery ->
  if $('a#submit-search-button').length
    $('a#submit-search-button').on 'click', ->
      $('form:first').submit()

jQuery ->
  $('#resize-full').on 'click', ->
    $('div.expandible').addClass('col-md-12').removeClass('col-md-8')
    $('div.collapsible').hide()
    $('#resize-full').hide()
    $('#resize-small').show()  
  $('#resize-small').on 'click', ->
    $('div.expandible').removeClass('col-md-12').addClass('col-md-8')
    $('div.collapsible').show()
    $('#resize-full').show()
    $('#resize-small').hide()

jQuery ->
  $('tr.rowlink').rowlink( target: 'td.rowlink a' )
  $('select').chosen
    width: '100%'
  $('.elastic').elastic()
  $('.date-picker').datepicker
      format: "yyyy-mm-dd"

$(document).bind 'nested:fieldAdded', ->
  $('select').chosen
      width: '100%'
  $('.date-picker').datepicker
      format: "yyyy-mm-dd"

$(document).bind 'ui:refresh', ->
  $('select').chosen
      width: '100%'
  $('tr.rowlink').rowlink( target: 'td.rowlink a' )
  $('.elastic').elastic()
  $('.date-picker').datepicker
      format: "yyyy-mm-dd"
