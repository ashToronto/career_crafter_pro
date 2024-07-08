module Admin
  class ThemesController < Admin::AdminController
    before_action :set_theme, only: %i[edit update destroy]

    def index
      @themes = Theme.all
    end

    def new
      @theme = Theme.new
    end

    def edit
      @theme
    end

    def create
      @theme = Theme.new(theme_params)
      if @theme.save
        redirect_to [:admin, @theme], notice: 'Theme was successfully created.'
      else
        render :new
      end
    end

    def update
      if @theme.update(theme_params)
        redirect_to [:admin, @theme], notice: 'Theme was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      default_theme = Theme.find_by(name: 'free_default')

      # Check if the default theme is found and is not the same as the theme being destroyed
      if default_theme.present? && @theme.id != default_theme.id
        # Update all associated resumes to the default theme before destroying the theme
        Resume.where(theme_id: @theme.id).update_all(theme_id: default_theme.id)

        # Now attempt to destroy the theme
        notice = if @theme.destroy
                   'Theme was successfully destroyed and resumes were updated to the default theme.'
                 else
                   'Theme could not be destroyed.'
                 end
      else
        notice = 'Default theme not found or cannot destroy the default theme.'
      end
      redirect_to admin_themes_url, notice: notice
    end

    private

    def set_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:name, :active, :is_premium)
    end
  end
end
