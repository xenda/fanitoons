class HomeController < ApplicationController
  
  before_filter :authenticate_account!, :only =>[:invite]
  
  def index
    @posts = Post.all(:order => 'created_at desc')
    @matches = Match.all(:order=> "played_at", :limit=>6)
    @predictions = Prediction.last(6)
    @popular_predictions = Match.most_popular(6)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def about
    render :text => "FaniToons"
  end

  def invite
    redirect_to fb_invite_frients_path
  end
  
  
end