class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.text :video_url
      t.integer :mins
      t.integer :secs
      t.integer :chapter_id

      t.timestamps
    end
  end
end
