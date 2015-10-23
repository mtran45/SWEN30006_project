require_relative './scraper/importer.rb'
require_relative './scraper/abc_importer.rb'
require_relative './scraper/herald_sun_importer.rb'
require_relative './scraper/new_york_times_importer.rb'
require_relative './scraper/news_au_importer.rb'
require_relative './scraper/the_age_importer.rb'
require_relative './scraper/the_australian_importer.rb'

module Scraper

  class Scraper

    IMPORTERS = [AbcImporter, HeraldSunImporter, NewsAUImporter,
                NewYorkTimesImporter, TheAustralianImporter, TheAgeImporter]

    # Return an array of articles
    def scrape
      # Set our start and end date
      start_date = ::Date.today - 7
      end_date = ::Date.today

      articles = []
      IMPORTERS.each do |importer_klass|
        importer = importer_klass.new(start_date, end_date)
        importer.scrape
        articles += importer.articles
      end
      articles
    end

  end

end