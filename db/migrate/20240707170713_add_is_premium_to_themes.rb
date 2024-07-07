class AddIsPremiumToThemes < ActiveRecord::Migration[7.1]
  def change
    add_column :themes, :is_premium, :boolean, default: false
  end
end
