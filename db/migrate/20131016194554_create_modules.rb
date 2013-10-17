class CreateModules < ActiveRecord::Migration
  def up
    create_table :modules do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :modules
  end
end
