module Plumnailer

  # Find the most representative image on a page.
  class Chooser

    def initialize
      @fetcher = Plumnailer::Fetcher.new
      @doc_parser = Plumnailer::DocParser.new
      @img_url_filters = [Plumnailer::ImgHostnameFilter.new]
      @img_parser = Plumnailer::ImgParser.new(fetcher)
      @scorer = Plumnailer::Scorer.new
    end

    # Find the most representative image on a page.
    def choose(url)
      doc_string = fetcher.fetch(url)

      doc = doc_parser.parse(doc_string, url)

      img_abs_urls = doc.img_abs_urls.dup
      img_url_filters.each do |filter|
        img_abs_urls.delete_if { |i| filter.reject?(i) }
      end

      imgs = img_parser.parse(img_abs_urls)

      unless imgs.empty?
        scores = scorer.score(imgs, doc)
        imgs[scores.index(scores.max)]
      end
    end

    attr_accessor :fetcher
    attr_accessor :doc_parser
    attr_accessor :img_url_filters
    attr_accessor :img_parser
    attr_accessor :scorer

  end

end
