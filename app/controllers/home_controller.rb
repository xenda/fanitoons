class HomeController < ApplicationController
  
  def index
    @posts = Post.all(:order => 'created_at desc')
    @matches = Match.all(:order=> "played_at DESC", :limit=>6)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def about
    render :text => "FaniToons"
  end

end