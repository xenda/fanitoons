module GangsHelper

  def tag_cloud_gangs(classes)
    tags = Gang.tag_counts(:conditions => "state= 'active' and private = 0")
    return if tags.empty?
    max_count = tags.sort_by(&:count).last.count.to_f
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end

  def image_for_gang(gang, size, options={})
    return if !gang
    if gang.image?
      photo_url = gang.image.url(size)
      options.merge!(:alt => "Photo for gang: #{gang.name}")
      return image_tag(photo_url, options) if photo_url
    else
      return image_tag("/default_group.png", options)
    end
  end


  def last_gangs(limit=3)
    Gang.find(:all,:conditions => ["state= ? and private = ?", 'active', false],:order => "created_at desc", :limit => limit)
  end


  def i_am_member_of(gang)
    return gang.members.include?(current_account)
  end
  def i_am_moderator_of(gang)
    return gang.moderators.include?(current_account)
  end

end
