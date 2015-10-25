module Tagger
  class Tagger

    def tag(article)
      tagmodel = (article.title.length) % 3
      case tagmodel
        when 0
          IndicoTagger.extract(article)
        when 1
          AlchemyTagger.extract(article)
        when 2
          OpencalaisTagger.extract(article)
      end

      EnglishTagger.extract(article)
      RakeTagger.extract(article)
    end

    def self.extract(article)

    end

  end
end
