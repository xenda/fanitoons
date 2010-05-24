class AccountsController < ApplicationController
  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(params[:account])
    @account.role = "user"
    if @account.save
      flash[:notice] = '¡Bienvenido a nuestra comunidad! Tu cuenta ya está registrada.'
      redirect_to root_path
    else
      render 'accounts/new'
    end    
  end


  def edit 
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    logger.info params.inspect
    if @account.update_attributes(params[:account])
      #@account.picture = params[:account]["picture"][:tempfile]
      #@account.save
      flash[:notice] = 'Tu cuenta se actualizó sin problemas :)'
      redirect_to root_path
    else
      flash[:warning] = 'Hubieron problemas al actualizar tu cuenta'
      render 'accounts/edit'
    end
  end

end

