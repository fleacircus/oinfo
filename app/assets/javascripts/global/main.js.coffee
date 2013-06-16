jQuery ->
  $('#error_explanation, div.flash').hide().fadeIn ->
    $(this).delay(10000).fadeOut() if $(this).hasClass 'notice'

  $('input.date_select').datepicker
    dateFormat: 'yy-mm-dd'
    changeMonth: true
    changeYear: true
    showOn: 'button'
    buttonImage: '/assets/icons/grid/calendar_view_month.png'
    buttonImageOnly: true
