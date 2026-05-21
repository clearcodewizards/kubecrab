require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kubecrab
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.mission_control.jobs.http_basic_auth_enabled = false

    config.x.theme.menu = {
      "Your Crabs": ["cube", "/crabs"],
      "Deploy Crab": ["bolt", "/templates"]
    }
    config.x.theme.admin_menu = {
      "Crab Templates": ["bolt", "/admin/templates"],
      "Crab Engines": ["cpu-chip", "/admin/engines"],
      Users: ["users", "/admin/users"]
    }
    config.x.exclude_names = %w[app www]
    config.x.auto_deploy_template = nil # template id
  end
end
