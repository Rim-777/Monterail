require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module ImportApp
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller
    config.active_job.queue_adapter = :sidekiq
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_spec: false,
                       helper_specs: false,
                       routing_specs: false,
                       reuest_specs: false,
                       controller_spec: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
