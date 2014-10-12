Employee.create(first_name: "Bob", last_name: 'Smith',
				email: 'bob@test.com', password: 'password',
				password_confirmation: 'password', status: 'active',
				position: 'painter' )

Employee.create(first_name: "John", last_name: 'Doe',
				email: 'john@test.com', password: 'password',
				password_confirmation: 'password', status: 'active',
				position: 'painter' )

Job.create(name: 'Hancock', street_address: '3s560 Lorraine Ave.',
		   city: 'Warrenville', zipcode: '60555')

Job.create(name: 'Kalb', street_address: '30w243 Estes st.',
		   city: 'Naperville', zipcode: '60563')