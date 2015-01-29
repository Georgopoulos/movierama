# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  positive   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base

	# ------------------ Associations -------------------------
  belongs_to :user
  belongs_to :movie

  # ------------------ Validations --------------------------
  validates :user_id, presence: true
  validates :movie_id, presence: true
  validates_uniqueness_of :user_id, scope: :movie_id,
  												message: "already voted this movie"
	validate :movie_cannot_be_voted_by_uploader

	# ------------------ Callbacks ----------------------------
  after_save :update_movie_votes
  after_destroy :update_movie_votes

	# ------------------ Instance Methods ---------------------

	def movie_cannot_be_voted_by_uploader
		uploader = Movie.find(self.movie_id).user if self.movie_id
		self.errors[:user_id] << "can't vote your own movie" if uploader == user
	end

  private
    def update_movie_votes
      movie.update_attributes(likes: movie.votes.where(positive: true).count,
                              hates: movie.votes.where(positive: false).count)
    end
end
