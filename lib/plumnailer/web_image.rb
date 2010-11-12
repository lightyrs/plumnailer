module Plumnailer

  # Mixin for Magick::ImageList that adds url field and source document.
  module WebImage
    attr_accessor :source_url
    attr_accessor :doc
  end

end
