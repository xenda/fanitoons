class GangMailer < ActionMailer::Base

  def join_request(group, user)
      setup_email(user.email, group.author.email)
      @subject    += " Solicitud de inscripción a #{group.name}"
      @body[:url]  = member_gang_pending_members_url(group)
      @body[:group] = group
      @body[:user] = user           
  end
    
  def accept_join_request(group, moderator, user)
      setup_email(moderator.email, user.email)
      @subject    += " Tu solicituda de unirte a #{group.name} ha sido aceptada"
      @body[:url]  = group_url(group)
      @body[:group] = group
      @body[:user] = user           
  end

  def reject_join_request(group, moderator, user)
      setup_email(moderator.email, user.email)
      @subject    += " Tu solicituda de unirte a #{group.name} ha sido rechazada"
      @body[:url]  = group_url(group)
      @body[:group] = group
      @body[:user] = user
      @body[:moderator] = moderator
      @body[:moderator_url] = profile_url(moderator.account)   
  end
  
  def invitation(group, moderator, user)
      setup_email(moderator.email, user.email)
      @subject    += " Invitación a unirte a #{group.name}"
      @content_type = "text/html"
      @body[:group_url]  = gang_url(group)
      mem = group.membership_of(user)
      @body[:accept_url]  = gangs_invitation_accept_url(mem)
      @body[:reject_url]  = gangs_invitation_reject_url(mem)
      @body[:group] = group         
  end    
      
  protected
    def setup_email(from, to)
      @recipients  = "#{to}"
      @from        = "#{from}"
      @content_type = "text/html"
      @subject     = "[Patatoon]"
      @sent_on     = Time.now
    end
end
