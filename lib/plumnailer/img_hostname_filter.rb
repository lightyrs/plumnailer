module Plumnailer

  # Decide whether to process images based on their url hostname.
  class ImgHostnameFilter

    # Return true if this image url should not be considered.
    def reject?(img_url)
      HostnameRejectPatterns.each do |re|
        return true if img_url.host and img_url.host[re]
      end
      false
    end

    HostnameRejectPatterns = [
      %r{^ad\.doubleclick\.net$},
      %r{^b\.scorecardresearch\.com$},
      ]

  end

end
