module PlumNailer

  # Find the most representative image on a page.
  class Chooser

    def initialize
      @fetcher = PlumNailer::Fetcher.new
      @doc_parser = PlumNailer::DocParser.new
      @img_parser = PlumNailer::ImgParser.new(fetcher)
      @scorer = PlumNailer::Scorer.new
    end

    # Find the most representative image on a page.
    def choose(url)
      doc_string = fetcher.fetch(url)

      doc = doc_parser.parse(doc_string, url)

      imgs = img_parser.parse(doc.img_abs_urls)

      scores = scorer.score(imgs, doc)
      imgs[scores.index(scores.max)]
    end

    attr_accessor :fetcher
    attr_accessor :doc_parser
    attr_accessor :img_parser
    attr_accessor :scorer

  end

end
