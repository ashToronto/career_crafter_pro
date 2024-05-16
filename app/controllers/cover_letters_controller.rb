class CoverLettersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resume
  before_action :set_cover_letter, only: %i[edit update destroy]

  def new
    if @resume.cover_letter.present?
      redirect_to edit_resume_cover_letter_path(@resume)
    else
      @cover_letter = @resume.build_cover_letter
    end
  end

  def edit; end

  def create
    @cover_letter = @resume.build_cover_letter(cover_letter_params)
    if @cover_letter.save
      redirect_to resume_path(@resume), notice: 'Cover Letter was successfully added.'
    else
      render :new
    end
  end

  def update
    if @cover_letter.update(cover_letter_params)
      redirect_to resume_path(@resume), notice: 'Cover Letter was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cover_letter.destroy
    redirect_to resume_path(@resume), notice: 'Cover Letter was successfully removed.'
  end

  private

  def set_resume
    @resume = current_user.resumes.friendly.find(params[:resume_id])
  end

  def set_cover_letter
    @cover_letter = @resume.cover_letter
  end

  def cover_letter_params
    params.require(:cover_letter).permit(:content)
  end
end
