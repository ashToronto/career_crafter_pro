class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  def dashboard
    @user_resumes = current_user.resumes
  end
end
