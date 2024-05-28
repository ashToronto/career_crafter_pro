class ResumeScoreService
  def initialize(resume:)
    @resume = resume
  end

  def calculate_completion_score
    score = 0
    max_score = 100

    # Weighted values
    weights = {
      experiences: 30,
      educations: 20,
      skills: 20,
      cover_letter: 30
    }

    score += weights[:experiences] if @resume.experiences.any?
    score += weights[:educations] if @resume.educations.any?
    score += weights[:skills] if @resume.skills.any?
    score += weights[:cover_letter] if @resume.cover_letter.present?

    [score, max_score].min
  end
end
