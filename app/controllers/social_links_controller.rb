class SocialLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_social_link, only: %i[edit update destroy]
  before_action :ensure_at_least_one_social_link, only: [:create]

  def new
    @social_link = @resume.social_link || @resume.build_social_link
  end

  def create
    @social_link = @resume.build_social_link(social_link_params)
    @social_link.save!
    redirect_to resume_path(@resume), notice: 'Social links were successfully added.'
  rescue ActiveRecord::RecordInvalid
    redirect_to new_resume_social_link_path(@resume), alert: 'Not all Urls saved please use appropriate format'
  end

  def destroy
    @social_link.destroy!
    redirect_to resume_path(@resume), notice: 'Links section was successfully removed.'
  end

  def edit
    # No changes needed here
  end

  def update
    @social_link.update!(social_link_params)
    redirect_to resume_path(@resume), notice: 'Social links were successfully updated.'
  rescue ActiveRecord::RecordInvalid
    redirect_to edit_resume_social_link_path(@resume), alert: 'Not all Urls were saved please use appropriate format'
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
end
