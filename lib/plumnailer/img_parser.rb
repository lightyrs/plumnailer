require 'RMagick'

require 'plumnailer'

module Plumnailer

  # Fetch image data urls, load into Magick::Image and set some additional
  # fields.
  class ImgParser

    def initialize(fetcher)
      @fetcher = fetcher
    end

    # Parse image data from one or more urls.
    def parse(img_urls)
      if img_urls.respond_to?(:inject)
        cache = {}
        img_urls.inject([]) do |memo,u|
          # nil values should be cached
          memo << (cache.include?(u) ? cache[u] : (cache[u] = parse_one(u)))
        end.compact
      else
        parse_one i
      end
    end

    # Fetch image data from a url, load into Magick::ImageList and set some
    # additional fields.
    def parse_one(img_url)
      begin
        img_data = fetcher.fetch(img_url)
        img = Magick::ImageList.new.from_blob(img_data).extend(
          Plumnailer::WebImage)
        img.source_url = img_url
        img
      rescue Exception
        nil
      end
    end

    attr_accessor :fetcher
  end
 
end
