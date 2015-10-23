module Tagger
  class Tagger

    def tag(article)
      IndicoTagger.extract(article)
      AlchemyTagger.extract(article)
      OpencalaisTagger.extract(article)
      EngTagger.extract(article)
      RakeTagger.extract(article)

    end

    def extract(article)

    end

  end
end
