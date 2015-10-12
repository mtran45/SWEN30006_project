class AddSourceFormatToSource < ActiveRecord::Migration
  def change
    add_column :sources, :source_format, :string
  end
end
