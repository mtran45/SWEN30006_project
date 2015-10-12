class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :source_name
      t.text :url
      t.string :type

      t.timestamps null: false
    end
  end
end
