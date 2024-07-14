class AddEndDateToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :end_date, :datetime
  end
end
