# spec/factories/social_links.rb
FactoryBot.define do
  factory :social_link do
    resume
    linkedin_url { 'http://linkedin.com/in/example' }
    github_url { 'http://github.com/example' }
    twitter_url { 'http://twitter.com/example' }
    youtube_url { 'http://youtube.com/example' }
    facebook_url { 'http://facebook.com/example' }
    instagram_url { 'http://instagram.com/example' }
    personal_website_url { 'http://example.com' }
  end
end
