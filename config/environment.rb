# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem 'warden', :version => '=0.10.7', :source => 'http://gemcutter.org'
  config.gem 'devise', :version => '=1.0.8', :source => 'http://gemcutter.org'
  config.gem 'compass', :version => '= 0.10.5'
  config.gem 'haml', :version => '=3.0.21'
  config.gem 'formtastic', :version => '=1.1.0'
  config.gem 'responders', :version => '= 0.4.3'
  config.gem 'inherited_resources', :version => '= 1.0.6'
  config.gem 'will_paginate'
  config.gem 'paperclip'
  config.gem 'sqlite3-ruby', :lib => 'sqlite3'
  config.gem 'web-app-theme', :lib => 'web_app_theme', :version => '=0.5.3'
  config.gem 'acts_as_list'
  config.gem 'ambethia-recaptcha', :lib => 'recaptcha/rails', :source => 'http://gems.github.com'
  config.gem 'gravtastic', :version => '= 2.2.0'
  config.gem 'cyrillizer', :version => '=0.1.0'
  config.gem 'RedCloth', :version => '=4.2.3', :lib => 'redcloth'
  config.gem 'smurf', :version => '=1.0.4'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :mk
end

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "popravi.mk",
  :authentication => :plain,
  :user_name => "notifier@popravi.mk",
  :password => "popr@vi",
  :enable_starttls_auto => true
}

ENV['RECAPTCHA_PUBLIC_KEY']  = '6LfvIrwSAAAAAKV0Ovrn14kwKWDgA3bnck3Ob9SI'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LfvIrwSAAAAACtEBL-VhUT5fWTr_MRLGU9eV-k5'

