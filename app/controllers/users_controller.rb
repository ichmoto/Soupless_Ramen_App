class UsersController < ApplicationController
  before_action :set_user, only: [:favorite]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "You have failed to update."
      render :edit
    end
  end

  def favorite
    favorite = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorite)
  end

private
  def user_params
    params.require(:user).permit(:name,:profile_image)
  end
  def set_user
    @user = User.find(params[:id])
  end

end
