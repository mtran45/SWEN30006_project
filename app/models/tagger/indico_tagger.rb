require 'indico'

module Tagger
  class IndicoTagger < Tagger

    API_KEY = 'ad48cf7caf0d15033e2693886e65929a'

    def self.extract(article)
      Indico.api_key = API_KEY
      ind_keywords = Indico.keywords article.summary
      tags = ind_keywords.keys
      ind_tags = Indico.text_tags article.summary
      ind_tags_sorted = ind_tags.sort_by { |_k, v| -1.0 * v }.first(10).map {|tag| tag[0]}
      tags += ind_tags_sorted
      article.tag_list.add(tags)
    end

  end
end
