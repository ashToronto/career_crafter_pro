class ThemesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_resume
  before_action :ensure_default_theme, only: [:edit]

  def edit
    @themes = Theme.where(active: true) # Load all themes for selection
  end

  def update
    if @resume.update(theme_params)
      redirect_to @resume, notice: 'Resume theme updated successfully.'
    else
      @themes = Theme.all
      render :edit, alert: 'Unable to update theme.'
    end
  end

  private

  def set_resume
    @resume = current_user.resumes.find(params[:resume_id])
  end

  def theme_params
    params.require(:resume).permit(:theme_id)
  end

  def ensure_default_theme
    return if @resume.theme

    default_theme = Theme.find_by(name: 'free_default')
    @resume.update(theme: default_theme) if default_theme
  end
end
