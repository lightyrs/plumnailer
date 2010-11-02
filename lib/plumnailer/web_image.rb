module PlumNailer

  # Mixin for Magick::Image that adds url field.
  module WebImage
    attr_accessor :source_url
  end

end
