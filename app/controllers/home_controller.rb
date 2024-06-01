class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[dashboard]

  def index
    return unless user_signed_in?

    redirect_to dashboard_path
  end

  def dashboard
    @user_resumes = current_user.resumes.includes(:theme, :experiences, :educations, :social_link, :skills,
                                                  :cover_letter).order(updated_at: :desc)
  end
end
