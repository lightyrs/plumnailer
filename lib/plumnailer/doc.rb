require 'uri'

module Plumnailer

  # Nokogiri::HTML:Document mixin.
  module Doc

    # Return a list of the src attributes of all img tags.
    def img_srcs
      search('//img').map { |x| x['src'] }.compact
    end

    # Return a list of the absolute urls of all imgs in the document.
    def img_abs_urls(base_url=nil)
      img_srcs.map do |i|
        u = URI(i)
        u.is_a?(URI::HTTP) ? u : URI.join(base_url || source_url, i)
      end
    end

    attr_accessor :source_url
  end

end
