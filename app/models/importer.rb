require_relative 'article.rb'

class Importer
  def initialize start_date, end_date
    @start = start_date
    @end = end_date
    validate_subclasses
  end

  # Method to return news articles, ensuring that we only return
  # unique news articles
  def articles
    @articles.uniq
  end

  private
  # Method to valid subclass implements the required methods
  def validate_subclasses
    # Validate instance methods
    if not(self.respond_to?(:scrape))
      throw Exception.new("subclass fails to implement the required scrape method")
    end

    # Validate class methods
    if not(self.class.respond_to?(:source_name))
      throw Exception.new("subclass fails to provide source_name")
    end
  end
end
