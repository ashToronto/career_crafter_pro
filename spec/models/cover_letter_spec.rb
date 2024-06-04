require 'rails_helper'

RSpec.describe CoverLetter, type: :model do
  describe 'associations' do
    it { should belong_to(:resume) }
  end
end
