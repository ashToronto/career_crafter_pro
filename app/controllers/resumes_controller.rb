class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: [:edit, :update, :destroy, :show]

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def show
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
