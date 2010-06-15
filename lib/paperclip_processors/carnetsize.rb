module Paperclip
  # Handles thumbnailing images that are uploaded.
  class Carnetsize < Thumbnail

    def transformation_command
      if crop_command
        crop_command + super.sub(/ -crop \S+/, '')
      else
        super
      end
    end

    def crop_command
        " -crop 167x185+0+0"
    end

  end

end
