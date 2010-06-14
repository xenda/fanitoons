class Member::ProfilesController < Member::BaseController

  def edit
    @profile = current_account.profile
  end

  def update
    profile = current_account.profile
    profile.update_attributes!(params[:profile])
    profile.save
    flash[:ok] = "Perfil actualizado"
    redirect_to profile_path(profile)
  end

end