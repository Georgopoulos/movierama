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
  												message: "can't vote twice for same movie"
	validate :movie_cannot_be_voted_by_uploader

	
	# ------------------ Instance Methods ---------------------

	def movie_cannot_be_voted_by_uploader
		uploader = Movie.find(self.movie_id).user if self.movie_id
		self.errors[:user_id] << "can't vote his/her own movie" if uploader == user
	end
end
