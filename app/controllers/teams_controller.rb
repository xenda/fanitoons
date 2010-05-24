Fanitoon.controllers :teams do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :respond_to => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index do
    @teams = Team.all(:order => 'created_at desc')
    render 'teams/index'
    
  end

  get :show do
    @team = Team.find_by_id(params[:id])
    render 'teams/show'
  end

end