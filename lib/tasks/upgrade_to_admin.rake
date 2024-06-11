namespace :admin do
  desc 'Upgrade a user to an admin role'
  task upgrade_to_admin: :environment do
    email = ENV['ADMIN_EMAIL'] # Expect the email to be provided as an environment variable

    user = User.find_by(email: email)

    if user.nil?
      puts "No user found with email: #{email}"
    elsif user.admin?
      puts "User #{email} is already an admin."
    else
      user.admin!
      if user.save
        puts "User #{email} has been successfully upgraded to admin."
      else
        puts "Failed to upgrade user #{email} to admin:"
      end
    end
  end
end
