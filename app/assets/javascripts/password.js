'use strict';
var Password = {

	generate: function() {
		var pwd   = '',
			len   = 12,
			skip  = 0,
			count = Math.round(Math.random()*20),
			chars = new Array();

		var w;
		for(w = 0; w < 50; w++) chars[chars.length] = 'abcdefghijklmnopqrstuvwxyz';
		for(w = 0; w < 50; w++) chars[chars.length] = '1234567890';
		for(w = 0; w < 20; w++) chars[chars.length] = '$@_!';

		function gen() {
			var v = chars[Math.round(Math.random()*(chars.length-1))],
				i = Math.round(Math.random()*(v.length-1)),
				s = v.substring(i, i+1);

			if(s.match(/[a-z]/g) && Math.random() > 0.5)
				s = s.toUpperCase();

			if(
				(pwd.indexOf(s) > -1 && v.length > 0
				 && pwd.length < (v.length/2) && skip < 10)
				|| 'o0'.indexOf(s.toLowerCase()) > -1
			) {
				skip++;
				gen();
			} else if(count > 0) {
				count--;
				gen();
			} else {
				pwd += s;
				skip = 0;
				if(pwd.length < len) {
					count = Math.round(Math.random()*20);
					gen();
				}
			}
		}

		gen();
		return pwd;
	},

	score: function(pwd) {
		if(!pwd || pwd == '') return 0;
		var s = 3;

		if(pwd.length < 5) s += 3;
		if(pwd.length > 4) s += 3;
		if(pwd.length > 7) s += 6;
		if(pwd.length > 15) s += 6;
		if(pwd.match(/[a-z]/)) s += 1;
		if(pwd.match(/[A-Z]/)) s += 5;
		if(pwd.match(/\d+/)) s += 5;
		if(pwd.match(/(.*[0-9].*[0-9].*[0-9])/)) s += 5;
		if(pwd.match(/.[!,@,#,$,%,^,&,*,?,_,~]/)) s += 5;
		if(pwd.match(/(.*[!,@,#,$,%,^,&,*,?,_,~].*[!,@,#,$,%,^,&,*,?,_,~])/))
			s += 5;
		if(pwd.match(/([a-z].*[A-Z])|([A-Z].*[a-z])/))
			s += 2;
		if(pwd.match(/([a-zA-Z])/) && pwd.match(/([0-9])/))
			s += 2;
		if(pwd.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/))
			s += 2;

		return s;
	}

};
