# frozen_string_literal: true

require "rails/engine"

module Admin
  class << self
    def configure
      yield Engine.config
    end
  end

  class Engine < ::Rails::Engine
    isolate_namespace Admin

    config.autoload_paths += Dir["#{config.root}/app/**/concerns"]

    initializer "admin" do |app|
      app.config.paths["db/migrate"].concat(config.paths["db/migrate"].expanded)

      # For migration_context (used for checking pending migrations)
      ActiveRecord::Migrator.migrations_paths += config.paths["db/migrate"].expanded.flatten

      engine_factories_path = root.join("spec", "factories")

      # This hook is provided by shared-factory gem
      ActiveSupport.on_load(:factory_bot) do
        FactoryBot.definition_file_paths.unshift engine_factories_path
      end
    end
  end
end
