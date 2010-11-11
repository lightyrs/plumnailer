require 'open-uri'

module Plumnailer

  # Fetch the contents of a url.
  class Fetcher

    UserAgent = 'plumnailer (http://github.com/mmb/plumnailer)'

    # Fetch the contents of a url.
    def fetch(url)
      uri = url.is_a?(URI) ? url : URI(url)
      if uri.is_a?(URI::HTTP)
        open(uri, 'User-Agent' => UserAgent) { |f| f.read }
      end
    end

  end
 
end
