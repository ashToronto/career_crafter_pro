module ApplicationHelper
  def sample_resume
    Resume.new(
      first_name: 'John',
      last_name: 'Doe',
      job_title: 'Software Developer',
      email: 'john.doe@example.com',
      phone_number: '+1234567890',
      skills: [Skill.new(name: 'Ruby on Rails'), Skill.new(name: 'JavaScript'), Skill.new(name: 'React')],
      experiences: [Experience.new(
        {
          company_name: 'Tech Inc.',
          job_title: 'Senior Developer',
          start_date: Date.new(2018, 1, 1),
          end_date: Date.today
        }
      )],
      educations: [Education.new(
        {
          institution_name: 'University of Tech',
          location: 'learning lane, New York, USA',
          degree: 1,
          start_date: Date.new(2010, 1, 1),
          end_date: Date.new(2014, 1, 1)
        }
      )]
    )
  end
end
