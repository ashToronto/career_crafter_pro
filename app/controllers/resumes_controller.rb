class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: %i[update destroy show download_pdf]

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    @resume.save!
    redirect_to resume_path(@resume), notice: 'Resume was successfully created.'
  rescue ActiveRecord::RecordInvalid => e
    logger.error "Failed to create resume: #{e.message}"
    redirect_to new_resume_path, alert: e.message
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "resume_#{params[:id]}",
               template: "layouts/resumes/#{@resume.theme.name}",
               layout: false, # No layout is used
               page_size: 'A4',
               encoding: 'UTF-8',
               margin: { top: 0, bottom: 0, left: 0, right: 0 } # Remove margins
      end
    end
  end

  def download_pdf
    pdf = render_to_string pdf: "resume_#{params[:id]}",
                           template: "layouts/resumes/#{@resume.theme.name}",
                           layout: false,
                           page_size: 'A4',
                           encoding: 'UTF-8',
                           margin: { top: 0, bottom: 0, left: 0, right: 0 } # Remove margins
    send_data pdf, filename: "resume_#{params[:id]}.pdf", type: 'application/pdf', disposition: 'attachment'
  end

  def edit
    @resume = current_user.resumes.friendly.find(params[:id])
    render :edit
  end

  def update
    @resume.update!(resume_params)
    redirect_to @resume, notice: 'Resume was successfully updated.'
  rescue ActiveRecord::RecordInvalid => e
    logger.error "Failed to update resume: #{e.message}"
    redirect_to resume_path(@resume), alert: e.message
  end

  def destroy
    @resume.destroy!
    redirect_to dashboard_path, notice: 'Resume was successfully destroyed.'
  rescue RecordNotFound => e
    logger.error "Failed to delete resume: #{e.message}"
    redirect_to root_path, alert: e.message
  end

  private

  def set_resume
    @resume = current_user.resumes.includes(:theme, :educations, :skills, :social_link,
                                            experiences: [:rich_text_content],
                                            cover_letter: [:rich_text_content]).friendly.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:first_name, :last_name, :job_title, :country, :state, :phone_number, :email)
  end
end
