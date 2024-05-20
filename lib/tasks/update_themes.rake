namespace :themes do
  desc 'Scan and update the database with new themes'
  task update_db: :environment do
    themes_directory = Rails.root.join('app', 'views', 'layouts', 'resumes')
    Dir.glob("#{themes_directory}/**/*.pdf.haml").each do |file_path|
      theme_name = File.basename(file_path, '.pdf.haml')

      # You can apply any naming convention adjustments here if necessary
      # theme_name = theme_name.gsub('_', ' ').titleize

      if Theme.exists?(name: theme_name)
        puts "Theme already exists: #{theme_name}"
      else
        Theme.create!(name: theme_name, active: true)
        puts "Added new theme: #{theme_name}"
      end
    end
  end
end
