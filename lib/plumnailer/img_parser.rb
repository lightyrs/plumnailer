require 'RMagick'

require 'plumnailer'

module PlumNailer

  # Fetch image data urls, load into Magick::Image and set some additional
  # fields.
  class ImgParser

    def initialize(fetcher)
      @fetcher = fetcher
    end

    # Parse image data from one or more urls.
    def parse(img_urls)
      if img_urls.respond_to? :map
        img_urls.map { |i| parse_one i }
      else
        parse_one i
      end
    end

    # Fetch image data from a url, load into Magick::Image and set some
    # additional fields.
    def parse_one(img_url)
      img_data = fetcher.fetch(img_url)
      img = Magick::ImageList.new.from_blob(img_data).first.extend(
        PlumNailer::WebImage)
      img.source_url = img_url
      img
    end

    attr_accessor :fetcher
  end
 
end
