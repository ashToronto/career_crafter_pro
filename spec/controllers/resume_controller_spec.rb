require 'rails_helper'

RSpec.describe ResumesController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      first_name: 'John',
      last_name: 'Doe',
      job_title: 'Developer',
      country: 'USA',
      state: 'California',
      phone_number: '1234567890',
      email: 'john.doe@example.com'
    }
  end
  let(:invalid_attributes) do
    { first_name: '' } # Assume first_name is required
  end

  before do
    sign_in user # Devise helper to sign in a user
  end

  describe 'GET #new' do
    it 'assigns a new resume as @resume' do
      get :new
      expect(assigns(:resume)).to be_a_new(Resume)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Resume' do
        expect do
          post :create, params: { resume: valid_attributes }
        end.to change(Resume, :count).by(1)
      end

      it 'redirects to the created resume' do
        post :create, params: { resume: valid_attributes }
        expect(response).to redirect_to(Resume.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e., to display the 'new' template)" do
        post :create, params: { resume: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #edit' do
    let(:resume) { create(:resume, user: user) }

    it 'assigns the requested resume as @resume' do
      get :edit, params: { id: resume.to_param }
      expect(assigns(:resume)).to eq(resume)
    end
  end

  describe 'PUT #update' do
    let(:resume) { create(:resume, user: user) }

    context 'with valid params' do
      let(:new_attributes) do
        { job_title: 'Senior Developer' }
      end

      it 'updates the requested resume' do
        put :update, params: { id: resume.to_param, resume: new_attributes }
        resume.reload
        expect(resume.job_title).to eq('Senior Developer')
      end

      it 'redirects to the resume' do
        put :update, params: { id: resume.to_param, resume: valid_attributes }
        expect(response).to redirect_to(resume)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e., to display the 'edit' template)" do
        put :update, params: { id: resume.to_param, resume: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:resume) { create(:resume, user: user) }

    it 'destroys the requested resume' do
      expect do
        delete :destroy, params: { id: resume.to_param }
      end.to change(Resume, :count).by(-1)
    end

    it 'redirects to resumes list' do
      delete :destroy, params: { id: resume.to_param }
      expect(response).to redirect_to('/dashboard')
    end
  end
end
