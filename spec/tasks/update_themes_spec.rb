# spec/tasks/themes_spec.rb

require 'rails_helper'
require 'rake'

RSpec.describe 'themes:update_db', type: :task do
  before do
    Rake.application.load_rakefile
  end

  let(:themes_directory) { Rails.root.join('app', 'views', 'layouts', 'resumes') }
  let(:file_paths) { ["#{themes_directory}/free_modern.pdf.haml", "#{themes_directory}/free_classic.pdf.haml"] }

  before do
    allow(Dir).to receive(:glob).and_return(file_paths)
    allow(File).to receive(:basename).and_call_original
    allow(File).to receive(:basename).with(file_paths.first, '.pdf.haml').and_return('free_modern')
    allow(File).to receive(:basename).with(file_paths.last, '.pdf.haml').and_return('free_classic')
  end

  it 'creates new themes if they do not exist' do
    expect do
      Rake::Task['themes:update_db'].reenable
      Rake::Task['themes:update_db'].invoke
    end.to change { Theme.count }.by(2)
  end

  it 'does not create a theme if it already exists' do
    Theme.create!(name: 'free_modern', active: true)
    Theme.create!(name: 'free_classic', active: true)
    expect do
      Rake::Task['themes:update_db'].reenable
      Rake::Task['themes:update_db'].invoke
    end.to change { Theme.count }.by(0)
  end

  # Uncommented and corrected for invocation
  it 'prints messages to the console' do
    expect do
      Rake::Task['themes:update_db'].reenable
      Rake::Task['themes:update_db'].invoke
    end.to output(/Added new theme: free_classic/).to_stdout
  end
end
