module ProfilesHelper

  # def icon_for_profile(profile, size, options={})
  #   if profile.icon?
  #     photo_url = profile.icon.url(size)
  #     options.merge!(:alt => I18n.t("tog_social.profiles.helper.photo_for_user", :name => profile.full_name))
  #     return image_tag(photo_url, options) if photo_url
  #   else
  #     return image_tag("/tog_social/images/#{config["plugins.tog_social.profile.image.default"]}" , options)
  #   end
  # end

  def its_me?(profile=@profile)
    account_signed_in? && profile && current_account.profile == profile
  end

  def following_options(profile=@profile)
    if account_signed_in? && current_account.profile.follows?(profile)
      link_to "Dejar de seguir a #{profile.full_name}", member_unfollow_user_path(profile.account)
    else
      link_to "Seguir a #{profile.full_name}", member_follow_user_path(profile.account)
    end
  end

  def friendship_options(profile=@profile)
    if account_signed_in? && current_account.profile.is_friend_of?(profile)
      link_to "Remover amigo", member_unfollow_user_path(profile.account)
    else
      link_to "Agregar amigo", member_add_friend_path(profile.account)
    end
  end

end
