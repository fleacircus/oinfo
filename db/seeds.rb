User.create({
	email:     "admin@example.org",
	password:  "admin1234",
	activated: true
}).add_role(:meta_admin)

m = Mandator.create({
  name: "Example Mandator"
})

User.create({
	email:       "mandator@example.org",
	password:    "mandator1234",
	activated:   true,
	mandator_id: m.id
}).add_role(:mandator_admin)
