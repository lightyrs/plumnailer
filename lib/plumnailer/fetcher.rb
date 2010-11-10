require 'open-uri'

module Plumnailer

  # Fetch the contents of a url.
  class Fetcher

    # Fetch the contents of a url.
    def fetch(url)
      uri = url.is_a?(URI) ? url : URI(url)
      open(uri) { |f| f.read } if uri.is_a?(URI::HTTP)
    end

  end
 
end
