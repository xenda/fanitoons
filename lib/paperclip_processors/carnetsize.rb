module Paperclip
  # Handles thumbnailing images that are uploaded.
  class Carnetsize < Thumbnail

    def transformation_command
      result = super
      if super.is_a? Array
        result.each do |p|
          p.sub!(/ -crop \S+/, '')  
        end
      else
        crop_command + result.sub(/ -crop \S+/, '')  
      end
      
    end

    def crop_command
        " -crop 167x185+0+0"
    end

  end

end
