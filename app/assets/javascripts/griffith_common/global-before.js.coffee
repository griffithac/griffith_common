jQuery ->
  # Auto complete zip codes.  They are too many to load in an web form.
  if $('.zip_code').length
    $('.zip_code').on 'focus', -> 
      $(this).autocomplete
        source: $('.zip_code').data('autocomplete-source')
        minLength: 2
        delay: 500

  # # Add datepicker automaticly for all forms
  # if $('.date-picker').length
  #   $('.date-picker').on 'focus', -> 
  #     $(this).datepicker
  #       format: "yyyy-mm-dd"
        
  if $('.disabled-link').length
    $('.disabled-link').on 'click', (event) ->
      event.preventDefault()
      return false
  
jQuery ->
  if $('.feet-input').length    
    $('.feet-input').inputmask( { mask: "99?\'", placeholder: "_" })


        