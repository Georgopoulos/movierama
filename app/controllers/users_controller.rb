class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
      flash[:success] = "Welcome to MovieRama!"
			redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])

    if params[:sort] == 'date'
      @movies = @user.movies.order('created_at DESC')
    elsif params[:sort] == 'hates'
      @movies = @user.movies.order('hates DESC')
    else
      @movies = @user.movies.order('likes DESC')
    end
    @movies = @movies.paginate(page: params[:page])
  end

  private

  	def user_params
  		params.require(:user).permit(:fullname, :email, :password, 
																	 :password_confirmation)
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
