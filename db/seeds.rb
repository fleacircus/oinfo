role_level = ['meta', 'mandator']
role_type  = ['admin', 'moderator', 'user']

role_level.each do |l|
	role_type.each do |t|
		Role.create({:name => "#{l}_#{t}"})
	end
end

User.create({
	email: "admin@example.com",
	password: "admin1234"
}).roles << Role.find_by_name('meta_admin')
