module Plumnailer

  # Decide whether to process images based on their url.
  class ImgUrlFilter

    # Return true if this image url should not be considered.
    def reject?(img_url)
      ImgUrlPatterns.each do |re|
        return true  if img_url and img_url.to_s[re]
      end
      false
    end

    ImgUrlPatterns = [
      %r{^http://ad\.doubleclick\.net/},
      %r{^http://b\.scorecardresearch\.com/},
      %r{^http://pixel\.quantserve\.com/},
      %r{^http://s7\.addthis\.com/},
      ]

  end

end
