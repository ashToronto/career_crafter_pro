class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_experience, only: %i[edit update destroy]

  def new
    @experience = @resume.experiences.build
  end

  def create
    @experience = @resume.experiences.build(experience_params)
    if @experience.save!
      redirect_to resume_path(@resume), notice: 'Work Experience was successfully created.'
    else
      render :new
    end
  end

  def edit
    @experience
  end

  def update
    @experience = @resume.experiences.find(params[:id])
    if @experience.update!(experience_params)
      redirect_to resume_path(@resume), notice: 'Work experience was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy!
    redirect_to resume_path(@resume), notice: 'Experience was successfully removed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.includes(experiences: :rich_text_content).friendly.find(params[:resume_id])
  end

  def set_experience
    @experience = @resume.experiences.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:company_name, :start_date, :end_date, :job_title, :content, :city,
                                       :province, :country, :current_work, :remote_work)
  end
end
