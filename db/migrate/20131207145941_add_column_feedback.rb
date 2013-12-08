class AddColumnFeedback < ActiveRecord::Migration
  def change
    add_column :answers, :feedback, :text
  end
end
