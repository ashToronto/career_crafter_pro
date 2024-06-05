class AddTotalDownloadCountToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :total_download_count, :integer, default: 0
  end
end
