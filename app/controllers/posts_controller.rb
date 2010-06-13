class PostsController < ApplicationController
  
  def index
    if params[:query]
      @posts = Post.paginate(:all, :conditions=>["title like ? or content like ?","%#{params[:query]}%","%#{params[:query]}%"],:page=>params[:page])
    else
      @posts = Post.paginate(:all,:order => 'created_at desc', :page => params[:page])
    end
  end

  def show
    @post = Post.find(params[:id])
  end
  
end