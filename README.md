# CareerCrafterPro

![CareerCrafterPro](https://logo-career-crafter-pro.s3.amazonaws.com/logo.png)

CareerCrafterPro is a web application that allows users to create, customize, and download resumes using a variety of predefined themes. This project is built with Ruby on Rails and utilizes several features including Active Storage Mailers Action Text.

## System Requirements

- **Ruby**: 3.0.0
- **Rails**: 7.1.2

## Getting Started

### Setup

#### Setting up Ruby 3.0.0

##### Windows OS
1. Install Ruby 3.0.0 from Ruby Installer
2. Git clone asdf repo to access asdf: git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
3. Install wsl on machine: wsl --install
4. sudo apt update
5. sudo apt install curl git autoconf dirmngr gpg build-essential
6. echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
7. echo '. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
8. source ~/.bashrc
9. asdf plugin add ruby
10. asdf install ruby 3.0.0

#### Setting up Rails 7.1.2.0

##### Windows OS
**In the directory in WSL that ruby was installed**
1. sudo apt-get install build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev
2. the current version of ruby is not 3.0.0, so run: asdf install ruby 3.0.0
3. ensure that the global version of ruby on your machine is the same run: asdf global ruby [my ruby version]
4. ensure that the global version of ruby on the current  is the same run: asdf local ruby [my ruby version]
5. put the correct version of ruby into environment variables: export PATH="$HOME/.asdf/shims:$PATH"
6. Install rails: Gem install rails

#### Setting up Postgres

##### Windows OS
1. [Download and Install Postgres] (https://www.postgresql.org/download/windows/)
2. sudo apt list --installed | grep postgresql
3. sudo apt install postgresql-client
4) sudo apt update
5) sudo apt install postgresql postgresql-contrib
6) sudo service postgresql status
7) sudo systemctl enable postgresql
8) sudo systemctl start postgresql



#### Setting up Development Environment

##### Windows OS
1. Clone the repository to your local machine linux environment.
2. install the necessary yaml libraries: sudo apt-get update
sudo apt-get install -y libyaml-dev
3. sudo apt-get update
sudo apt-get install -y libpq-dev
4. gem install pg -v '1.5.4'
5. Run `bundle install` to install the project dependencies.
6. Create an `application.yml` file in the root directory to store database login credentials(Use the `.env.example` file as a reference to set up necessary environment variables for your development environment.)

### Database Initialization

- Run `rake db:setup` to create and seed the database.
- Run `rake db:migrate` to apply database migrations.

### Running the Server

- Execute `rails s` to start the Rails server.

## Admin Account Setup

1. Set the `ADMIN_EMAIL` in your `application.yml` as an environment variable.
2. Register an account using the `ADMIN_EMAIL` address.
3. Execute `rake admin:upgrade_to_admin` in the console to grant admin privileges to the account. This account can now access the admin dashboard.

## Testing

- Run tests with: `bundle exec rspec`.
- Generate a coverage report: Set `COVERAGE=true bundle exec rspec`.
- Open the coverage report in a web browser by running `open coverage/index.html` from the root directory.

## Services

_Details about job queues, cache servers, search engines, and other services will be provided here._

## Using Active Storage in Rails 7

Active Storage facilitates rich text data management, enhancing user experiences with features like emojis and custom fonts in posts or comments. Data is saved as HTML in the `action_text_rich_texts` table.

## Optimization with Bullet Gem

The Bullet gem helps to identify N+1 queries and other common performance issues during development:

- To disable Bullet notifications, set `Bullet.alert = false` in `development.rb`.
- To turn off Bullet completely, set `Bullet.enable = false`.
- It is recommended to address the issues Bullet identifies to improve application performance.

## Email Services

- **Development**: Uses the Letter Opener gem for simulating email sending.
- **Production**: Configured to use AWS SES for email services.

## Deployment

If you are deploying this project:

- Ensure you have a new `master.key` (this is not version controlled).
- You will also need a new `credentials.yml.enc` file checked into version control.

## Contributing

To add new templates and themes:

- Use the correct prefix (`free` or `premium`) followed by the design name.
- Create a new file in the `app/views/themes` directory named `[my_pdf_design_name].pdf.haml`.
- Store CSS for the new themes in `app/assets/stylesheets/themes/[my_pdf_design_name.css]`.
- Add the theme name to the precompile list in `config/initializers/assets.rb` to ensure it loads correctly with Wicked PDF.
- Update the database to include the new theme name corresponding to the new `.pdf.haml` file via admin dashboard or rake task in `create_theme_names.rake`.

## Questions or Contributions

For any questions or contributions, please open an issue or submit a pull request.
