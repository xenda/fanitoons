class GangsController < ApplicationController

  before_filter :authenticate_admin!, :only => [:join, :leave]
  before_filter :load_group, :only => [:show, :join, :leave, :members, :accept_invitation, :reject_invitation, :share]

  def index
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'
    @gangs = Gang.active.public.paginate  :per_page => 10,
                                            :page => @page,
                                            :order => @order + " " + @asc
    respond_to do |format|
      format.html
      format.rss { render(:layout => false) }
    end
  end

  def search
    @order = params[:order] || 'name'
    @page = params[:page] || '1'
    @search_term = params[:search_term]
    term = '%' + @search_term + '%'
    @asc = params[:asc] || 'asc'
    @gangs = Gang.active.public.paginate  :per_page => 10,
                                            :conditions => ["(name like ? or description like ?)", term, term],
                                            :page => @page,
                                            :order => @order + " " + @asc
    respond_to do |format|
       format.html { render :template => "groups/index"}
       format.xml  { render :xml => @gangs }
    end
  end

  def show
  end

  def members
  end


  def tag
    @tag = params[:tag]
    @gangs = Gang.active.public.find_tagged_with(@tag)
    respond_to do |format|
      format.html # tag.html.erb
      format.xml  { render :xml => @gangs.to_xml }
    end
  end

  def join
    if @gang.members.include? current_account
      flash[:notice] = "El usuario ya es miembro"
    else
      if @gang.pending_members.include? current_account
        flash[:notice] = "Esperando invitación"
      else
        @gang.join(current_account)
        if @gang.moderated == true
          GangMailer.deliver_join_request(@gang, current_account)
          flash[:ok] = "Invitación recibida"
        else
          @gang.activate_membership(current_account)
          flash[:ok] = "Bienvenido a #{@gang.name}"
        end
      end
    end
    redirect_to gang_url(@gang)
  end

  def leave
    if !@gang.members.include?(current_account) && !@gang.pending_members.include?(current_account)
      flash[:error] = "No es miembro del grupo"
    else
      if @gang.moderators.include?(current_account) && @gang.moderators.size == 1
        flash[:error] = "Eres el último moderador"
      else
        @gang.leave(current_account)
        #todo: eliminar cuando este claro que sucede si un usuario ya es miembro
        flash[:ok] = "Se ha abandonado el grupo"
      end
    end
    redirect_to member_gangs_path
  end
  
  def accept_invitation
    if(@gang.accept_invitation(current_account))
      flash[:ok] = "Invitación aceptada"
    else
      flash[:error] = "No eres parte de la mancha"
    end
    redirect_to gang_path(@gang)
  end
  
  def reject_invitation
    if(@gang.leave(current_account))
      flash[:ok] = "Invitación rechazada"
    else
      flash[:error] = "No eres parte de la mancha"
    end
    redirect_to gang_path(@gang)
  end
  
  protected
    def load_group
      #TODO be more specific with this error control
      begin
        @gang = Gang.find(params[:id])
        raise "Grupo inactivo" unless @gang.active?
      rescue
        flash[:error] = "Sitio no encontrado"
        redirect_to gangs_path
      end
    end

    def send_message_to_moderators(group, user, subject, body)
      group.moderators.each do |moderator|
        message = Message.new(
          :from     => user,
          :to       => moderator,
          :subject  => subject,
          :content  => body)
        message.dispatch!
      end
    end
end
