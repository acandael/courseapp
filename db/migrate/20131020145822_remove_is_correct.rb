class RemoveIsCorrect < ActiveRecord::Migration
  def change
    remove_column :questions, :is_correct
  end
end
