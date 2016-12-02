class CreateHashtags < ActiveRecord::Migration[5.0]
  def change
    create_table :hashtags do |t|
      t.string :hashtag_text
      t.integer :open
      t.integer :close
      t.integer :change

      t.timestamps
    end
  end
end
