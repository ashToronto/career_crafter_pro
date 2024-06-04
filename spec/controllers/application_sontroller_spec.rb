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

    def create
      raise ActiveRecord::RecordInvalid, CoverLetter.new
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

  # Test for ActiveRecord::RecordInvalid
  describe 'handling ActiveRecord::RecordInvalid' do
    it 'redirects to the referrer or error path with a validation failure message' do
      routes.draw { post 'create' => 'anonymous#create' }
      request.headers['Referer'] = edit_resume_cover_letter_path(1)
      post :create

      expect(response).to redirect_to(edit_resume_cover_letter_path(1))
      expect(flash[:alert]).to include('Validation failed')
    end
  end
end
