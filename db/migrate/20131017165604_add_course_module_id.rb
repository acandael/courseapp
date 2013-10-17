class AddCourseModuleId < ActiveRecord::Migration
  def change
    add_column :videos, :course_module_id, :integer
  end
end
