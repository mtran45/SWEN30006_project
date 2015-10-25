# This class defines the importer for The Australian source.
#
# It defines the methods for scraping and interpreting the articles
# from The Ausralian: News RSS feed.
#
# The articles scraped are limited to those within start_date and end_date.

require 'Date'
require 'rss'

module Scraper

  class TheAustralianImporter < Importer

    SOURCE = Source.find_by(name: 'The Australian')
    REQUEST_URL = 'http://feeds.feedburner.com/TheAustralianNewsNDM?format=xml'

    # We call super in the initialize method
    def initialize(start_date, end_date)
      super
    end

    # Saves the articles within the date range, and then returns the array of articles
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
                                summary: parse_summary(item.description),
                                images: item.enclosure ? item.enclosure.url : nil,
                                link: item.guid.content,
                                pub_date: pubDate)
        end
      end
    end

    private

    # Remove embedded image HTML code from the description field
    def parse_summary(description)
      description.sub(/<img.*/,'')
    end

  end

end