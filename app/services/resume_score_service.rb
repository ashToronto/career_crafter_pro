class ResumeScoreService
  def initialize(resume:)
    @resume = resume
  end

  def calculate_completion_score
    score = 0
    max_score = 100

    # Weighted values
    weights = {
      experiences: 15,
      educations: 10,
      skills: 2,
      cover_letter: 20,
      youtube_url: 5,
      github_url: 5,
      twitter_url: 5,
      instagram_url: 5,
      linkedin_url: 10,
      facebook_url: 5
    }

    score += weights[:experiences] if @resume.experiences.any?
    score += weights[:educations] if @resume.educations.any?
    score += weights[:skills] if @resume.skills.any?
    score += weights[:cover_letter] if @resume.cover_letter.present?
    score += weights[:youtube_url] if @resume.social_link.youtube_url.present?
    score += weights[:github_url] if @resume.social_link.github_url.present?

    score += weights[:twitter_url] if @resume.social_link.twitter_url.present?
    score += weights[:instagram_url] if @resume.social_link.instagram_url.present?
    score += weights[:linkedin_url] if @resume.social_link.linkedin_url.present?
    score += weights[:facebook_url] if @resume.social_link.facebook_url.present?

    [score, max_score].min
  end
end
