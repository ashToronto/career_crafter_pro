class CreateSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
