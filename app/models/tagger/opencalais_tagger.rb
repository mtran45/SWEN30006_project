require 'open_calais'

module Tagger
  class OpencalaisTagger < Tagger
    API_KEY = 'Lo2dNoVhzlTPuIGBtEhMv7JZx9k5fpdt'

    def extract(article)
      tags = []
      oc = OpenCalais::Client.new(api_key: API_KEY)
      oc_response = oc.enrich article.summary
      oc_response.tags.each { |t| tags << t[:name] }
      oc_response.topics.each { |t| tags << t[:name] }

      article.tag_list.add(tags)
    end
  end
end