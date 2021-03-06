class HomeController < ApplicationController
  
  before_filter :authenticate_account!, :only =>[:invite, :upload,:post]
  before_filter :set_cache_buster, :only => [:load_temp,:upload,:post]

   
  skip_before_filter :verify_authenticity_token, :only=>["upload","post","load_temp"]
  
  def load_temp
    logger.info "Loading account"
    url = Account.save_upload(params["carga"]["fast_asset"])
    render :text => url
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
    
  
  def index
    @posts = Post.all(:order => 'published_at desc, created_at desc', :conditions=>["(published_at <= ?) or published_at is null",Time.zone.now], :limit => 8)
    @matches = Match.all(:order=> "played_at", :limit=>7, :include => [:local, :visitor], :conditions => ["played_at >= ?",Time.zone.now - 2.hours])
    @predictions = Prediction.last(6).find(:all, :include => [:winner, :account,{:match=>[:local,:visitor]}])
    @popular_predictions = Match.most_popular(4).find(:all, :include => [:local, :visitor])
    @last_match = @matches.first
    @matches = @matches[1..-1]
    @activities = Activity.created_since(1.week.ago).find(:all, :limit => 4)
  end
  
  def about_us
    
  end

  def rules
    
  end

  def upload
    current_account.fast_asset = params["upload"]["fast_asset"]
    current_account.save
    render :text => current_account.picture.url
     #     
     # {"Filename"=>"PIC_1276515600646.png", "dir"=>"../image/", "Upload"=>"Submit Query", "Filedata"=>#<File:/tmp/RackMultipart20100614-13168-82ot1k-0>
  end
  
  def post
    avatar = current_account.get_avatar
    avatar.short_id = params["idShort"]
    avatar.snicker_id = params["idZapatillas"]
    avatar.shirt_id = params["idTshirt"]
    avatar.save
     
    render :text => "Ok"
  end


  def show
    @post = Post.find(params[:id])
  end
  
  def about
    render :text => "Patatoon"
  end

  def invite
    redirect_to fb_invite_frients_path
  end
  
  
end