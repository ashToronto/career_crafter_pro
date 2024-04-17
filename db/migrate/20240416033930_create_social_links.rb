class CreateSocialLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :social_links do |t|
      t.references :resume, null: false, foreign_key: true
      t.string :linkedin_url
      t.string :github_url
      t.string :twitter_url
      t.string :youtube_url
      t.string :facebook_url
      t.string :instagram_url
      t.string :personal_website_url

      t.timestamps
    end
  end
end
