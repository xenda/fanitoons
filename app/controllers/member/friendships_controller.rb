class Member::FriendshipsController < Member::BaseController

  before_filter :find_friend_profile

  def add_friend
    if @friend.add_follower(current_account.profile)
      flash[:ok]= "Solicitud de amistad para #{@friend.full_name}"
      Message.new(
        :from => current_account,
        :to   => @friend.user,
        :subject => "Solicitud de amistad",
        :content => "Solicitud de amistad", 
                           :user_name   => current_account.profile.full_name, 
                           :friend_name => @friend.full_name, 
                           :user_profile_url => profile_url(current_account.profile) , 
                           :confirm_url      => member_confirm_friend_url(current_account.profile))
      ).dispatch!
    end
    redirect_back_or_default(profile_path(current_account.profile))
  end

  def confirm_friend
    if @friend.follows?(current_account.profile) && @friend.add_follower(current_account.profile)
      flash[:ok]="Solicitud de amistad confirmada"
      Message.new(
        :from => current_account,
        :to   => @friend.user,
        :subject => "Han acceptado tu solicitud de amistad",
        :content => "Tienes un nuevo amigo", 
                           :user_name   => current_account.profile.full_name, 
                           :friend_name => @friend.full_name, 
                           :user_profile_url => profile_url(current_account.profile)) 
      ).dispatch! 
    end

    redirect_back_or_default(profile_path(current_account.profile))
  end

  def follow
    if @friend.add_follower(current_account.profile)
      flash[:ok]= "#{@friend.full_name} está siendo seguido"
      Message.new(
        :from => current_account,
        :to   => @friend.user,
        :subject => "Estás siendo seguido por #{current_account.profile.full_name}", 
        :content => "", 
                           :user_name   => current_account.profile.full_name, 
                           :friend_name => @friend.full_name, 
                           :user_profile_url => profile_url(current_account.profile))
      ).dispatch!
    end
    redirect_back_or_default(profile_path(current_account.profile))    
  end

  def unfollow
    if @friend.remove_follower(current_account.profile)
      flash[:ok]="Se ha dejado de seguir a #{@friend.full_name}"
    end
    redirect_back_or_default(profile_path(current_account.profile))    
  end

  private
    def find_friend_profile
      @friend = Profile.find(params[:friend_id])
      unless @friend
        flash[:error] = "No se encontró miembro"
        redirect_to profiles_path
      end
    end
end