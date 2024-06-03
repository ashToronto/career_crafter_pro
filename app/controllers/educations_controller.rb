class EducationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_education, only: %i[edit update destroy]

  def new
    @education = @resume.educations.build
  end

  def edit; end

  def create
    @education = @resume.educations.build(education_params)
    if @education.save!
      redirect_to resume_path(@resume), notice: 'Education was successfully added.'
    else
      render :new
    end
  end

  def update
    if @education.update!(education_params)
      redirect_to resume_path(@resume), notice: 'Education was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @education.destroy!
    redirect_to resume_path(@resume), notice: 'Education was successfully removed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.friendly.find(params[:resume_id])
  end

  def set_education
    @education = @resume.educations.find(params[:id])
  end

  def education_params
    params.require(:education).permit(:institution_name, :location, :field_of_study, :degree, :start_date, :end_date,
                                      :currently_study)
  end
end
