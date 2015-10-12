require 'json'
require 'net/http'

require_relative 'article.rb'

class TheTimeImporter < Importer
  def initialize start_date, end_date
    super
  end

  # Define the class method for file_name, this should
  # return something similar to the name for your importer
  def self.source_name
    "The Times Newswire"
  end

  # import news from the times
  def scrape
    website = "http://api.nytimes.com/svc/news/v3/content/all/all/1.json?"\
              "api-key=366cba91e78cc7097e46397d14963dff:15:72728981"
    source_name = "The Times Newswire"
    uri = URI(website)
    res = Net::HTTP.get_response(uri)

    json=res.body
    obj = JSON.parse(json)

    obj["results"].each do |item|
      a_source = Source.find_by(source_name: source_name)
      tag_list = item["section"]+ ",#{item["subsection"]}"
      tags =item["title"].scan(/[A-Z][a-zA-Z0-9]+/)
      if tags
        tags.shift
        tags.each do |tag|
          tag_list = tag_list + ",#{tag}"
        end
      end
      if item["multimedia"].is_a? Array
        article = Article.new(title: item["title"], summary: item["abstract"],
                              source: a_source, date_of_public: item["published_date"],
                              image: item["multimedia"][0]["url"], author: item["byline"], link: item["url"],
                              tag_list: tag_list)
      else
        article = Article.new(title: item["title"], summary: item["abstract"],
                              source: a_source, date_of_public: item["published_date"],
                              image: nil, author: item["byline"], link: item["url"], tag_list: tag_list)

      end
      article.save
    end
  end
end