class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.string :company_name
      t.date :start_date
      t.date :end_date
      t.string :job_title
      t.string :country
      t.string :city
      t.string :province
      t.boolean :current_work
      t.boolean :remote_work

      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
