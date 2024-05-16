class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume, only: %i[update destroy show download_pdf]

  def new
    @resume = current_user.resumes.build
  end

  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to edit_resume_theme_path(@resume), notice: 'Resume was successfully created.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "resume_#{params[:id]}",
               template: "layouts/resumes/#{@resume.theme.name}",
               layout: false, # No layout is used
               page_size: 'A4',
               encoding: 'UTF-8'
      end
    end
  end

  def download_pdf
    pdf = render_to_string pdf: "resume_#{params[:id]}",
                           template: "layouts/resumes/#{@resume.theme.name}",
                           layout: false,
                           page_size: 'A4',
                           encoding: 'UTF-8'
    send_data pdf, filename: "resume_#{params[:id]}.pdf", type: 'application/pdf', disposition: 'attachment'
  end

  def edit
    @resume = current_user.resumes.friendly.find(params[:id])
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
    @resume = current_user.resumes.includes(:theme, :educations, :skills, :social_link,
                                            experiences: [:rich_text_content],
                                            cover_letter: [:rich_text_content]).friendly.find(params[:id])
  end

  def resume_params
    params.require(:resume).permit(:first_name, :last_name, :job_title, :country, :state, :phone_number, :email)
  end
end
