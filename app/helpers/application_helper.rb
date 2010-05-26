# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def display_flashes

     flash_tags = [:error, :warning, :notice].map { |type| flash_tag(type, "message #{type}")}.join
     content_tag(:div,flash_tags,{:class=>"flash"})

   end

   def flash_tag(type,tag_class)
    content_tag(:span,flash[type],:class=>tag_class) unless flash[type].blank?
   end
   
   def display_prediction_flash
     content_tag(:div,flash[:prediction_notice]) if flash[:prediction_notice]
   end
  
end
