class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription_plan, null: false, foreign_key: true
      t.string :stripe_subscription_id
      t.integer :status

      t.timestamps
    end
    add_index :subscriptions, :stripe_subscription_id, unique: true
  end
end
