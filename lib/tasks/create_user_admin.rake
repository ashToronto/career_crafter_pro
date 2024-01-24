namespace :admin do
  desc 'Create or update an admin user'
  task create_admin: :environment do
    email = ENV['EMAIL'] || 'admin@example.com'
    password = ENV['PASSWORD'] || 'password'

    admin_exists_already = User.find_by(email: email, role: :admin)
    user = User.new(email: email, password: password, role: :admin)

    if admin_exists_already
      puts "admin already exists"
    end

    if user.save
      puts 'Admin user created successfully!'
    else
      puts 'Failed to create admin user:'
      puts user.errors.full_messages.join(', ')
    end
  end
end
