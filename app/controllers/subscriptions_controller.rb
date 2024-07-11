class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    plan_id = params[:plan_id]
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price: plan_id,
        quantity: 1
      }],
      mode: 'subscription',
      success_url: subscription_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: subscription_cancel_url
    )

    # renders the stripe checkout url for js to handle
    render json: { checkout_url: session.url }
    # redirect_to session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]
    session = Stripe::Checkout::Session.retrieve(session_id)

    customer = Stripe::Customer.retrieve(session.customer)
    subscription = Stripe::Subscription.retrieve(session.subscription)

    @user = current_user
    @subscription_plan = SubscriptionPlan.find_by(stripe_plan_id: subscription.plan.id)

    @user.subscriptions.create!(
      stripe_subscription_id: subscription.id,
      status: :active,
      subscription_plan: @subscription_plan
    )

    redirect_to dashboard_path, notice: 'Subscription successful!'
  end

  def cancel
    redirect_to pricing_path, alert: 'Subscription cancelled.'
  end
end
