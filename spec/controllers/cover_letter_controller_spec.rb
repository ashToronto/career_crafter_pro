require 'rails_helper'

RSpec.describe CoverLettersController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new cover letter to @cover_letter' do
      get :new, params: { resume_id: resume.id }
      expect(assigns(:cover_letter)).to be_a_new(CoverLetter)
    end

    context 'when cover letter already exists' do
      let!(:cover_letter) { create(:cover_letter, resume: resume) }

      it 'redirects to the edit cover letter path' do
        get :new, params: { resume_id: resume.id }
        expect(response).to redirect_to(edit_resume_cover_letter_path(resume))
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new cover letter and redirects' do
        expect do
          post :create, params: { resume_id: resume.id, cover_letter: { content: 'New content' } }
        end.to change(CoverLetter, :count).by(1)
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Cover Letter was successfully added.')
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new cover letter and renders error' do
        expect do
          post :create, params: { resume_id: resume.id, cover_letter: { content: '' } }
        end.to_not change(CoverLetter, :count)
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'PUT #update' do
    let!(:cover_letter) { create(:cover_letter, resume: resume, content: 'Old content') }

    context 'with valid attributes' do
      it 'updates the requested cover letter and redirects' do
        put :update, params: { resume_id: resume.id, id: cover_letter.id, cover_letter: { content: 'Updated content' } }
        cover_letter.reload
        expect(cover_letter.content.to_plain_text).to eq('Updated content')
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Cover Letter was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the cover letter and re-renders the edit method' do
        put :update, params: { resume_id: resume.id, id: cover_letter.id, cover_letter: { content: '' } }
        expect(cover_letter.content.to_plain_text).to eq('Old content')
        expect(response).to redirect_to(error_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cover_letter) { create(:cover_letter, resume: resume) }

    it 'destroys the requested cover letter and redirects' do
      expect do
        delete :destroy, params: { resume_id: resume.id, id: cover_letter.id }
      end.to change(CoverLetter, :count).by(-1)
      expect(response).to redirect_to(resume_path(resume))
      expect(flash[:notice]).to eq('Cover Letter was successfully removed.')
    end
  end
end
