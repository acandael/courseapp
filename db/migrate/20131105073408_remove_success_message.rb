class RemoveSuccessMessage < ActiveRecord::Migration
  def change
    remove_column :quizzes, :success_message, :text
  end
end
