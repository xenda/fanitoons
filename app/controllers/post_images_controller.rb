class PostImagesController < InheritedResources::Base
  layout "iframe"
  def index
    @post_image = PostImage.new
    index!
  end
  
  def create
     create! { post_images_path }
   end

   def update
     update! { post_images_path }
   end

   def collection
     @post_images ||= end_of_association_chain.paginate :page => params[:page], :per_page => (params[:per_page] || 4), :order => "created_at DESC"
   end
  
end
