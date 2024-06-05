class AddDownloadCountToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :download_count, :integer, default: 0
  end
end
