module ApplicationHelper
  def sample_resume
    resume = Resume.new(
      first_name: 'John',
      last_name: 'Doe',
      job_title: 'Software Developer',
      email: 'john.doe@example.com',
      phone_number: '+1234567890',
      skills: [Skill.new(name: 'Ruby on Rails'), Skill.new(name: 'JavaScript'), Skill.new(name: 'React')],
      educations: [Education.new(
        institution_name: 'University of Tech',
        location: 'Learning Lane, New York, USA',
        degree: 1,  # Assuming '1' correlates to an enum or similar representation
        start_date: Date.new(2010, 1, 1),
        end_date: Date.new(2014, 1, 1)
      )],
      social_link: SocialLink.new(
        linkedin_url: 'https://www.linkedin.com/in/example',
        github_url: 'https://www.github.com/example'
      )
    )

    # Creating and assigning a cover letter
    cover_letter = CoverLetter.new
    cover_letter.content = "I am very excited to apply for the Software Developer position. I believe my skills in Ruby on Rails and JavaScript make me a strong candidate."
    resume.cover_letter = cover_letter

    # Adding experiences
    resume.experiences.build(
      company_name: 'Tech Inc.',
      job_title: 'Senior Developer',
      start_date: Date.new(2018, 1, 1),
      end_date: Date.today
    ).content = "<ul><li>Developed scalable web applications using Ruby on Rails</li> <li>Lead a team of developers in agile project settings.</li> <li>Implemented RESTful APIs for mobile applications</li></ul>"

    resume
  end
end
