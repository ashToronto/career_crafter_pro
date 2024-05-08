class AddActiveToThemes < ActiveRecord::Migration[7.1]
  def change
    add_column :themes, :active, :boolean, default: true
  end
end
