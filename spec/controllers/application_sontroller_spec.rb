require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # Mock controller to test ApplicationController
  controller do
    def index
      raise StandardError, 'Simulated StandardError'
    end

    def show
      raise ActiveRecord::RecordNotFound, 'Simulated RecordNotFound'
    end
  end

  # Test for StandardError
  describe 'handling StandardError' do
    it 'redirects to the error path with an error message' do
      routes.draw { get 'index' => 'anonymous#index' }
      get :index

      expect(response).to redirect_to(error_path)
      expect(flash[:alert]).to eq('Simulated StandardError')
    end
  end

  # Test for ActiveRecord::RecordNotFound
  describe 'handling ActiveRecord::RecordNotFound' do
    it 'redirects to the error path with an error message' do
      routes.draw { get 'show' => 'anonymous#show' }
      get :show

      expect(response).to redirect_to(error_path)
      expect(flash[:alert]).to eq('Simulated RecordNotFound')
    end
  end
end
