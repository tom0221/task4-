class UsersController < ApplicationController
	before_action :authenticate_user!

  def create
  end

  def index
  	@users = User.all
  	@book = Book.new
    @user = current_user
  end

  def show
  	@user = User.find(params[:id])
  	# @books = Book.where(user_id: current_user.id)
    @books = Book.all
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "successfully"
    redirect_to user_path(@user.id)
    else
      flash[:alert] = "error"
    render :edit
    end
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def followed
    @user = User.find(params[:id])
    @users = @user.followed
    render 'show_follower'
  end

  def show_follow
    @user = User.find(params[:id])
  end

  def show_follower
    @user = User.find(params[:id])
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
