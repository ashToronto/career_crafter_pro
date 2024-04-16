class SocialLinksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_resume
  before_action :set_social_link, only: %i[edit update destroy]

  def new
    @social_link = @resume.build_social_link
  end

  def create
    @social_link = @resume.build_social_link(social_link_params)
    if @social_link.save
      redirect_to resume_path(@resume), notice: 'Social links were successfully added.'
    else
      puts @social_link.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @social_link.destroy
    redirect_to resume_path(@resume), notice: 'Links section was successfully removed.'
  end

  def edit; end

  def update
    if @social_link.update(social_link_params)
      redirect_to resume_path(@resume), notice: 'Social links were successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_resume
    @resume = current_user.resumes.find(params[:resume_id])
  end

  def set_social_link
    @social_link = @resume.social_link
  end

  def social_link_params
    params.require(:social_link).permit(:linkedin_url, :github_url, :twitter_url, :youtube_url, :facebook_url,
                                        :instagram_url, :personal_website_url)
  end
end
