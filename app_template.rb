#
# Application Template
#
# Gemfile
#

# rails 
gem 'rails' , '3.2.11'

# pagination
gem 'kaminari'

# form
gem 'simple_form'

# login 
gem 'devise'

# auth
gem 'cancan'

# process monitor
# gem 'god', require: false

# rails-sh
gem 'rails-sh', require: false

# config
gem 'rails_config'

# haml integration
if yes?("Would you like to HAML layout?(yes, no)")
  gem 'haml-rails'
end

gem_group :deployment do
  gem 'debugger'
  # capistrano
  if yes?("Would you like to Capistrano?(yes, no)")
    gem 'rvm-capistrano'
    gem 'capistrano'
    gem 'capistrano-ext'
    gem 'capistrano_colors'
    gem 'capistrano_rsync_with_remote_cache'
  end
  # erd
  gem 'rails-erd'
end

gem_group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem_group :test, :development do
  # test
  gem 'sqlite3'
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem 'faker'
end

gem_group :production do
  if yes?("Production Database Which to Use ?(yes=MySql2, no-PostgreSQL)")
    gem 'mysql2'
  else
    gem 'pg'
  end
end

# twitter bootstrap
gems = {}
gems[:bootstrap] = yes?("Would you like to install bootstrap?")
if gems[:bootstrap]
  gem_group :development do
    gem 'twitter-bootstrap-rails'
  end
  gem 'bootstrap-sass', group: 'assets'
  gem 'bootswatch-rails', group: 'assets'
end

# nokogiri
if yes?("Would you like to install nokogiri?")
  gem 'nokogiri'
end

# kaminari
if yes?("Would you like to install RailsAdmin?")
  gem 'rails_admin'
end

#
# Bundle install
#
run "bundle install"

#
# Files and Directories
#

# use Rspec instead of TestUnit
remove_dir 'test'

application <<-APPEND_APPLICATION
config.generators do |generate|
      generate.test_framework   :rspec, :fixture => true, :views => false
      generate.integration_tool :rspec, :fixture => true, :views => true
    end
APPEND_APPLICATION

remove_file "public/index.html"
remove_file "app/views/layouts/application.html.erb"

#
# Generators
#
if gems[:bootstrap]
  generate 'bootstrap:install'

  if yes?("Would you like to create FIXED layout?(yes=FIXED, no-FLUID)")
    generate 'bootstrap:layout application fixed'
  else
    generate 'bootstrap:layout application fluid'
  end
end

generate 'rspec:install'

generate 'rails_config:install'
