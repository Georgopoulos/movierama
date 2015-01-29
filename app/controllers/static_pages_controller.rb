class StaticPagesController < ApplicationController
  include MoviesHelper
  
  def home
    @movies = order_movies(Movie.includes(:user, :votes))
  end
end
