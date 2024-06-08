# CareerCrafterPro

This README would normally document whatever steps are necessary to get the
application up and running.

- Ruby version

* Ruby 2.7.1 🔻
* Rails 7.0.6 🔻

- System dependencies

##### Configuration

- create an `application.yml` file in the root of your project it will be gitignored and is needed to handle our environment variables. Reference the `.env.example` file and copy the keys and update their values for your local dev environment.

##### Database creation

- run `rake db:setup`
- run `rake db:migrate` - migrations or db updates

- run `rails s` to start the application

##### Admin creation

- you will need to first set `ADMIN_EMAIL` in you application.yml file as an environment variable
- Next create an account in career crafter pro using `ADMIN_EMAIL` for account creation
- then run `rake admin:upgrade_to_admin` from the console to upgrade the email to become an admin user
- the account you created for `ADMIN_EMAIL` should now have access to the admin dashboard

##### How to run the test suite

- to run test suite: `bundle exec rspec`
- to generate a coverage report: `COVERAGE=true bundle exec rspec`
- to view the code coverage in a web browser: from your the root dir & terminal run: `open coverage/index.html`

* Services TBD (job queues, cache servers, search engines, gems, etc.)

##### Active storage usage Rails 7

- Rich text data for enhanced User experiences.
  Create a Post or write a Comment and save the inputs as html to the database i.e emojis, fonts, etc. Data can be found in the table `action_text_rich_texts` and references the origin model.

##### Bullet gem and sql optimization popups

- To disable bullet gem popups comment out or set the value to `false` for:
  `Bullet.alert = true` in development.rb
- To disable bullet fully, set: `Bullet.enable = true` to false

- However it is a good idea to resolve or work around n+! issues as they degrade performance.

##### Mailer services

- We use the letter opener gem to simulate email authentication and confirmation in `development env`.
- We use AWS SES in `production env`.

##### Deployment instructions

- If you choose to clone this repo and want to deploy, you will need a new master-key (gitignored and used to decrypt) and a new `credentials.ymc.enc` file (which you will check-in to version control).

##### Contributing

- Adding new templates and themes:

* 🧩 Make sure you use the correct prefix i.e `free` vs `premium` followed by the design name.
* 🧩 Create a new file `[my pdf design name].pdf.haml` in the appropriate resume themes folder structure.
* 🧩 For the time being css for .pdf themes will stored in the wicked_pdf_stylesheets in the stylesheets folder structure they are called in the .pdf/.haml views responsible for rendering previews and the pdf itself, theya re self contained and intended to be used on haml partials that in turn are leveraged to for the pdf and it's haml previews throughout the app.
* 🧩 Update database with new theme name it should correspond to the correct .pdf file name `[my pdf design name].pdf.haml`.
* 🧩 Finally add the theme name to the assets initializers precompile list this allows the wicked pdf stylesheet to load
