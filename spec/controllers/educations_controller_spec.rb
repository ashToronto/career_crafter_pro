require 'rails_helper'

RSpec.describe EducationsController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new Education to @education' do
      get :new, params: { resume_id: resume.id }
      expect(assigns(:education)).to be_a_new(Education)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new Education and redirects' do
        expect do
          post :create, params: { resume_id: resume.id, education: attributes_for(:education) }
        end.to change(Education, :count).by(1)
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Education was successfully added.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create an Education and re-renders the new view' do
        expect do
          post :create, params: { resume_id: resume.id, education: attributes_for(:education, institution_name: nil) }
        end.not_to change(Education, :count)
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'GET #edit' do
    let(:education) { create(:education, resume: resume) }

    it 'assigns the requested education to @education' do
      get :edit, params: { resume_id: resume.id, id: education.id }
      expect(assigns(:education)).to eq(education)
    end
  end

  describe 'PUT #update' do
    let(:education) { create(:education, resume: resume) }

    context 'with valid attributes' do
      it 'updates the requested education and redirects' do
        put :update,
            params: { resume_id: resume.id, id: education.id, education: { institution_name: 'Updated University' } }
        education.reload
        expect(education.institution_name).to eq('Updated University')
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Education was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the education and re-renders the edit view' do
        put :update, params: { resume_id: resume.id, id: education.id, education: { institution_name: nil } }
        education.reload
        expect(education.institution_name).not_to be_nil
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:education) { create(:education, resume: resume) }

    it 'destroys the requested education and redirects' do
      expect do
        delete :destroy, params: { resume_id: resume.id, id: education.id }
      end.to change(Education, :count).by(-1)
      expect(response).to redirect_to(resume_path(resume))
      expect(flash[:notice]).to eq('Education was successfully removed.')
    end
  end
end
