require 'rails_helper'

RSpec.describe SocialLinksController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    context 'when a social link exists' do
      let!(:social_link) { create(:social_link, resume: resume) }

      it 'assigns the existing social link to @social_link' do
        get :new, params: { resume_id: resume.id }
        expect(assigns(:social_link)).to eq(social_link)
      end
    end

    context 'when no social link exists' do
      it 'assigns a new social link to @social_link' do
        get :new, params: { resume_id: resume.id }
        expect(assigns(:social_link)).to be_a_new(SocialLink)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:social_link) }

      it 'creates a new social link and redirects' do
        expect do
          post :create, params: { resume_id: resume.id, social_link: valid_attributes }
        end.to change(SocialLink, :count).by(1)
        expect(response).to redirect_to(resume_path(resume))
      end
    end

    context 'with mixed attributes i.e some valid and some invalid' do
      let(:mixed_attributes) { { linkedin_url: 'https://www.linkedin.com/in/your-profile', twitter_url: 'not_a_url' } }

      it 'creates only valid social links and re-renders the form with errors for invalid' do
        expect do
          post :create, params: { resume_id: resume.id, social_link: mixed_attributes }
        end.to change(SocialLink, :count).by(1) # Only LinkedIn URL is valid and gets saved
        expect(flash[:alert]).to include('Validation failed: Twitter url is invalid')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { linkedin_url: 'not_a_url' } }

      it 'does not create a social link and redirects' do
        expect do
          post :create, params: { resume_id: resume.id, social_link: invalid_attributes }
        end.not_to change(SocialLink, :count)
        expect(flash[:alert]).to include('Validation failed: Linkedin url is invalid')
      end
    end
  end

  describe 'PUT #update' do
    let(:social_link) { create(:social_link, resume: resume) }

    context 'with valid attributes' do
      it 'updates the social link and redirects' do
        put :update, params: { resume_id: resume.id, id: social_link.id, social_link: { github_url: 'https://www.github.com/new_example' } }
        social_link.reload
        expect(social_link.github_url).to eq('https://www.github.com/new_example')
        expect(response).to redirect_to(resume_path(resume))
      end
    end

    context 'with mixed valid and invalid attributes' do
      let(:mixed_attributes) { { linkedin_url: 'https://www.linkedin.com/in/new', twitter_url: 'bad_url' } }

      it 'updates valid links and re-renders the edit form with errors for the invalid links' do
        put :update, params: { resume_id: resume.id, id: social_link.id, social_link: mixed_attributes }
        social_link.reload
        expect(social_link.linkedin_url).to eq('https://www.linkedin.com/in/new') # Valid URL updated
        expect(flash[:alert]).to include('Validation failed: Twitter url is invalid')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:social_link) { create(:social_link, resume: resume) }

    it 'destroys the requested social link and redirects' do
      expect do
        delete :destroy, params: { resume_id: resume.id, id: social_link.id }
      end.to change(SocialLink, :count).by(-1)
      expect(response).to redirect_to(resume_path(resume))
    end
  end
end
