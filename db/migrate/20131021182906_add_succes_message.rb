class AddSuccesMessage < ActiveRecord::Migration
  def change
    add_column :quizzes, :success_message, :text
  end
end
