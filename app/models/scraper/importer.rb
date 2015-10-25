# This class forms the basis for a generic importer. It provides
# an array data structure to store news items, methods to access these required
# by the exporter

module Scraper
  class Importer
    attr_reader :articles

    # A news scrape is initialised with the start and end date, it
    # then validates that the required methods are provided
    def initialize(start_date, end_date)
      @start = start_date
      @end = end_date
      @articles = []
      validate_subclasses
    end

    private
    # Method to validate that subclass implements the required methods
    def validate_subclasses
      # Validate instance methods
      if not(self.respond_to?(:scrape))
        throw Exception.new('subclass fails to implement the required scrape method')
      end
    end

  end
end