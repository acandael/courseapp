class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :video_url
      t.integer :mins
      t.integer :secs

      t.timestamps
    end
  end
end
