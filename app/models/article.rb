class Article < ActiveRecord::Base
  validates_uniqueness_of :title

  # Relationship
  belongs_to :source

  # Articles can have tags
  acts_as_taggable

  # Search weighting
  attr_accessor :weight

  def self.search(search)
	  if search
	  	keywords = search.split
	  	results = self.all.to_a
	  	results.each do |article|
	  		article.weight = calculate_weight(article, keywords)
	  	end
	  	results.delete_if {|article| article.weight == 0}
	  	results.sort_by {|article| [article.weight, article.date_of_public] }.reverse
	  else
	    self.all
	  end
  end

  # Returns the search weighting for an Article, given an array of keywords
  def self.calculate_weight(article, keywords)
  	weight = 0
  	# Downcase keywords for case insensitive search
  	keywords.map! {|word| word.downcase}
  	# Add weightings for each keyword
  	keywords.each do |keyword|
  		weight += 4 if article.tag_list.any? {|tag| tag.include?(keyword)}
  		weight += 3 if article.title.downcase.include?(keyword) 
  		weight += 2 if article.summary.downcase.include?(keyword) 
 			weight += 1 if article.source.source_name.downcase.include?(keyword) 
  	end
  	weight
  end

end
