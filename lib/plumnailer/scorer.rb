module Plumnailer

  # Give an image a score based on how representative of the document it is.
  class Scorer

    # Calculate score for one or more images.
    def score(imgs, doc=nil)
      if imgs.respond_to? :map
        imgs.map { |i| score_one i, doc }
      else
        score_one imgs
      end
    end

    # Calculate score for an image.
    #
    # doc is optional and is included so entire document can be used to
    # calculate score.
    def score_one(img, doc=nil)
      img.filesize
    end

  end
 
end
