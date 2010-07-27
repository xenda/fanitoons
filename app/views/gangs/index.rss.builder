xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("#{config['plugins.tog_core.site.name']} #{I18n.t('tog_social.gangs.site.last_gangs')}")
    xml.link gangs_url
    xml.description("#{@gangs.size} #{I18n.t('tog_social.gangs.site.last_gangs')}")
    xml.language(I18n.locale.to_s)
      for g in @gangs    
          xml.item do
            xml.title(g.name)
            xml.description(g.description)      
            xml.pubDate(g.creation_date(:long))
            xml.author(g.author.profile.full_name)  
            xml.link(gang_url(g))               
            xml.guid(g.id)
          end
      end
  }
}
