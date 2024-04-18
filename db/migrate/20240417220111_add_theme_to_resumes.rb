class AddThemeToResumes < ActiveRecord::Migration[7.1]
  def change
    add_reference :resumes, :theme, null: true, foreign_key: true
  end
end
