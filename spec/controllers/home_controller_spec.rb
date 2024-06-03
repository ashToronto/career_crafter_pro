require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is not signed in' do
      it 'does not redirect to the dashboard' do
        get :index
        expect(response).not_to redirect_to(dashboard_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      it 'redirects to the dashboard' do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  describe 'GET #dashboard' do
    context 'when user is signed in' do
      before { sign_in user }

      it 'assigns user resumes to @user_resumes' do
        resume = create(:resume, user: user) # Creating a resume associated with the user
        get :dashboard
        expect(assigns(:user_resumes)).to eq([resume])
      end

      it 'renders the dashboard view' do
        get :dashboard
        expect(response).to render_template(:dashboard)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        get :dashboard
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
