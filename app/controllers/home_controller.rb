class HomeController < ApplicationController
  
  before_filter :authenticate_account!, :only =>[:invite]
  
  def index
    @posts = Post.all(:order => 'created_at desc')
    @matches = Match.all(:order=> "played_at", :limit=>7, :include => [:local, :visitor])
    @predictions = Prediction.last(6).find(:all, :include => [:winner, {:match=>[:local,:visitor]}])
    @popular_predictions = Match.most_popular(4).find(:all, :include => [:local, :visitor])
    @last_match = @matches.first
    @matches = @matches[1..-1]
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