# CareerCrafterPro

This README would normally document whatever steps are necessary to get the
application up and running.

- Ruby version

* Ruby 2.7.1 🔻
* Rails 7.0.6 🔻

- System dependencies

##### Configuration

- run `rails s` to start the application

##### Database creation

- run `rake db:setup`
- run `rake db:migrate` - migrations or db updates
- run `rake admin:create_admin` - to create mock admin user

##### How to run the test suite

- to run test suite: `bundle exec rspec`
- to generate a coverage report: `COVERAGE=true bundle exec rspec`
- to view the code coverage in a web browser: from your the root dir & terminal run: `open coverage/index.html`

* Services TBD (job queues, cache servers, search engines, gems, etc.)

- `gem cancancan` 🧩 for admin user managment & built over `devise` - if you assign another user admin privelages the current admin will no longer keep their admin status. There can be only one admin. This functionality is kept to ensure continuity of any business model i.e if the admin quits it can be passed on to the next in chain of leadership. 🧩

##### Active storage usage Rails 7

- Rich text data for enhanced User experiences.
  Create a Post or write a Comment and save the inputs as html to the database i.e emojis, fonts, etc. Data can be found in the table `action_text_rich_texts` and references the origin model.

##### Bullet gem and sql optimization popups

- To disable bullet gem popups comment out or set the value to `false` for:
  `Bullet.alert = true` in development.rb
- To disable bullet fully, set: `Bullet.enable = true` to false

- However it is a good idea to resolve or work around n+! issues as they degrade performance.

##### Deployment instructions

- If you choose to clone this repo and want to deploy, you will need a new master-key (gitignored and used to decrypt) and a new `credentials.ymc.enc` file (which you will check-in to version control).

##### Contributing

- Adding new templates and themes:

* 🧩 Make sure you use the correct prefix i.e `free` vs `premium` followed by the design name.
* 🧩 Create a new file `[my pdf design name].pdf.haml` in the appropriate resume themes folder structure.
* 🧩 For the time being css for .pdf themes will be inline css and isolated to only those files.
* 🧩 Update database with new theme name it should correspond to the correct .pdf file name `[my pdf design name].pdf.haml`
* 🧩 Add image/screenshot of the pdf design place under `assets/images/themes/[my pdf design name].png` make sure the design name of the file and image are consistant.

* 🧩 You will also need to run `rake themes:update_db` this will take the newly added `assets/images/themes/[my new pdf design name].png` and add it to the database. This means all theme names in the database will sync with the .png file names in the their respective images in assets. Alternatively you can manually enter the theme name via the admin dashboard as a backup approach if anything goes wrong with the rake task.
