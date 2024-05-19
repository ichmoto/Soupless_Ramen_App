class UsersController < ApplicationController
  before_action :set_user, only: [:favorite]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def favorite
    favorite = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorite)
  end

private
  def set_user
    @user = User.find(params[:id])
  end

end
