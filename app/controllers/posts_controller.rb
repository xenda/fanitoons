class PostsController < ApplicationController
  
  def index
    if params[:query]
      @posts = Post.find(:all, :conditions=>["title like ? or content like ?","%#{params[:query]}%","%#{params[:query]}%"])
    else
      @posts = Post.all(:order => 'created_at desc')
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
end