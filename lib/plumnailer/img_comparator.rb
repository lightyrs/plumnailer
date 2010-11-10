module Plumnailer

  # Mixin for Magick::Image that adds a comparator for sorting by relevance.
  module ImgComparator

    def <=> other
      # can use doc here to take source page into account
      other.rows * other.columns <=> rows * columns
    end

  end

end
