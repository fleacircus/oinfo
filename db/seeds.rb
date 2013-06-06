User.create({
	email:     "admin@example.org",
	password:  "admin1234",
	activated: true
}).add_role(:meta_admin)
