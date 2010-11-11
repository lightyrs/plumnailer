module Plumnailer

  # Mixin for Magick::Image that adds a comparator for sorting by relevance.
  module ImgComparator

    def <=> other
      # can use doc here to take source page into account

      # square of smallest dimension
      result = ([other.rows, other.columns].min ** 2) <=>
        ([rows, columns].min ** 2)
      # if still tied use number of colors
      if result == 0
        result = other.number_colors <=> number_colors
      end
      result
    end

  end

end
