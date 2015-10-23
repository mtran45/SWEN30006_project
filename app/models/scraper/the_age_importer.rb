# This class defines the importer for The Age and Sydney Morning Herald sources.
#
# It defines the methods for scraping and interpreting the articles
# from The Age: Technology RSS feeds.
#
# The articles scraped are limited to those within start_date and end_date.

require 'Date'
require 'rss'

module Scraper

  class TheAgeImporter < Importer

    SOURCE = Source.find_by(name: 'The Age')
    REQUEST_URL = 'http://www.theage.com.au/rssheadlines/technology-news/article/rss.xml'

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

          summary, image_url = parse_summary_and_images(item.description)
          @articles << Article.new(source: SOURCE,
                                title: item.title,
                                summary: summary,
                                images: image_url,
                                link: item.link,
                                pub_date: pubDate)
        end
      end
    end

    private

    # Parse summary and image url from the description element
    # Returns a tuple: [summary, image_url]
    def parse_summary_and_images(description)
      match_data = description.match(/(?:<p><img src="(\S+)".*<\/p>)?(.+)/)
      # Return [summary, image_url]
      [match_data[2], match_data[1]]
    end

  end

end
