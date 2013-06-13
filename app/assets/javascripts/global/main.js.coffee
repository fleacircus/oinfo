$(document).ready ->
  $('#error_explanation, div.flash').hide().fadeIn ->
    $(this).delay(10000).fadeOut() if $(this).hasClass 'notice'
