module SetupBot
	def create_user(user, photo)
		user.foto_blobs << photo 
		user.save
		user
	end
	
	def create_3_users(current_user, user2, user3, photo)
		create_user(current_user, photo)
		create_user(user2, photo)
		create_user(user3, photo)
		true
	end
end