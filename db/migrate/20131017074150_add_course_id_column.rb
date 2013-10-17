class AddCourseIdColumn < ActiveRecord::Migration
  def change
    add_column :course_modules, :course_id, :integer  
  end
end
