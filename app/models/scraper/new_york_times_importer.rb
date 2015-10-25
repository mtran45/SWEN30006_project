# This class defines the importer for the New York Times source.
#
# It defines the methods for scraping and interpreting the articles
# from the New York Times: Technology JSON API.
#
# The articles scraped are limited to those within start_date and end_date.

require 'Date'
require 'open-uri'
require 'json'
require 'net/http'

module Scraper

  class NewYorkTimesImporter < Importer

    SOURCE = Source.find_by(name: 'The New York Times')
    REQUEST_URL = 'http://api.nytimes.com/svc/topstories/v1/technology.json?' +
                          'api-key=00d0011c93baba934bc59f15a3b16fb5:4:72668377'

    # We call super in the initialize method
    def initialize(start_date, end_date)
      super
    end

    # Saves the articles within the date range, and then returns the array of articles
    def scrape
      uri = URI.parse(REQUEST_URL)
      http = Net::HTTP.new(uri.host, uri.port)
      response = http.send_request('GET', uri.request_uri)
      json = JSON.parse(response.body)

      json['results'].each do |result|
        # Skip and discard articles outside of start and end dates
        pubDate = DateTime.parse(result['published_date'])
        if pubDate.to_date < @start || pubDate.to_date > @end
          next
        end

        @articles << Article.new(source: SOURCE,
                    title: result['title'],
                    pub_date: pubDate,
                    summary: result['abstract'],
                    # Remove "By " and titleize
                    author: result['byline'].sub(/^by /i,'').titleize,
                    # Set image to the 1st multimedia url if it exists
                    images: result['multimedia'][0] ? result['multimedia'][0]['url'] : nil,
                    link: result['url'])
      end
    end

  end

end
