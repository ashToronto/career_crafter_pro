class Admin::UsersController < Admin::AdminController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_user, only: %i[show update destroy]

  def show
    # User is set by set_user
  end

  def update
    if @user.update(user_params)
      redirect_to [:admin, @user], notice: 'User updated successfully.'
    else
      render :show
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_root_path, alert: 'User deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def check_admin
    redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
  end
end
