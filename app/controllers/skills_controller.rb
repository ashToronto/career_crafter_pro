class SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_skill, only: %i[destroy]

  def new
    @skill = @resume.skills.build
  end

  def create
    skill_names = params[:skills][:name].split(',').map(&:strip).reject(&:empty?)
    skill_names.each do |name|
      @resume.skills.create(name: name)
    end

    redirect_to @resume, notice: 'Skills were successfully added.'
  end

  def destroy
    @skill.destroy
    redirect_to resume_skill_path(@resume), notice: 'Skill was successfully removed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.friendly.find(params[:resume_id])
  end

  def set_skill
    @skill = @resume.skills.find(params[:id])
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
