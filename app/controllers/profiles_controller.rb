class ProfilesController < ApplicationController
  
  def show
    @account = Account.find(params[:id])
  end
  
  
  
end