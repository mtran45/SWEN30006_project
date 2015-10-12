class AddSourceToArticle < ActiveRecord::Migration
  def change
    add_reference :articles, :source, index: true, foreign_key: true
  end
end
