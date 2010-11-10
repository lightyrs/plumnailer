require 'open-uri'

module Plumnailer

  # Fetch the contents of a url.
  class Fetcher

    # Fetch the contents of a url.
    def fetch(url)
      open(url) { |f| f.read } if url.is_a?(URI::HTTP)
    end

  end
 
end
