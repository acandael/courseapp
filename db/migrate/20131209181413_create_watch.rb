class CreateWatch < ActiveRecord::Migration
  def change
    create_table :watches do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps
    end
  end
end