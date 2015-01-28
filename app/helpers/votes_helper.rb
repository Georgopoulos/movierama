module VotesHelper
	def voted?(user, movie)
		Vote.find_by(user_id: user.id, movie_id: movie.id)
	end

	def vote(vote)
		vote.positive ? 'like' : 'hate'
	end

	def own_movie?(movie)
		movie.user == current_user
	end
end
