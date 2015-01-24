# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  fullname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

	# -------------------------- Callbacks -------------------------------

	before_save { email.downcase! }

	# -------------------------- Validations -----------------------------

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email, presence: true, length: { maximum: 208 },
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :fullname, presence: true, length: { maximum: 50 }
	validates :password, length: { minimum: 6 }

	has_secure_password
end
