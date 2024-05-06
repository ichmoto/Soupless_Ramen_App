class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    posts = Post.find(params[:id])
    posts.destroy
    redirect_to '/posts'
  end

  private

  def post_params
    params.require(:post).permit(:image, :sentence, :category, :star)
  end

end
