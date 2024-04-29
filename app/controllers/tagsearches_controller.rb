class TagsearchesController < ApplicationController
  def search
    @word = params[:content]
    @posts = Post.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
