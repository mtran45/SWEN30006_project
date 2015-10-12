class Article < ActiveRecord::Base
  validates_uniqueness_of :title

  # Relationship
  belongs_to :source

  # Articles can have tags
  acts_as_taggable


end
