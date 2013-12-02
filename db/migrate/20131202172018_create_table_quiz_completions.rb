class CreateTableQuizCompletions < ActiveRecord::Migration
  def change
    create_table :quiz_completions do |t|
      t.integer :user_id, :quiz_id

      t.timestamps
    end
  end
end
