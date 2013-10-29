class AddTagline < ActiveRecord::Migration
  def change
    add_column :chapters, :tagline, :string
    add_column :chapters, :badge_image, :string
  end
end
