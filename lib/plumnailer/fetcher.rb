require 'net/http/persistent'

module Plumnailer

  # Fetch the contents of a url.
  class Fetcher

    def initialize
      @user_agent = 'plumnailer (https://github.com/mmb/plumnailer)'
    end

    # Follow this many chained HTTP redirects at most.
    RedirectLimit = 3

    # Fetch the contents of a url.
    #
    # * url - url to fetch, can be string or URI
    # * orig_url - passed in from redirects
    # * redirect_count - the number of redirects so far
    def fetch(url, orig_url=nil, redirect_count=0)
      if redirect_count > RedirectLimit
        raise ArgumentError,
          "too many redirects (#{redirect_count}) for #{orig_url}"
      end

      uri = url.is_a?(URI) ? url : URI(url)
      if uri.is_a?(URI::HTTP)
        http = Net::HTTP::Persistent.new('plumnailer')
        http.headers['User-Agent'] = user_agent
        resp = http.request(uri)
        case resp
          when Net::HTTPSuccess; resp.body
          when Net::HTTPRedirection; fetch(resp['location'], orig_url || url,
            redirect_count + 1)
          else resp.error!
        end
      end
    end

    attr_accessor :user_agent
  end
 
end
