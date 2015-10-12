require 'Date'
require 'rss'
require 'open-uri'

require_relative 'article.rb'

class HeraldSunBreakingImporter < Importer
  def initialize start_date, end_date
    super
  end

  # Define the class method for file_name, this should
  # return something similar to the name for your importer
  def self.source_name
    "Herald Sun Breaking News"
  end

  # import news from herald sun breaking news
  def scrape

    url = "http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml"
    source_name = "Herald Sun Breaking News"
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|

        tag_list = "no_category"
        tags = item.title.scan(/[A-Z][a-zA-Z0-9]+/)
        if tags
          tags.shift
          tags.each do |tag|
            tag_list = tag_list + ",#{tag}"
          end
        end

        a_source = Source.find_by(source_name: source_name)
        if item.enclosure
          a_image = item.enclosure.url
        end
        article = Article.new(title: item.title, summary: item.description,
                              source: a_source, date_of_public: item.pubDate,
                              image: a_image, author: nil, link: item.link, tag_list: tag_list)
        article.save

      end
    end


  end
end