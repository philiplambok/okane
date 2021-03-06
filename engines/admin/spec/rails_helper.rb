# frozen_string_literal: true

# Engine root is used by rails_configuration to correctly
# load fixtures and support files
ENGINE_ROOT = Pathname.new(File.expand_path("..", __dir__))

ENV["RAILS_ENV"] = "test"
ENV["BOOTSNAP_CACHE_DIR"] = File.join(ENGINE_ROOT, "spec", "internal", "tmp", "cache")

require "bootsnap/setup"

require "combustion"
require "shared/testing/ext/combustion_bundler_patch"

begin
  # Add another Rails part, e.g.
  # Combustion.initialize! :active_record, :active_job, :active_storage, :action_mailer, :action_controller
  Combustion.initialize! :active_record, bundler_groups: :admin do
    config.logger = Logger.new(nil)
    config.log_level = :fatal

    config.autoloader = :zeitwerk

    # Always use test adapter for active_job
    # config.active_job.queue_adapter = :test
    #
    # Always use test service to active_storage
    # config.active_storage.service = :test
    #
    # Enable verbose logging for active_record
    # config.active_record.verbose_query_logs = true
  end
rescue => e
  # Fail fast if application couldn't be loaded
  $stdout.puts "Failed to load the app: #{e.message}\n#{e.backtrace.take(5).join("\n")}"
  exit(1)
end

# if you need url helpers (e.g. with active storage)
# Rails.application.default_url_options[:host] = "localhost"
# Admin::Engine.routes.default_url_options[:host] = "localhost"

require "shared/testing/rails_configuration"

# action_policy helpers
# require "action_policy/rspec"
# require "action_policy/rspec/dsl"

# Additional RSpec configuration
#
# RSpec.configure do |config|
#   config.after(:suite) do
#     # Cleanup attachments generated during tests
#     FileUtils.rm_rf(ActiveStorage::Blob.service.root)
#   end
# end
