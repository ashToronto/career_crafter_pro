class AddSlugToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :slug, :string
    add_index :resumes, :slug, unique: true
  end
end
