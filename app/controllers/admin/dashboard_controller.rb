# app/controllers/admin/dashboard_controller.rb
module Admin
  class DashboardController < Admin::AdminController
    before_action :authenticate_user!
    before_action :check_admin

    def index
      @users = User.all
    end

    private

    def check_admin
      redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
    end
  end
end
