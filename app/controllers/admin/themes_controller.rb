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
      @theme.destroy
      redirect_to admin_themes_url, notice: 'Theme was successfully destroyed.'
    end

    private

    def set_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:name, :active)
    end
  end
end
