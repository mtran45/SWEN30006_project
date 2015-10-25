# This class defines the importer for ABC source.
#
# It defines the methods for scraping and interpreting the articles
# from the ABC RSS feed.
#
# The articles scraped are limited to those within start_date and end_date.

require 'Date'
require 'nokogiri'
require 'open-uri'

module Scraper

  class AbcImporter < Importer

    SOURCE = Source.find_by(name: 'ABC')
    REQUEST_URL =  'http://www.abc.net.au/news/feed/45910/rss.xml'

    # We call super in the initialize method
    def initialize(start_date, end_date)
      super
    end

    # Saves the articles within the date range, and then returns the array of articles
    def scrape
      feed = Nokogiri::XML(open(REQUEST_URL))

      feed.xpath('//item').each do |item|
        # Skip articles outside of start and end dates
        pubDate = DateTime.parse(item.at('pubDate').text)
        if pubDate.to_date < @start || pubDate.to_date > @end
          next
        end

        @articles << Article.new(source: SOURCE,
                              author: item.at('./dc:creator') ? 
                                          item.at('./dc:creator').text : nil,
                              title: item.at('title').text,
                              summary: parse_summary(item.at('description').text),
                              images: item.at('./*/media:thumbnail') ?
                                          item.at('./*/media:thumbnail')['url'] : nil,
                              link: item.at('link').text,
                              pub_date: pubDate)
      end
    end

    private

    # Parse the content inside the <p> tags
    def parse_summary(description)
      Nokogiri::HTML(description).xpath('//p').text
    end

  end

end
