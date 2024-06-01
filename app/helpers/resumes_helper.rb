module ResumesHelper
  def calculate_completion_score(resume)
    score = 0
    max_score = 100

    # Define the weights for each component
    weights = {
      experiences: 30,
      educations: 20,
      skills: 20,
      cover_letter: 30
    }

    # Add to score based on existence of resume parts
    score += weights[:experiences] if resume.experiences.any?
    score += weights[:educations] if resume.educations.any?
    score += weights[:skills] if resume.skills.any?
    score += weights[:cover_letter] if resume.cover_letter.present?

    # Ensure the score does not exceed the maximum allowed
    [score, max_score].min
  end
end
