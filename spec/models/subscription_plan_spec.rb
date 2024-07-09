# spec/models/subscription_plan_spec.rb
require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  it { should have_many(:subscriptions) }

  it { should define_enum_for(:customer_type).with_values(candidate: 0) }

  it 'is valid with valid attributes' do
    subscription_plan = build(:subscription_plan)
    expect(subscription_plan).to be_valid
  end

  it 'is not valid without a name' do
    subscription_plan = build(:subscription_plan, name: nil)
    expect(subscription_plan).not_to be_valid
    expect(subscription_plan.errors.messages[:name]).to include("can't be blank")
  end

  it 'is not valid without a stripe_plan_id' do
    subscription_plan = build(:subscription_plan, stripe_plan_id: nil)
    expect(subscription_plan).not_to be_valid
    expect(subscription_plan.errors.messages[:stripe_plan_id]).to include("can't be blank")
  end

  it 'is not valid without a customer_type' do
    subscription_plan = build(:subscription_plan, customer_type: nil)
    expect(subscription_plan).not_to be_valid
    expect(subscription_plan.errors.messages[:customer_type]).to include("can't be blank")
  end

  it 'is not valid with a duplicate stripe_plan_id' do
    create(:subscription_plan, stripe_plan_id: 'duplicate_id')
    subscription_plan = build(:subscription_plan, stripe_plan_id: 'duplicate_id')
    expect(subscription_plan).not_to be_valid
    expect(subscription_plan.errors.messages[:stripe_plan_id]).to include('has already been taken')
  end
end
