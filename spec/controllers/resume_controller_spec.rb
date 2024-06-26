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

      it 'redirects after resume creation' do
        post :create, params: { resume: valid_attributes }
        expect(response).to redirect_to(resume_path(Resume.last))
      end
    end

    context 'with invalid params' do
      it 'triggers the flash notice and re-renders the page' do
        post :create, params: { resume: invalid_attributes }
        expect(response).to redirect_to(error_path)
        expect(flash[:alert])
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
      it 're-renders the page and shows error flash' do
        put :update, params: { id: resume.to_param, resume: invalid_attributes }
        expect(response).to redirect_to(error_path)
        expect(flash[:alert])
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

  describe 'GET #download_pdf' do
    let(:resume) { create(:resume, user: user) }

    before do
      allow(controller).to receive(:render_to_string).and_return('Mock PDF content')
      get :download_pdf, params: { id: resume.id }
    end

    it 'increments the download count for the resume and the user' do
      expect(resume.reload.download_count).to eq(1)
      expect(user.reload.total_download_count).to eq(1)
    end

    it 'sends a PDF file' do
      expect(response.body).to include('Mock PDF content')
      expect(response.headers['Content-Disposition']).to include("attachment; filename=\"resume_#{resume.id}.pdf\"")
    end
  end
end
