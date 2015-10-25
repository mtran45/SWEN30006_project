require 'engtagger'

module Tagger

  class EnglishTagger < Tagger

    def self.extract(article)
      tgr = EngTagger.new
      word_list = tgr.get_words(article.title).keys
      article.tag_list.add(word_list)
    end

  end
end