class CreateSubscriptionPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :subscription_plans do |t|
      t.string :name, null: false
      t.string :stripe_plan_id, null: false
      t.integer :customer_type, null: false

      t.timestamps
    end
    add_index :subscription_plans, :stripe_plan_id, unique: true
  end
end
