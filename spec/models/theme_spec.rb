require 'rails_helper'

RSpec.describe Theme, type: :model do
  describe 'associations' do
    it { should have_many(:resumes) }
  end
end
