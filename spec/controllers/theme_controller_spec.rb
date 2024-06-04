require 'rails_helper'

RSpec.describe ThemesController, type: :controller do
  let(:user) { create(:user) }
  let(:theme) { create(:theme) }
  let(:resume) { create(:resume, user: user, theme: theme) }

  before do
    sign_in user
  end

  describe 'GET #edit' do
    it 'assigns all active themes as @themes' do
      active_theme = create(:theme, active: true)
      inactive_theme = create(:theme, active: false)
      get :edit, params: { resume_id: resume.id }
      expect(assigns(:themes)).to include(active_theme)
      expect(assigns(:themes)).not_to include(inactive_theme)
    end
  end

  describe 'PUT #update' do
    let(:new_theme) { create(:theme) }

    context 'with valid params' do
      it 'updates the theme of the resume and redirects' do
        put :update, params: { resume_id: resume.id, resume: { theme_id: new_theme.id } }
        resume.reload
        expect(resume.theme).to eq(new_theme)
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Resume theme updated successfully.')
      end
    end

    context 'with invalid params' do
      it 'does not update the theme and re-renders the edit view' do
        put :update, params: { resume_id: resume.id, resume: { theme_id: nil } }
        resume.reload
        expect(resume.theme_id).not_to be_nil # Check that the theme_id was not set to nil
        expect(response).to render_template(:edit)
      end
    end
  end

  # Ensure default theme is set if none
  describe '#ensure_default_theme' do
    it 'sets default theme if none is set' do
      resume.theme = nil
      resume.save
      default_theme = create(:theme, name: 'free_default')
      get :edit, params: { resume_id: resume.id }
      resume.reload
      expect(resume.theme).to eq(default_theme)
    end
  end
end
