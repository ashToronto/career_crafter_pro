namespace :admin do
  desc 'Create or update an admin user'
  task create_admin: :environment do
    email = ENV['EMAIL'] || 'admin@example.com'
    password = ENV['PASSWORD'] || 'password'

    user = User.find_or_create_by(email: email) do |u|
      u.password = password
      u.role = :admin
    end

    if user.persisted?
      if user.created_at == user.updated_at
        puts 'Admin user created successfully!'
      else
        puts 'Admin user already exists and has been updated!'
      end
    else
      puts 'Failed to create or update admin user with error:'
      puts user.errors.full_messages.join(', ')
    end
  end
end
