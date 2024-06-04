require 'rails_helper'

RSpec.describe SkillsController, type: :controller do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new Skill to @skill' do
      get :new, params: { resume_id: resume.id }
      expect(assigns(:skill)).to be_a_new(Skill)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates new Skills and redirects to resume' do
        expect do
          post :create, params: { resume_id: resume.id, skills: { name: 'Ruby, Rails, JavaScript' } }
        end.to change(Skill, :count).by(3)
        expect(response).to redirect_to(resume_path(resume))
        expect(flash[:notice]).to eq('Skills were successfully added.')
      end
    end

    context 'with some empty skill names' do
      it 'creates only non-empty Skills and redirects to resume' do
        expect do
          post :create, params: { resume_id: resume.id, skills: { name: 'Ruby, , Rails, , JavaScript' } }
        end.to change(Skill, :count).by(3)
        expect(response).to redirect_to(resume_path(resume))
      end
    end

    context 'with all empty skill names' do
      it 'does not create any Skills and redirects with error message' do
        expect do
          post :create, params: { resume_id: resume.id, skills: { name: ', , , ' } }
        end.not_to change(Skill, :count)
        expect(response).to redirect_to(new_resume_skill_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:skill) { create(:skill, resume: resume) }

    it 'destroys the requested skill and redirects' do
      expect do
        delete :destroy, params: { resume_id: resume.id, id: skill.id }
      end.to change(Skill, :count).by(-1)
      expect(response).to redirect_to(resume_skill_path(resume))
      expect(flash[:notice]).to eq('Skill was successfully removed.')
    end
  end
end
