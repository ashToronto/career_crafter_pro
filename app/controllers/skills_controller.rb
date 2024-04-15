class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_skill, only: %i[destroy]

  def new
    @skill = @resume.skills.build
  end

  def create
    @skill = @resume.skills.build(skill_params)
    if @skill.save
      redirect_to resume_path(@resume), notice: 'Skill was successfully added.' # Redirect to the resume's edit page or wherever you manage skills
    else
      render :new # Assuming you have a `new.html.erb` for skills; if not, keep 'resumes/edit'
    end
  end

  def destroy
    @skill.destroy
    redirect_to resume_path(@resume), notice: 'Skill was successfully removed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.find(params[:resume_id])
  end

  def set_skill
    @skill = @resume.skills.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
