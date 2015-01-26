class StaticPagesController < ApplicationController
  def home
    @movies = Movie.all.paginate(page: params[:page], per_page: 10)
  end
end
