class RemoveColumnInArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :source
  end
end
