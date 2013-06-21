jQuery ->
  $('#error_explanation, div.flash').hide().fadeIn ->
    $(this).delay(10000).fadeOut() if $(this).hasClass 'notice'

  $('input.date_select').datepicker
    dateFormat: 'yy-mm-dd'
    changeMonth: true
    changeYear: true
    showOn: 'button'
    buttonImage: '/assets/icons/calendar-month.png'
    buttonImageOnly: true
