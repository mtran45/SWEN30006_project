require 'rake_text'

module Tagger
  class RakeTagger < Tagger

    def self.extract(article)
      rake = RakeText.new
      tags = rake.analyse article.title, RakeText.SMART
      tags_sorted = tags.sort_by { |_k, v| -1.0 * v }.first(10).map {|tag| tag[0]}
      article.tag_list.add(tags_sorted)
    end
  end
end