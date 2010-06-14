class Member::GangsController < Member::BaseController

  before_filter :find_gang, :except => [:index, :new, :create]
  before_filter :check_moderator, :except => [:index, :new, :create, :invite, :accept_invitation, :reject_invitation]

  def index
    @moderator_memberships = current_account.moderator_memberships
    @plain_memberships = current_account.plain_memberships
  end

  def create
    @gang = Gang.new(params[:gang])
    @gang.author = current_account
    @gang.save


    if @gang.errors.empty?

      @gang.join(current_account, true)
      #    @gang.activate_membership(current_account)

      # if current_account.admin == true
      #    @gang.activate!
      #    flash[:ok] = "Se ha creado un grupo nuevo"
      #    redirect_to gang_path(@gang)
      # else
      # 
      #   admins = Account.find_all_by_admin(true)        
      #   admins.each do |admin|
      #     Message.new(
      #       :from => current_account,
      #       :to   => admin,
      #       :subject => I18n.t("tog_social.gangs.member.mail.activation_request.subject", :gang_name => @gang.name),
      #       :content => I18n.t("tog_social.gangs.member.mail.activation_request.content", 
      #                          :user_name   => current_account.profile.full_name, 
      #                          :gang_name => @gang.name, 
      #                          :activation_url => edit_admin_gang_url(@gang)) 
      #     ).dispatch!     
      #   end

        flash[:warning] = "Pendiente agregar miembros"
        redirect_to gangs_path
      #end
    else
      render :action => 'new'
    end

  end

  def update
    @gang.update_attributes!(params[:gang])
    @gang.tag_list = params[:gang][:tag_list]
    @gang.save
    flash[:ok] =  "Grupo actualizado"
    redirect_to gang_path(@gang)
  end

  def reject_member
    user = Account.find(params[:user_id])
    if !user
      flash[:error] = "Usuario no existe"
      redirect_to pending_members_paths(@gang)
      return
    end
    @gang.leave(user)
    if @gang.membership_of(user)
      GangMailer.deliver_reject_join_request(@gang, current_account, user)
      flash[:ok] = "Usuario rechazado"
    else
      flash[:error] = "Error encontrado"
    end
    redirect_to member_gang_pending_members_url(@gang)
  end

  def accept_member
    user = Account.find(params[:user_id])
    if !user
      flash[:error] = "Usuario no existe"
      redirect_to pending_members_paths(@gang)
      return
    end
    @gang.activate_membership(user)
    if @gang.members.include? user
      GangMailer.deliver_accept_join_request(@gang, current_account, user)
      flash[:ok] = "¡Usuario aceptado!"
    else
      flash[:error] = "Error encontrado"
    end
    redirect_to member_gang_pending_members_url(@gang)
  end

  def invite
    @gang = Gang.find(params[:membership][:gang_id])
    user = Account.find(params[:membership][:user_id])
    if @gang.can_invite?(current_account)
      if @gang.members.include? user
        flash[:notice] = "El usuario ya es miembro"
      else
        if @gang.invited_members.include? user
          flash[:error] = "El usuario ya ha sido invitado"
        else
          @gang.invite(user)
          @message = Message.new(
          :from => current_account,
          :to => user,
          :subject => "Se ha invitado a un nuevo mienbro",
          :content => render_to_string(:partial => 'invite_mail', :locals =>{:gang=>@gang})
          )
          @message.dispatch!
          flash[:ok] = "Se ha invitado a un nuevo miembro"
        end
      end
    else
      flash[:error] = flash[:error] = "No se pudo invitar"
    end
    redirect_to profile_path(user.profile)
  end

  protected


  def find_gang
    @gang = Gang.find(params[:id]) if params[:id]
  end

  def check_moderator
    unless @gang.moderators.include? current_account
      flash[:error] = "Usuario no es moderador "
      redirect_to gang_path(@gang)
    end
  end

end