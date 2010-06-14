class HomeController < ApplicationController
  
  before_filter :authenticate_account!, :only =>[:invite]
  
  skip_before_filter :verify_authenticity_token, :only=>"upload"
  
  def index
    @posts = Post.all(:order => 'published_at desc, created_at desc', :conditions=>["(published_at <= ?) or published_at is null",Time.zone.now])
    @matches = Match.all(:order=> "played_at", :limit=>7, :include => [:local, :visitor], :conditions => ["played_at >= ?",Time.zone.now - 2.hours])
    @predictions = Prediction.last(6).find(:all, :include => [:winner, :account,{:match=>[:local,:visitor]}])
    @popular_predictions = Match.most_popular(4).find(:all, :include => [:local, :visitor])
    @last_match = @matches.first
    @matches = @matches[1..-1]
  end

  def upload
    
    current_account.picture = File.read(params["Filedata"])
    current_account.save
    render :text => "Ok"
     #     
     # {"Filename"=>"PIC_1276515600646.png", "dir"=>"../image/", "Upload"=>"Submit Query", "Filedata"=>#<File:/tmp/RackMultipart20100614-13168-82ot1k-0>
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