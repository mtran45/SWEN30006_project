class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :source
      t.string :title
      t.datetime :pub_date
      t.text :summary
      t.string :author
      t.text :images
      t.text :link

      t.timestamps null: false
    end
  end
end
