class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all 
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    @users = User.all
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
  		  redirect_to @user, notice: "successfully "
    else
         flash[:notice] = "error"
         @user = User.find(params[:id])
         render :edit
    end
  end

  def following
    @book = Book.new
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @book = Book.new    
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
    
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

end