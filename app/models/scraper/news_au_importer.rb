# This class defines the importer for the News AU source.
#
# It defines the methods for scraping and interpreting the articles
# from the News.com.au: National RSS feed.
#
# The articles scraped are limited to those within start_date and end_date.

require 'Date'
require 'rss'

module Scraper

  class NewsAUImporter < Importer

    SOURCE = Source.find_by(name: 'News.com.au')
    REQUEST_URL =  'http://feeds.news.com.au/public/rss/2.0/news_national_3354.xml'

    # We call super in the initialize method
    def initialize(start_date, end_date)
      super
    end

    # Saves the articles within the date range
    def scrape
      open(REQUEST_URL) do |rss|
        feed = RSS::Parser.parse(rss)

        feed.items.each do |item|
          # Skip and discard articles outside of start and end dates
          pubDate = DateTime.parse(item.pubDate.to_s)
          if pubDate.to_date < @start || pubDate.to_date > @end
            next
          end

          @articles << Article.new(source: SOURCE,
                                author: item.source ? item.source.content.titleize : nil,
                                title: item.title,
                                summary: item.description,
                                images: item.enclosure ? item.enclosure.url : nil,
                                link: item.link,
                                pub_date: pubDate)
        end
      end
    end

  end

end
