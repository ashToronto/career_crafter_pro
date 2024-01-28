class AddCandidateInfoToResumes < ActiveRecord::Migration[7.1]
  def change
    add_column :resumes, :first_name, :string
    add_column :resumes, :last_name, :string
    add_column :resumes, :country, :string
    add_column :resumes, :state, :string
    add_column :resumes, :phone_number, :string
    add_column :resumes, :email, :string
    add_column :resumes, :job_title, :string
  end
end
