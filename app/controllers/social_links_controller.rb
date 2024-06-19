class SocialLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_social_link, only: %i[edit update destroy]
  before_action :ensure_at_least_one_social_link, only: [:create]

  def new
    @social_link = @resume.social_link || @resume.build_social_link
  end

  def create
    @social_link = @resume.build_social_link
    results = save_individual_links

    if results.values.all?
      redirect_to resume_path(@resume), notice: 'Social links were successfully added.'
    else
      flash[:alert] = construct_error_message(results)
      render :new
    end
  end

  def destroy
    @social_link.destroy!
    redirect_to resume_path(@resume), notice: 'Links section was successfully removed.'
  end

  def edit
    # No changes needed here
  end

  def update
    results = save_individual_links

    if results.values.all?
      redirect_to resume_path(@resume), notice: 'Social links were successfully updated.'
    else
      flash[:alert] = construct_error_message(results)
      render :edit
    end
  end

  private

  def set_resume
    @resume = current_user.resumes.friendly.find(params[:resume_id])
  end

  def set_social_link
    @social_link = @resume.social_link || @resume.build_social_link
  end

  def social_link_params
    params.require(:social_link).permit(:linkedin_url, :github_url, :twitter_url, :youtube_url, :facebook_url,
                                        :instagram_url, :personal_website_url)
  end

  def ensure_at_least_one_social_link
    return unless social_link_params.values.all?(&:blank?)

    flash[:alert] = 'At least one social link must be provided.'
    redirect_to new_resume_social_link_path
  end

  def save_individual_links
    results = {}
    social_link_params.each do |key, value|
      next if value.blank?

      @social_link.assign_attributes({ key => value })
      if @social_link.validate!(key)
        @social_link.save(validate: false) # Save without further validation
        results[key] = true
      else
        results[key] = false
      end
    end
    results
  end

  def construct_error_message(results)
    "Some URLs couldn't be saved: " + results.select { |_k, v| !v }.keys.join(', ')
  end
end
