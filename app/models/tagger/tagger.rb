module Tagger
  class Tagger

    def tag(article)
      IndicoTagger.extract(article)
      AlchemyTagger.extract(article)
      OpencalaisTagger.extract(article)
      EnglishTagger.extract(article)
      RakeTagger.extract(article)

    end

    def self.extract(article)

    end

  end
end
