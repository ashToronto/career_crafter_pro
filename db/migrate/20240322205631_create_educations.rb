class CreateEducations < ActiveRecord::Migration[7.1]
  def change
    create_table :educations do |t|
      t.references :resume, null: false, foreign_key: true
      t.string :institution_name
      t.string :location
      t.string :field_of_study
      t.integer :degree
      t.date :start_date
      t.date :end_date
      t.boolean :currently_study

      t.timestamps
    end
  end
end
