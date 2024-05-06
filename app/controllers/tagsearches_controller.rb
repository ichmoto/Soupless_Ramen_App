class TagsearchesController < ApplicationController
  def search
    @model = Post
    @word = params[:word]
    @posts = Post.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
