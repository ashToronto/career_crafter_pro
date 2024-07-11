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
    @subscription = current_user.subscriptions.active.last

    if @subscription.present?
      stripe_subscription = Stripe::Subscription.retrieve(@subscription.stripe_subscription_id)
      Stripe::Subscription.update(@subscription.stripe_subscription_id, cancel_at_period_end: true)

      @subscription.update!(status: :canceled)
      redirect_to manage_subscription_path, notice: 'Subscription canceled successfully.'
    else
      redirect_to manage_subscription_path, alert: 'No active subscription found.'
    end
  end

  def manage
    @subscription = current_user.subscriptions.active.last
    @next_billing_date = if @subscription.present? && @subscription.stripe_subscription_id
                           stripe_subscription = Stripe::Subscription.retrieve(@subscription.stripe_subscription_id)
                           Time.at(stripe_subscription.current_period_end)
                         end
  end
end
