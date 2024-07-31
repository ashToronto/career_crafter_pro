namespace :themes do
  desc 'Create theme names'
  task create_names: :environment do
    themes = %w[free_default free_modern premium_classic premium_modern]
    themes.each do |name|
      Theme.find_or_create_by(name: name)
    end
    puts 'Theme added'
  end
end
