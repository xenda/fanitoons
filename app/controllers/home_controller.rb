class HomeController < ApplicationController
  
  before_filter :authenticate_account!, :only =>[:invite]
  
  def index
    @posts = Post.all(:order => 'published_at desc, created_at desc', :conditions=>["(published_at <= ?) or published_at is null",Time.zone.now])
    @matches = Match.all(:order=> "played_at", :limit=>7, :include => [:local, :visitor], :conditions => ["played_at >= ?",Time.zone.now - 2.hours])
    @predictions = Prediction.last(6).find(:all, :include => [:winner, :account,{:match=>[:local,:visitor]}])
    @popular_predictions = Match.most_popular(4).find(:all, :include => [:local, :visitor])
    @last_match = @matches.first
    @matches = @matches[1..-1]
  end

  def upload
    
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