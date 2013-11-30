class CreateTableUsersanswers < ActiveRecord::Migration
  def change
    create_table :table_usersanswers do |t|
      t.integer :user_id, :answer_id
      
      t.timestamps
    end
  end
end
