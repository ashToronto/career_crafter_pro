# spec/models/subscription_spec.rb
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:subscription_plan) }

  it { should define_enum_for(:status).with_values(active: 0, canceled: 1) }

  it 'is valid with valid attributes' do
    subscription = build(:subscription)
    expect(subscription).to be_valid
  end

  it 'is not valid without a stripe_subscription_id' do
    subscription = build(:subscription, stripe_subscription_id: nil)
    expect(subscription).not_to be_valid
    expect(subscription.errors.messages[:stripe_subscription_id]).to include("can't be blank")
  end

  it 'is not valid without a status' do
    subscription = build(:subscription, status: nil)
    expect(subscription).not_to be_valid
    expect(subscription.errors.messages[:status]).to include("can't be blank")
  end

  it 'is not valid with a duplicate stripe_subscription_id' do
    create(:subscription, stripe_subscription_id: 'duplicate_id')
    subscription = build(:subscription, stripe_subscription_id: 'duplicate_id')
    expect(subscription).not_to be_valid
    expect(subscription.errors.messages[:stripe_subscription_id]).to include('has already been taken')
  end
end
