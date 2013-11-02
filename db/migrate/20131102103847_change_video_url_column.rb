class ChangeVideoUrlColumn < ActiveRecord::Migration
  def change
    change_column :videos, :video_url, :string
  end
end
