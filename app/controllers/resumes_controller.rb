class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: %i[edit update destroy show]

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to new_resume_experience_path(@resume), notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "resume_#{params[:id]}",
               template: 'layouts/resumes/free_default',
               layout: false, # No layout is used
               page_size: 'A4',
               encoding: 'UTF-8'
      end
    end
  end

  def edit
    render :edit
  end

  def update
    if @resume.update(resume_params)
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @resume.destroy
    redirect_to '/dashboard', notice: 'Resume was successfully destroyed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:first_name, :last_name, :job_title, :country, :state, :phone_number, :email)
  end
end