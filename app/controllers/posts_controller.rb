class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post = current_user.posts.build(post_params)
    if @post.save
      latitude = params[:post][:map][:latitude]
      longitude = params[:post][:map][:longitude]
    unless latitude.empty? && longitude.empty?
      @map = @post.build_map(
        latitude: latitude,
        longitude: longitude
        )
      @map.save
    end
      redirect_to posts_path
    else
      render :new
    end
  end


  def index
    @posts = Post.all
    @posts = @posts.with_star(params[:star]) if params[:star].present?

    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @posts = @posts.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    end

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
    params.require(:post).permit(:image, :sentence, :category, :star, map_attributes: [:id, :latitude, :longitude])
  end

end
