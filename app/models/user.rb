# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  fullname        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  remember_digest :string
#

class User < ActiveRecord::Base

	attr_accessor :remember_token

	# -------------------------- Associations ----------------------------
	has_many :movies, dependent: :destroy
	has_many :votes, dependent: :destroy

	# -------------------------- Callbacks -------------------------------

	before_save { email.downcase! }

	# -------------------------- Validations -----------------------------

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email, presence: true, length: { maximum: 208 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :fullname, presence: true, length: { maximum: 50 }
	validates :password, length: { minimum: 6 }, allow_blank: true

	has_secure_password
	
	# -------------------------- Class Methods ----------------------------

	class << self
		# Returns the hash digest of the given string
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                  BCrypt::Engine.cost
	    BCrypt::Password.create(string, cost: cost)
		end

		# Returns a random token
		def new_token
			SecureRandom.urlsafe_base64
		end
	end

	# --------------------------- Instance Methods -------------------------

	# Remembers a user in the DB for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
  	update_attribute(:remember_digest, nil)
  end
end
