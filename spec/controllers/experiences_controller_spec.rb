require 'rails_helper'

RSpec.describe ExperiencesController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new Experience to @experience' do
      get :new, params: { resume_id: resume.id }
      expect(assigns(:experience)).to be_a_new(Experience)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Experience and redirects' do
        expect do
          post :create, params: { resume_id: resume.id, experience: attributes_for(:experience) }
        end.to change(Experience, :count).by(1)
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Work Experience was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create an Experience and renders error' do
        expect do
          post :create, params: { resume_id: resume.id, experience: attributes_for(:experience, company_name: nil) }
        end.not_to change(Experience, :count)
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'GET #edit' do
    let(:experience) { create(:experience, resume: resume) }

    it 'assigns the requested experience to @experience' do
      get :edit, params: { resume_id: resume.id, id: experience.id }
      expect(assigns(:experience)).to eq(experience)
    end
  end

  describe 'PUT #update' do
    let(:experience) { create(:experience, resume: resume) }

    context 'with valid attributes' do
      it 'updates the requested experience and redirects' do
        put :update,
            params: { resume_id: resume.id, id: experience.id, experience: { company_name: 'Updated Company' } }
        experience.reload
        expect(experience.company_name).to eq('Updated Company')
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Work experience was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the experience and renders error' do
        put :update, params: { resume_id: resume.id, id: experience.id, experience: { company_name: nil } }
        experience.reload
        expect(experience.company_name).not_to be_nil
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:experience) { create(:experience, resume: resume) }

    it 'destroys the requested experience and redirects' do
      expect do
        delete :destroy, params: { resume_id: resume.id, id: experience.id }
      end.to change(Experience, :count).by(-1)
      expect(response).to redirect_to(resume_path(resume))
      expect(flash[:notice]).to eq('Experience was successfully removed.')
    end
  end
end
