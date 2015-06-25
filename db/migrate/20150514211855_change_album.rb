class ChangeAlbum < ActiveRecord::Migration
  def change
    rename_column :albums, :track, :name
  end
end
