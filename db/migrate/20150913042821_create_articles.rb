class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :source
      t.string :title
      t.datetime :date_of_public
      t.text :summary
      t.string :author
      t.text :image
      t.text :link

      t.timestamps null: false
    end
  end
end
