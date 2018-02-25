require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.default_locale = :en
    CarrierWave.configure do |config|
        config.root = Rails.root
    end
    config.sass.load_paths << File.expand_path('../../vendor/assets/components/')
    config.sass.load_paths << File.expand_path('../../vendor/assets/components/')
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { :host => 'localhost', :port => 3000 }
    config.action_mailer.smtp_settings = {
        :address              => "smtp.gmail.com",
        :port                 => "587",
        :domain               => "gmail.com",
        :user_name            => "revistaabacontato@gmail.com",
        :password             => "6yhn@7ujm",
        :authentication       => :plain,
        :enable_starttls_auto => true # I don't have this, but it should work anyway
    }
    config.log_level = :info

    config.assets.compile = true
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
  	#config.to_prepare do
    #Devise::Mailer.layout "atHome_mailer" # email.haml or email.erb
  	#end
    config.to_prepare do
      # Or to configure mailer layout
      Devise::Mailer.layout "athome_mailer" # email.haml or email.erb
    end
    Rack::Utils.multipart_part_limit = 0

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :domum_view
      g.fallbacks[:domum_view] = :erb
      g.test_framework  :test_unit, fixture: true
      #g.scaffold_controller :domum_controller
      #g.fallbacks[:domum_controller]  = :scaffold_controller
    end

    # File Custom application set all custom information about your app
    eval(File.read('config/custom_application.rb'))
  end
end
