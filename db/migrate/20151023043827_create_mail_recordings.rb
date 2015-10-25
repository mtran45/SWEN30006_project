class CreateMailRecordings < ActiveRecord::Migration
  def change
    create_table :mail_recordings do |t|
      t.string :email
      t.string :articlename

      t.timestamps null: false
    end
  end
end
