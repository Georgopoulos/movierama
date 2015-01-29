class StaticPagesController < ApplicationController
  def home
		
		@movies = Movie.includes(:user, :votes)

    if params[:sort] == 'date'
      @movies = @movies.order('created_at DESC')
    elsif params[:sort] == 'hates'
      @movies = @movies.order('hates DESC')
    else
      @movies = @movies.order('likes DESC')
    end

    @movies = @movies.paginate(page: params[:page], per_page: 10)
  end
end
