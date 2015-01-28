class VotesController < ApplicationController
	
	before_action :logged_in_user, only: [:create, :destroy]

  def create
		
		@vote = current_user.votes.new
		@vote.movie_id = params[:movie_id]
		@vote.positive = params[:positive]

  	if @vote.save
      @vote.positive ? @vote.movie.add_like! : @vote.movie.add_hate!
    else
      flash[:danger] = "You #{@vote.errors.messages[:user_id][0]}"
    end
    
    redirect_to :back
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.positive ? vote.movie.remove_like! : vote.movie.remove_hate!
    vote.destroy
    flash[:success] = "Vote cancelled"
    redirect_to :back
  end

end
