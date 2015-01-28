class StaticPagesController < ApplicationController
  def home
    @movies = Movie.includes(:user, :votes).paginate(page: params[:page], per_page: 10)
  end
end
