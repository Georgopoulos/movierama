# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  likes       :integer          default("0")
#  hates       :integer          default("0")
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Movie < ActiveRecord::Base
  
	# ------------------------- Associations -------------------------
 	belongs_to :user
	has_many :votes, dependent: :destroy

	# ------------------------- Validations --------------------------
	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 120 }
	validates :description, presence: true
	
end
