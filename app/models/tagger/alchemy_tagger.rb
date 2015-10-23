require 'alchemy_api'
module Tagger
  class AlchemyTagger < Tagger

    API_KEY = 'ee733b1c3dd99422e15c0968d552e789afd8108a'

    def self.extract(article)
      tags = []
      AlchemyAPI.key = API_KEY
      a_entities = AlchemyAPI::EntityExtraction.new.search(text: article.summary)
      a_entities.each { |e|  tags << e['text'] }
      a_concepts = AlchemyAPI::ConceptTagging.new.search(text: article.summary)
      a_concepts.each { |c| tags << c['text'] }
      article.tag_list.add(tags)
    end
  end
end
