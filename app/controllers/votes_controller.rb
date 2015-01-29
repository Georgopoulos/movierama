class VotesController < ApplicationController
	
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :destroy_if_voted_before, only: :create

  def create
		
		@vote = current_user.votes.new
		@vote.movie_id = params[:movie_id]
		@vote.positive = params[:positive]
    
  	if @vote.save
      votes = render_to_string(partial: 'votes/votes', locals: { movie: @vote.movie })
      vote_msg = render_to_string(partial: 'votes/vote_msg', 
                                  locals: { movie: @vote.movie, v: @vote })
      render json: { votes: votes, vote_msg: vote_msg }
    end
    
  end

  def destroy
    vote = Vote.find(params[:id])
    vote.destroy
    votes = render_to_string(partial: 'votes/votes', locals: { movie: vote.movie })
    render json: { votes: votes }
  end

  private
    def destroy_if_voted_before
      if vote = Vote.find_by(user_id: current_user, movie_id: params[:movie_id])
        vote.destroy
      end
    end

end
