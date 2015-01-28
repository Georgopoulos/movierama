namespace :db  do
  desc "Populate users, movies and votes."
  task :populate_with_content => :environment do
  	# Create some users
    george = 	User.create(fullname: "George Georgopoulos",	email: "g_georgop@yahoo.gr",
    											password: "foobar", password_confirmation: "foobar")
		alex = 		User.create(fullname: "Alexandra Paktiti",	email: "al.paktiti@gmail.com",
    											password: "foobar", password_confirmation: "foobar")
		nikos = 	User.create(fullname: "Nikos Zades",	email: "nikoszades@gmail.com",
    											password: "foobar", password_confirmation: "foobar")
		maria = 	User.create(fullname: "Maria Georgopoulou", email: "m.georgopoulou@hotmail.com",
													password: "foobar", password_confirmation: "foobar")
  
  	# Create movies from these users
    m1 = george.movies.create(title: "The Matrix",	
    												 description: "A computer hacker learns from mysterious rebels 
    												 							about the true nature of his reality and his role 
    												 							in the war against its controllers.")
    george.movies.create(title: "Forrest Gump",
    										 description: "Forrest Gump, while not intelligent, has accidentally 
    										 							been present at many historic moments, but his true love, 
    										 							Jenny Curran, eludes him.")
    george.movies.create(title: "Inception",
    										 description: "A thief who steals corporate secrets through use of 
    										 							dream-sharing technology is given the inverse task of 
    										 							planting an idea into the mind of a CEO.")
    alex.movies.create(title: "Pulp Fiction",
    									 description: "The lives of two mob hit men, a boxer, a gangster's wife, 
    									 							and a pair of diner bandits intertwine in four tales of 
    									 							violence and redemption. ")
   	alex.movies.create(title: "Shutter Island",
   										 description: "In 1954, U.S. Marshal Teddy Daniels is investigating the 
   										 							disappearance of a murderess who escaped from a hospital 
   										 							for the criminally insane and is presumed to be hiding near-by. ")
   	alex.movies.create(title: "The Godfather",
   										 description: "The aging patriarch of an organized crime dynasty transfers 
   										 							control of his clandestine empire to his reluctant son."
		alex.movies.create(title: "Se7en",
											 description: "Two detectives, a rookie and a veteran, hunt a serial 
											 							killer who uses the seven deadly sins as his modus operandi.")
		nikos.movies.create(title: "Django Unchained",
												description: "With the help of a German bounty hunter, a freed slave sets 
																			out to rescue his wife from a brutal Mississippi plantation 
																			owner. ")
		m2 = nikos.movies.create(title: "The Dark Knight Rises",
						  							 description: "When Bane, a former member of the League of Shadows, plans 
																					to continue the work of Ra's al Ghul, the Dark Knight is 
																					forced to return after an eight year absence to stop him.")
		nikos.movies.create(title: "Fight Club", 
												description: "An insomniac office worker looking for a way to change his 
																		 	life crosses paths with a devil-may-care soap maker and they 
																		 	form an underground fight club that evolves into something 
																		 	much, much more... ")
		maria.movies.create(title: "The Lord of the Rings: The Fellowship of the Ring",
												description: "A meek hobbit of the Shire and eight companions set out on 
																			a journey to Mount Doom to destroy the One Ring and the 
																			dark lord Sauron.")
	
		# Vote some movies from users
		Vote.create(user_id: alex.id, movie_id: m1.id, positive: true)
		Vote.create(user_id: alex.id, movie_id: m2.id, positive: false)
		Vote.create(user_id: maria.id, movie_id: m2.id, positive: false)
		Vote.create(user_id: george.id, movie_id: m2.id, positive: true)
  end
end