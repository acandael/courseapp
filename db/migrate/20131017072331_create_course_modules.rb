class CreateCourseModules < ActiveRecord::Migration
  def up
    create_table :course_modules do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :course_modules
  end
end
