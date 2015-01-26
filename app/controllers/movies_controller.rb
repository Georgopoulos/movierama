class MoviesController < ApplicationController
	
	before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :movie_uploader, only: [:edit, :update, :destroy]

	def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      flash[:success] = "New movie added successfully!"
      redirect_to current_user
    else
      render 'movies/new'
    end
	end

  def edit
  end

  def update
    if @movie.update_attributes(movie_params)
      flash[:success] = "Movie updated"
      redirect_to @movie.user
    else
      render 'edit'
    end
  end

	def destroy
    @movie.destroy
    flash[:success] = "Movie deleted"
    redirect_to request.referrer || root_url
	end

  private

    def movie_params
      params.require(:movie).permit(:title, :description, :likes, :hates)
    end

    def movie_uploader
      @movie = current_user.movies.find_by(id: params[:id])
      redirect_to root_url if @movie.nil?
    end
end
