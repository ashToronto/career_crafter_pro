require 'rails_helper'

RSpec.describe SocialLink, type: :model do
  describe 'associations' do
    it { should belong_to(:resume) }
  end
end
