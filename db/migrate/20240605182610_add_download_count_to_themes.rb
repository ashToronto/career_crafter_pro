class AddDownloadCountToThemes < ActiveRecord::Migration[7.1]
  def change
    add_column :themes, :download_count, :integer, default: 0
  end
end
