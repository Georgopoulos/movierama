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

require 'test_helper'

class MovieTest < ActiveSupport::TestCase

  include MoviesHelper
  
  def setup
  	@user = users(:george)
  	@movie = @user.movies.build(title: "Yet another movie",
				  										 	description: "4 Teenagers start their trip...",
				  										 	user_id: @user.id,
				  										 	likes: 0,
				  										 	hates: 0)	
  end

  test "should be valid" do
  	assert @movie.valid?
  end

  test "user id should be present" do
  	@movie.user_id = nil
  	assert_not @movie.valid?
  end

  test "title should be present" do
  	@movie.title = nil
  	assert_not @movie.valid?
  end

  test "title should be at most 120 characters" do
  	@movie.title = "a" * 121
  	assert_not @movie.valid?
 	end

  test "title should be unique" do
    duplicated_movie = @movie.dup
    duplicated_movie.title = @movie.title.upcase
    @movie.save
    assert_not duplicated_movie.valid?
  end

  test "title should be saved as downcase" do
    mixed_case_title = "The MAtrIX"
    @movie.title = mixed_case_title
    @movie.save
    assert_equal @movie.reload.title, mixed_case_title.downcase
  end 

 	test "description should be present" do
 		@movie.description = nil
 		assert_not @movie.valid?
 	end

end
