$(document).ready(function() {
  function scorePwd() {
		var p = $('#user_password').val();
		if(p == '')
		  $('label[for="user_password"], #user_password').attr('class', '');
		else {
		  var s = Password.score(p),
			    i = 0;
	  	if(s > 15) i++;
		  if(s > 24) i++;
		  if(s > 34) i++;
		  if(s > 44) i++;
		  $('label[for="user_password"], #user_password').attr('class', 'password score'+i);
		}
	}
	function hide_confirmation() {
    $('#user_password_confirmation').parent().hide();
	}
	hide_confirmation();
  $('button[name="generate_password"]').click(function() {
    hide_confirmation();
    var pwd;
		while(Password.score(pwd) < 35) pwd = Password.generate();
		$('#user_password').val(pwd).attr('type', 'text');
		$('#user_password_confirmation').val(pwd);
		scorePwd();
  });
  $('#user_password').keyup(function() {
    $('#user_password_confirmation').parent().fadeIn();
    scorePwd();
  });
});
