require 'uri'

module Plumnailer

  # Nokogiri::HTML:Document mixin.
  module Doc

    # Get the href attribute of the base tag from the head of the document.
    def doc_base_href
      base = at('//head/base')
      base['href']  if base
    end

    # Return a list of the src attributes of all img tags.
    def img_srcs
      search('//img').map { |x| x['src'] }.compact
    end

    # Return a list of the absolute urls of all imgs in the document.
    def img_abs_urls(base_url=nil)
      result = []

      img_srcs.each do |i|
        begin
          u = URI(i)
        rescue URI::InvalidURIError
          next
        end

        result <<  if u.is_a?(URI::HTTP)
          u
        else
          URI.join(base_url || doc_base_href || source_url, i)
        end
      end

      result
    end

    attr_accessor :source_url
  end

end
