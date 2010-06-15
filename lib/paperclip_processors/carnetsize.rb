module Paperclip
  # Handles thumbnailing images that are uploaded.
  class Carnetsize < Thumbnail

    def transformation_command
      result = super
      if result.is_a? Array
        
        result = result.map do |p|
          p.sub(/ -crop \S+/, '')  
        end
        
        crop,size = crop_command.split(" ")
        result.unshift(size)
        result.unshift(crop)
        result
        
      else
        crop_command + result.sub(/ -crop \S+/, '')  
      end
      
    end

    def crop_command
        '-crop 167x185+0+0'
    end

  end

end
