module Plumnailer

  # Find the most representative image on a page.
  class Chooser

    def initialize
      @fetcher = Plumnailer::Fetcher.new
      @doc_parser = Plumnailer::DocParser.new
      @img_url_filters = [Plumnailer::ImgUrlFilter.new]
      @img_parser = Plumnailer::ImgParser.new(fetcher)
      @img_comparator = Plumnailer::ImgComparator
    end

    # Find the most representative image on a page.
    # 
    # Return the best image or nil if no suitable images are found.
    #
    # If options[:top] is passed in return up to the top n images. If this
    # option is used the the method will always return of list of size 0 to n.
    def choose(url, options={})
      doc_string = fetcher.fetch(url)

      doc = doc_parser.parse(doc_string, url)

      img_abs_urls = doc.img_abs_urls.dup
      img_url_filters.each do |filter|
        img_abs_urls.delete_if { |i| filter.reject?(i) }
      end

      imgs = img_parser.parse(img_abs_urls)

      imgs.each do |img|
        # set source document on image so it can be used in comparator
        img.doc = doc
        img.extend @img_comparator
      end

      imgs.sort!

      options[:top] ? imgs.first(options[:top]) : imgs.first
    end

    attr_accessor :fetcher
    attr_accessor :doc_parser
    attr_accessor :img_url_filters
    attr_accessor :img_parser
    attr_accessor :img_comparator

  end

end
