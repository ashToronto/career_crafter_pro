# lib/tasks/stripe_subscription_plans.rake
namespace :stripe do
  desc 'Create subscription plans in the database'
  task create_plans: :environment do
    plans = [
      { name: 'Candidate Premium', stripe_plan_id: ENV['CANDIDATE_PLAN_ID'], customer_type: :candidate }
      # Add more plans here as needed
    ]

    plans.each do |plan_attrs|
      plan = SubscriptionPlan.find_or_initialize_by(stripe_plan_id: plan_attrs[:stripe_plan_id])
      plan.update!(plan_attrs)
      puts "Created or updated subscription plan: #{plan.name}"
    end
  end
end
