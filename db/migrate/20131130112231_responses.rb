class Responses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id, :answer_id
      
      t.timestamps
    end
  end
end
